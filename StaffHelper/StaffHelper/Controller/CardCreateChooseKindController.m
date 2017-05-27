//
//  CardCreateChooseKindController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardCreateChooseKindController.h"

#import "CardKindListInfo.h"

#import "CardKindCell.h"

#import "CardChooseStudentController.h"

#import "CardCreateChooseGymController.h"

#import "CardCreateChooseSpecController.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface CardCreateChooseKindController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)CardKindListInfo *info;

@property(nonatomic,strong)MOTableView *tableView;

@end

@implementation CardCreateChooseKindController

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
        
        [self.info requestCardWithGymYF:self.gym];
        
    }else
    {
        // 暂无 入口，品牌下都需要选择场馆
        [self.info requestYFForBrand];
        
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
    
    return [self.info getShowArrayWithType:CardKindTypeNone andState:CardKindStateNormal andGym:nil].count;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CardKind *kind = [self.info getShowArrayWithType:CardKindTypeNone andState:CardKindStateNormal andGym:nil][indexPath.row];
    
    NSString *gymStr = @"适用场馆：";
    
    for (NSInteger i = 0; i<kind.gyms.count; i++) {
        
        Gym *gym = kind.gyms[i];
        
        gymStr = [gymStr stringByAppendingString:gym.name];
        
        if (i<kind.gyms.count-1) {
            
            gymStr = [gymStr stringByAppendingString:@"，"];
            
        }
        
    }
    
    NSString *astrictStr = kind.astrict.length?[NSString stringWithFormat:@"限制：%@",kind.astrict]:@"限制：无";
    
    CGSize size = [gymStr boundingRectWithSize:CGSizeMake(MSW-Width320(44), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: AllFont(12)} context:nil].size;
    
    CGSize astrictSize = [astrictStr boundingRectWithSize:CGSizeMake(MSW-Width320(44), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
    
    return Height320(148)+size.height+astrictSize.height;
    
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
    
    CardKind *kind = [self.info getShowArrayWithType:CardKindTypeNone andState:CardKindStateNormal andGym:nil][indexPath.row];
    
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
    
    CardKind *cardKind = [self.info getShowArrayWithType:CardKindTypeNone andState:CardKindStateNormal andGym:nil][indexPath.row];
    
    if (self.gym){
        
        CardChooseStudentController *svc = [[CardChooseStudentController alloc]init];
        
        svc.cardKind = cardKind;
        
        svc.gym = self.gym;
        
        if (self.student) {
            
            svc.student = self.student;
            
        }
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
