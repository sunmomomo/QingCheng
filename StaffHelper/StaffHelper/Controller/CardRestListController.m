//
//  CardRestListController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardRestListController.h"

#import "CardRestListInfo.h"

#import "MOTableView.h"

#import "CardRestCell.h"

#import "CardRestAddController.h"

#import "CardListController.h"

#import "CardDetailController.h"

#import "YFAppService.h"

#import "YFBackOfLeaveVC.h"

static NSString *identifier = @"Cell";

@interface CardRestListController ()<MOTableViewDatasource,UITableViewDelegate,CardRestCellDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)CardRestListInfo *info;

@property(nonatomic,strong)MOTableView *tableView;

@end

@implementation CardRestListController

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
    
    self.info = [[CardRestListInfo alloc]init];
    
    __weak typeof(self)weakS = self;
    
    self.info.requestFinish = ^(BOOL success){
        
        weakS.tableView.dataSuccess = success;
        
        [weakS.tableView reloadData];
        
    };
    
    [self.info requestWithCard:self.card];
    
}

-(void)reloadData
{
    
    __weak typeof(self)weakS = self;
    
    CardRestListInfo *info = [[CardRestListInfo alloc]init];
    
    __weak typeof(CardRestListInfo*)weakInfo = info;
    
    info.requestFinish = ^(BOOL success){
        
        weakS.info = weakInfo;
        
        weakS.tableView.dataSuccess = success;
        
        [weakS.tableView reloadData];
        
    };
    
    [info requestWithCard:self.card];
    
}

-(void)createUI
{
    
    self.title = @"请假记录";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.rightType = MONaviRightTypeAdd;
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableHeaderView = [UIView new];
    
    [self.tableView registerClass:[CardRestCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.info.rests.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CardRestCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    CardRest *rest = self.info.rests[indexPath.row];
    
    cell.restStatus = rest.status;

    cell.title = rest.message;
    
    cell.startTime = rest.start;
    
    cell.endTime = rest.end;
    
    cell.receive = rest.price;

    cell.remarkHeight = rest.remarkHeight;

    cell.remark = rest.remark;

    rest.cellHeight = [cell getCellHeight];
    
    cell.operateTime = rest.operateTime;
    
    cell.staffName = rest.staffName;
    
    
    cell.delegate = self;
    
    cell.stateStr = @"进行中";
    
    cell.tag = indexPath.row;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(void)deleteRest:(UIButton *)btn
{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认删除该请假？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
    
    alert.tag = btn.tag;
    
    [alert show];
    
}

// 提前销假
-(void)backOfLeaveAction:(UIButton *)btn
{
    if (self.info.rests.count <= btn.tag) {
        return;
    }
    CardRest *rest = self.info.rests[btn.tag];

    YFBackOfLeaveVC *backOfLeaVC = [[YFBackOfLeaveVC alloc] init];
    
    backOfLeaVC.card = self.card;
    
    backOfLeaVC.cardRest = rest;
    
    backOfLeaVC.gym = self.gym;
    
    [self.navigationController pushViewController:backOfLeaVC animated:YES];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
 
    if (buttonIndex == 1) {
        
        CardRest *rest = self.info.rests[alertView.tag];
        
        __weak typeof(self)weakS = self;
        
        [self.info cancelRest:rest result:^(BOOL success, NSString *result) {
            
            [weakS createData];
            
            for (MOViewController *vc in weakS.navigationController.viewControllers) {
                
                if ([vc isKindOfClass:[CardListController class]]) {
                    
                    [vc reloadData];
                    
                }
                
                if ([vc isKindOfClass:[CardDetailController class]]) {
                    
                    [vc reloadData];
                    
                }
                
            }
            
        }];
        
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CardRest *rest = self.info.rests[indexPath.row];
    if (rest.cellHeight > 0)
    {
    return rest.cellHeight;
    }
    
    if (rest.status == CardRestStatusNormal) {
        
        return Width320(165)+1 + rest.remarkHeight;
        
    }else{
        
        return Width320(125) + rest.remarkHeight;
        
    }
    
}

-(void)naviRightClick
{
    
    CardRestAddController *svc = [[CardRestAddController alloc]init];
    
    svc.card = self.card;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64)];
    
    view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(84), Height320(107), Width320(160), Height320(144))];
    
    emptyImg.image = [UIImage imageNamed:@"card_rest_empty"];
    
    [view addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, emptyImg.bottom+Height320(18), MSW, Height320(18))];
    
    emptyLabel.text = @"暂无请假记录";
    
    emptyLabel.textColor = UIColorFromRGB(0x999999);
    
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    emptyLabel.font = AllFont(14);
    
    [view addSubview:emptyLabel];
    
    return view;
    
}

@end
