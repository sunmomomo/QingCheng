
//
//  CardFilterChooseKindController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardFilterChooseKindController.h"

#import "CardKindListInfo.h"

#import "CardKindCell.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface CardFilterChooseKindController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)CardKindListInfo *info;

@end

@implementation CardFilterChooseKindController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    self.info = [[CardKindListInfo alloc]init];
    
    __weak typeof(self)weakS = self;
    
    self.info.requestFinish = ^(BOOL success){
        
        weakS.tableView.dataSuccess = success;
        
        [weakS.tableView reloadData];
        
    };
    
    if (self.gym) {
        
        [self.info requestWithGym:self.gym];
        
    }else
    {
        
        [self.info request];
        
    }
    
}

-(void)createUI
{
    
    self.title = @"选择会员卡种类";
    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[CardKindCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.info.cardKinds.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CardKind *kind = self.info.cardKinds[indexPath.row];
    
    NSString *gymStr = @"适用场馆：";
    
    for (NSInteger i = 0; i<kind.gyms.count; i++) {
        
        Gym *gym = kind.gyms[i];
        
        gymStr = [gymStr stringByAppendingString:gym.name];
        
        if (i<kind.gyms.count-1) {
            
            gymStr = [gymStr stringByAppendingString:@"，"];
            
        }
        
    }
    
    CGSize size = [gymStr boundingRectWithSize:CGSizeMake(MSW-Width320(44), CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: AllFont(12)} context:nil].size;
    
    return Height320(162)+size.height;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return Height320(5);
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(5))];
    
    view.backgroundColor = [UIColor clearColor];
    
    return view;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CardKindCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    CardKind *kind = self.info.cardKinds[indexPath.row];
    
    cell.cardKindType = kind.type;
    
    cell.cardKindName = kind.cardKindName;
    
    cell.cardId = kind.cardKindId;
    
    cell.astrict = kind.astrict;
    
    cell.summary = kind.summary;
    
    cell.gyms = kind.gyms;
    
    cell.backColor = kind.color;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CardKind *cardKind = self.info.cardKinds[indexPath.row];
    
    if (self.chooseFinish) {
        
        self.chooseFinish(cardKind);
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)naviLeftClick
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
