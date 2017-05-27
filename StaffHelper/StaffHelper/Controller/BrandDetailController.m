//
//  BrandDetailController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/13.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "BrandDetailController.h"

#import "BrandGymCell.h"

#import "BrandEditController.h"

#import "GymListInfo.h"

#import "BrandDetailInfo.h"

#import "GuideSetGymController.h"

#import "MOTableView.h"

#import "YFAppConfig.h"

#import "YFHttpService+Extension.h"

#import "UIView+YFLoadingView.h"

#import "RootController.h"

#import "YFAppService.h"

#import "BrandListInfo.h"

#import "YFRequestHeader.h"


static NSString *identifier = @"Cell";

@interface BrandDetailController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)UIImageView *backImgView;

@property(nonatomic,strong)UIView *backBlackView;

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *cnameLabel;

@property(nonatomic,strong)GymListInfo *gymInfo;

@property(nonatomic,strong)BrandDetailInfo *brandInfo;

// Cell的删除方法
@property(nonatomic, copy)void(^deleteBlock)(NSInteger);


@end

@implementation BrandDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    weakTypesYF
    [self setDeleteBlock:^(NSInteger tag){
        [weakS deleteAction:tag];
    }];

    [self createUI];
    
    [self createData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    // 品牌个数 不知道的情况下，去请求
    if (self.brandCount == 0)
    {
        BrandListInfo *listInfo =  [[BrandListInfo alloc]init];
        
        weakTypesYF
        __weak typeof(listInfo)weakInfor = listInfo;
        [listInfo requestResult:^(BOOL success, NSString *error) {
            weakS.brandCount = weakInfor.brands.count;
        }];
    }
 

    self.gymInfo = [[GymListInfo alloc]init];
    
    self.brandInfo = [[BrandDetailInfo alloc]init];
    
    [self reloadData];
    
}

-(void)reloadData
{
    [self.brandInfo requestWithBrand:self.brand result:^(BOOL success, NSString *error, Brand *brand) {
        
        if (success) {
            
            self.brand = brand;
            
            self.title = self.brand.name;
            
            if (self.brand.imgURL.absoluteString.length) {
                
                [self.iconView sd_setImageWithURL:self.brand.imgURL placeholderImage:[UIImage imageNamed:@"gymplaceholder"]];
                
                [self.backImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@!gaussblur",self.brand.imgURL.absoluteString]] placeholderImage:[UIImage imageNamed:@"bg_brand"]];
                
                self.backBlackView.hidden = NO;
                
            }else{
                
                self.iconView.image = [UIImage imageNamed:@"gymplaceholder"];
                
                self.backImgView.image = [UIImage imageNamed:@"bg_brand"];
                
                self.backBlackView.hidden = YES;
                
            }
            
            self.cnameLabel.text = [NSString stringWithFormat:@"品牌ID：%@    创建人：%@",self.brand.cname.length?self.brand.cname:@"",self.brand.owner.name.length?self.brand.owner.name:@"      "];
            
        }
        
    }];
    
    [self.gymInfo requestWithBrand:self.brand result:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.rightType = MONaviRightTypeEdit;
    
    self.title = self.brand.name;
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *tableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(157))];
    
    tableHeader.backgroundColor = [UIColor clearColor];
    
    self.tableView.tableHeaderView = tableHeader;
    
    [self.tableView sendSubviewToBack:tableHeader];
    
    self.backImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(125))];
    
    [tableHeader addSubview:self.backImgView];
    
    self.backBlackView = [[UIView alloc]initWithFrame:self.backImgView.frame];
    
    self.backBlackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.38];
    
    [tableHeader addSubview:self.backBlackView];
    
    self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(24), Width320(50), Height320(50))];
    
    self.iconView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.iconView.layer.cornerRadius = _iconView.width/2;
    
    self.iconView.layer.masksToBounds = YES;
    
    self.iconView.layer.borderWidth = 1;
    
    self.iconView.layer.borderColor = [UIColorFromRGB(0xffffff) colorWithAlphaComponent:0.6].CGColor;
    
    if (self.brand.imgURL.absoluteString.length) {
        
        [self.iconView sd_setImageWithURL:self.brand.imgURL placeholderImage:[UIImage imageNamed:@"gymplaceholder"]];
        
        [self.backImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@!gaussblur",self.brand.imgURL.absoluteString]] placeholderImage:[UIImage imageNamed:@"bg_brand"]];
        
        self.backBlackView.hidden = NO;
        
    }else{
        
        self.iconView.image = [UIImage imageNamed:@"gymplaceholder"];
        
        self.backImgView.image = [UIImage imageNamed:@"bg_brand"];
        
        self.backBlackView.hidden = YES;
        
    }
    
    [tableHeader addSubview:self.iconView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.iconView.right+Width320(12), Height320(30), MSW-Width320(28)-self.iconView.right, Height320(20))];
    
    self.titleLabel.font = AllFont(16);
    
    self.titleLabel.text = self.brand.name;
    
    self.titleLabel.textColor = UIColorFromRGB(0xffffff);
    
    [tableHeader addSubview:self.titleLabel];
    
    self.cnameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom+Height320(4), self.titleLabel.width, Height320(16))];
    
    self.cnameLabel.font = AllFont(13);
    
    self.cnameLabel.text = [NSString stringWithFormat:@"品牌ID：%@    创建人：%@",self.brand.cname.length?self.brand.cname:@"",self.brand.owner.name.length?self.brand.owner.name:@"      "];
    
    self.cnameLabel.textColor = UIColorFromRGB(0xffffff);
    
    [tableHeader addSubview:self.cnameLabel];
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(12), Height320(100), MSW-Width320(24), Height320(46))];
    
    addButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    addButton.layer.cornerRadius = Width320(2);
    
    addButton.layer.shadowOffset = CGSizeMake(0, 1);
    
    addButton.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
    
    addButton.layer.shadowOpacity = 0.17;
    
    [tableHeader addSubview:addButton];
    
    UIImageView *addImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(110), Height320(15), Width320(16), Height320(16))];
    
    addImg.image = [UIImage imageNamed:@"seller_add"];
    
    [addButton addSubview:addImg];
    
    UILabel *addLabel = [[UILabel alloc]initWithFrame:CGRectMake(addImg.right+Width320(8), 0, Width320(120), Height320(46))];
    
    addLabel.text = @"新增场馆";
    
    addLabel.textColor = kMainColor;
    
    addLabel.font = AllFont(14);
    
    [addButton addSubview:addLabel];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[BrandGymCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];
    
    [addButton addTarget:self action:@selector(addGym) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)goToDeleteAction:(NSInteger )tag
{
    NSUInteger index = tag - 1;
    
    if (self.gymInfo.gyms.count <= index)
    {
        return;
    }
    
    Gym *gym = self.gymInfo.gyms[index];
    
    if (gym.gymId <= 0)
    {
        return;
    }
    
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:kDeleteGymYF,(long)gym.gymId]];
    
    weakTypesYF
    [YFHttpService deleteSuccessOrFail:urlString parameters:nil modelClass:nil showLoadingOnView:self.view success:^(YFRespoStatusModel * _Nullable statusModel, YFRespoDataModel * _Nullable dataModel) {
        
        [weakS.gymInfo.gyms removeObjectAtIndex:index];
        [weakS.tableView reloadData];
        
        [weakS.view showHint:@"删除成功"];
        
        
        [[RootController sharedSliderController]createDataResult:^{
            
        }];
        
        if (weakS.brandCount == 1 && weakS.gymInfo.gyms.count == 0)
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakS.navigationController popToRootViewControllerAnimated:YES];
            });
        }
        
        
//        [weakS reloadData];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

- (void)deleteAction:(NSInteger )tag
{
    weakTypesYF
    [YFAppService showAlertMessage:@"确认删除该场馆？" sureTitle:@"确认" sureBlock:^{
        [weakS goToDeleteAction:tag];
    }];
}


-(void)addGym
{
    
    GuideSetGymController *svc = [[GuideSetGymController alloc]init];
    
    Course *course = [[Course alloc]initNewCourse];
    
    course.gym.brand = self.brand;
    
    ((AppDelegate *)[UIApplication sharedApplication].delegate).course = course;
    
    [self.navigationController pushViewController:svc animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.gymInfo.gyms.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BrandGymCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Gym *gym = self.gymInfo.gyms[indexPath.row];
    
    cell.title = gym.name;
    
    cell.phone = gym.contact;
    
    cell.superuserName = gym.superuser.name;
    
    cell.iconURL = gym.imgUrl;
    
    cell.position = gym.position;
    
    cell.pro = gym.pro;
    
    cell.deleteButton.tag = indexPath.row + 1;

    cell.deleteBlock = self.deleteBlock;

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(111);
    
}

-(void)naviRightClick
{
    
    BrandEditController *svc = [[BrandEditController alloc]init];
    
    svc.brand = [self.brand copy];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    UIView *emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(180), MSW, Height320(318))];
    
    emptyView.backgroundColor = [UIColor clearColor];
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW/2-Width320(124)/2, Height320(68), Width320(124), Height320(105))];
    
    emptyImg.image = [UIImage imageNamed:@"brand_gym_empty"];
    
    [emptyView addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(10), emptyImg.bottom+Height320(15), emptyView.width-Width320(20), Height320(36))];
    
    emptyLabel.text = @"该品牌下暂无场馆\n点击上方按钮新增场馆";
    
    emptyLabel.textColor = UIColorFromRGB(0x999999);
    
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    emptyLabel.font = AllFont(13);
    
    emptyLabel.numberOfLines = 0;
    
    [emptyView addSubview:emptyLabel];
    
    return emptyView;
    
}


@end
