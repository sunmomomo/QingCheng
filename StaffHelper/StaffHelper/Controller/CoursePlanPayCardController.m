//
//  CoursePlanPayCardController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/2/21.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "CoursePlanPayCardController.h"

#import "MOTableView.h"

#import "QCTextFieldCell.h"

#import "CardKindListInfo.h"

#import "MOSwitchCell.h"

#import "KeyboardManager.h"

static NSString *identifier = @"Cell";

@interface CoursePlanPayCardController ()<MOTableViewDatasource,UITableViewDelegate,MOSwitchCellDelegate,QCTextFieldCellDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)NSIndexPath *currentIndexPath;

@property(nonatomic,strong)CardKindListInfo *info;

@property(nonatomic,strong)NSArray *cardKinds;

@property(nonatomic,assign)BOOL canClick;

@property(nonatomic,strong)UIView *emptyView;

@end

@implementation CoursePlanPayCardController

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)reloadData
{
    
    NSInteger capacity = self.plan?self.plan.course.capacity:self.batch.course.capacity;
    
    CourseType courseType = self.plan?self.plan.course.type:self.batch.course.type;
    
    for (CardKind *cardKind in self.cardKinds) {
        
        if (!cardKind.isUsed) {
            
            [cardKind.costs removeAllObjects];
            
        }else
        {
            
            if (cardKind.type != CardKindTypeTime) {
                
                if (cardKind.costs.count<capacity) {
                    
                    for (NSInteger i = cardKind.costs.count ; i<capacity; i++) {
                        
                        CardCost *cost = [[CardCost alloc]init];
                        
                        cost.fromNumber = i+1;
                        
                        cost.toNumber = i+2;
                        
                        if (courseType == CourseTypeGroup) {
                            
                            CardCost *tempCost = [cardKind.costs firstObject];
                            
                            cost.perCost = tempCost.perCost;
                            
                            cost.costString = tempCost.costString;
                            
                        }
                        
                        [cardKind.costs addObject:cost];
                        
                    }
                    
                }else if (cardKind.costs.count >capacity){
                    
                    cardKind.costs = [[cardKind.costs subarrayWithRange:NSMakeRange(0,capacity)] mutableCopy];
                    
                }
                
            }
            
        }
        
    }
    
    [self.tableView reloadData];
    
}

-(void)createData
{
    
    self.info = [[CardKindListInfo alloc]init];
    
    [self.info requestCourseWayCardKindsWithCourseType:self.plan?self.plan.course.type:self.batch.course.type andIsEdit:!self.isAdd andGym:AppGym result:^(BOOL success, NSString *error) {
        
        self.cardKinds = self.info.cardKinds;
        
        NSArray *cardKinds = self.plan?self.plan.cardKinds:self.batch.cardKinds;
        
        for (CardKind *cardKind in cardKinds) {
            
            for (CardKind *tempCardKind in self.cardKinds) {
                
                if (cardKind.cardKindId == tempCardKind.cardKindId) {
                    
                    tempCardKind.costs = [cardKind.costs mutableCopy];
                    
                    tempCardKind.isUsed = YES;
                    
                    tempCardKind.canCancel = cardKind.canCancel;
                    
                    break;
                    
                }
                
            }
            
        }
        
        NSMutableArray *nowCardKinds = [NSMutableArray array];
        
        for (CardKind *tempCardKind in self.cardKinds) {
            
            if (tempCardKind.isUsed) {
                
                [nowCardKinds addObject:tempCardKind];
                
            }else if (tempCardKind.state == CardKindStateNormal) {
                
                [nowCardKinds addObject:tempCardKind];
                
            }
            
        }
        
        self.cardKinds = nowCardKinds;
        
        NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"isUsed" ascending:NO];
        
        NSArray *sortDescriptors = [NSArray arrayWithObjects:descriptor, nil];
        
        self.cardKinds = [[self.cardKinds sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
        
        NSInteger capacity = self.plan?self.plan.course.capacity:self.batch.course.capacity;
        
        CourseType courseType = self.plan?self.plan.course.type:self.batch.course.type;
        
        for (CardKind *tempCardKind in self.cardKinds) {
            
            if (!tempCardKind.isUsed) {
                
                [tempCardKind.costs removeAllObjects];
                
            }else
            {
                
                if (tempCardKind.type != CardKindTypeTime) {
                    
                    if (tempCardKind.costs.count<capacity) {
                        
                        for (NSInteger i = tempCardKind.costs.count ; i<capacity; i++) {
                            
                            CardCost *cost = [[CardCost alloc]init];
                            
                            cost.fromNumber = i+1;
                            
                            cost.toNumber = i+2;
                            
                            if (courseType == CourseTypeGroup) {
                                
                                CardCost *tempCost = [tempCardKind.costs firstObject];
                                
                                cost.perCost = tempCost.perCost;
                                
                                cost.costString = tempCost.costString;
                                
                            }
                            
                            [tempCardKind.costs addObject:cost];
                            
                        }
                        
                    }else if (tempCardKind.costs.count > capacity){
                        
                        tempCardKind.costs = [[tempCardKind.costs subarrayWithRange:NSMakeRange(0, capacity)] mutableCopy];
                        
                    }
                    
                }
                
            }
            
        }
        
        self.emptyView.hidden = self.cardKinds.count;
        
        self.tableView.dataSuccess = success;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"会员卡结算";
    
    self.rightTitle = @"保存";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStyleGrouped];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[QCTextFieldCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];
    
    UIView *tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(56))];
    
    tableFooterView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.tableFooterView = tableFooterView;
    
    self.emptyView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.emptyView.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(64), Height320(118), Width320(185), Height320(144))];
    
    emptyImg.image = [UIImage imageNamed:@"card_empty"];
    
    [self.emptyView addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, emptyImg.bottom+Height320(18), self.emptyView.width, Height320(16))];
    
    emptyLabel.textColor = UIColorFromRGB(0x999999);
    
    emptyLabel.font = STFont(14);
    
    emptyLabel.text = @"没有可用的会员卡种类";
    
    emptyLabel.numberOfLines = 1;
    
    emptyLabel.textAlignment  = NSTextAlignmentCenter;
    
    [self.emptyView addSubview:emptyLabel];
    
    [self.view addSubview:self.emptyView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.cardKinds.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    CardKind *cardKind = self.cardKinds[section];
    
    if (cardKind.isUsed) {
        
        if (self.plan) {
            
            return cardKind.type == CardKindTypeTime?0:self.plan.course.type == CourseTypePrivate?self.plan.course.capacity:1;
            
        }else{
            
            return cardKind.type == CardKindTypeTime?0:self.batch.course.type == CourseTypePrivate?self.batch.course.capacity:1;
            
        }
        
    }else
    {
        
        return 0;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return Height320(40);
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40))];
    
    header.backgroundColor = UIColorFromRGB(0xffffff);
    
    MOSwitchCell *cell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    cell.titleLabel.textColor = UIColorFromRGB(0x666666);
    
    cell.backgroundColor = UIColorFromRGB(0xffffff);
    
    CardKind *cardKind = self.cardKinds[section];
    
    cell.titleLabel.text = cardKind.cardKindName;
    
    cell.on = cardKind.isUsed;
    
    cell.cardStopped = cardKind.state == CardKindStateStop;
    
    [header addSubview:cell];
    
    UIView *topSep = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, 1/[UIScreen mainScreen].scale)];
    
    topSep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [header addSubview:topSep];
    
    UIView *bottomSep = [[UIView alloc]initWithFrame:CGRectMake(cardKind.isUsed&&cardKind.type!=CardKindTypeTime?Width320(16):0, cell.height-OnePX, cardKind.isUsed?cell.width-Width320(32):MSW, OnePX)];
    
    bottomSep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [header addSubview:bottomSep];
    
    cell.delegate = self;
    
    cell.tag = section+3;
    
    cell.userInteractionEnabled = cardKind.canCancel;
    
    return header;
    
}

-(void)switchCellSwitchChanged:(MOSwitchCell *)cell
{
    
    [self.view endEditing:YES];
    
    CardKind *cardKind = self.cardKinds[cell.tag-3];
    
    cardKind.isUsed = cell.on;
    
    [self reloadData];
    
    if (cell.on) {
        
        QCTextFieldCell *tfCell = (QCTextFieldCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:cell.tag-3]];
        
        [tfCell becomeFirstResponder];
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return Height320(12);
    
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(12))];
    
    footer.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(0, -1/[UIScreen mainScreen].scale, MSW, 1/[UIScreen mainScreen].scale)];
    
    sep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [footer addSubview:sep];
    
    return footer;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(40);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    QCTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    CardKind *cardKind = self.cardKinds[indexPath.section];
    
    CourseType type = self.plan?self.plan.course.type:self.batch.course.type;
    
    if (type == CourseTypeGroup) {
        
        if (cardKind.type == CardKindTypePrepaid) {
            
            cell.textField.placeholder = @"单价（元/人）";
            
        }else if (cardKind.type == CardKindTypeCount){
            
            cell.textField.placeholder = @"单价（次/人）";
            
        }
        
    }else
    {
        
        if (cardKind.type == CardKindTypePrepaid) {
            
            cell.textField.placeholder = [NSString stringWithFormat:@"1对%ld单价（元/人）",(long)indexPath.row+1];
            
        }else if (cardKind.type == CardKindTypeCount){
            
            cell.textField.placeholder = [NSString stringWithFormat:@"1对%ld单价（次/人）",(long)indexPath.row+1];
            
        }
        
    }
    
    cell.textField.mustInput = YES;
    
    cell.textField.delegate = self;
    
    if (indexPath.row < cardKind.costs.count) {
        
        CardCost *cost = cardKind.costs[indexPath.row];
        
        cell.textField.text  = cost.costString.length?[NSString stringWithFormat:@"%ld",(long)cost.perCost]:@"";
        
    }
    
    cell.keyboardType = UIKeyboardTypeNumberPad;
    
    if (type == CourseTypeGroup) {
        
        cell.textField.noLine = YES;
        
    }else{
        
        NSInteger capacity = self.plan?self.plan.course.capacity:self.batch.course.capacity;
        
        cell.textField.noLine = indexPath.row == capacity-1;
        
    }
    
    cell.indexPath = indexPath;
    
    cell.delegate = self;
    
    return cell;
    
}

-(void)cell:(QCTextFieldCell *)cell textFieldDidChanged:(NSString *)string
{
    
    CardKind *cardKind = self.cardKinds[cell.indexPath.section];
    
    CourseType type = self.plan?self.plan.course.type:self.batch.course.type;
    
    if (type == CourseTypeGroup) {
        
        for (CardCost *cost in cardKind.costs) {
            
            cost.perCost = [string integerValue];
            
            if (string.length) {
                
                cost.costString = string;
                
            }else{
                
                cost.costString = @"";
                
            }
            
        }
        
    }else
    {
        
        CardCost *cost = cardKind.costs[cell.indexPath.row];
        
        cost.perCost = [string integerValue];
        
        if (string.length) {
            
            cost.costString = string;
            
        }else{
            
            cost.costString = @"";
            
        }
        
    }
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.view endEditing:YES];
    
}

-(void)naviLeftClick
{
    
    [[[UIAlertView alloc]initWithTitle:@"是否保存结算方式" message:nil delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是",nil]show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        [self naviRightClick];
        
    }
    
}

-(void)naviRightClick
{
    
    [self.view endEditing:YES];
    
    CardKind *tempCardKind = nil;
    
    for (CardKind *cardKind in self.cardKinds) {
        
        if (tempCardKind) {
            
            break;
            
        }
        
        if (cardKind.isUsed) {
            
            for (CardCost *cost in cardKind.costs) {
                
                if (!cost.costString.length) {
                    
                    tempCardKind = cardKind;
                    
                    break;
                    
                }
                
            }
            
        }
        
    }
    
    if (tempCardKind) {
        
        [[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%@结算金额未填写完整",tempCardKind.cardKindName] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    if (self.plan) {
        
        NSMutableArray *cardKinds = [NSMutableArray array];
        
        for (CardKind *cardKind in self.cardKinds) {
            
            if (cardKind.isUsed) {
                
                [cardKinds addObject:cardKind];
                
            }
            
        }
        
        self.plan.cardKinds = cardKinds;
        
    }else{
        
        NSMutableArray *cardKinds = [NSMutableArray array];
        
        for (CardKind *cardKind in self.cardKinds) {
            
            if (cardKind.isUsed) {
                
                [cardKinds addObject:cardKind];
                
            }
            
        }
        
        self.batch.cardKinds = cardKinds;
        
    }
    
    if (self.plan) {
        
        if (self.setPlanFinish) {
            
            self.setPlanFinish(self.plan);
            
        }
        
    }else{
        
        if (self.setFinish) {
            
            self.setFinish(self.batch);
            
        }
        
    }
    
    [self popViewControllerAndReloadData];
    
}

@end
