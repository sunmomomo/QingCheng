//
//  GuideWayController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "GuideWayController.h"

#import "MOSwitchCell.h"

#import "Card.h"

#import "QCKeyboardView.h"

#import "QCTextField.h"

#import "QCTextFieldCell.h"

#import "GuideAddCardController.h"

#import "MOPickerView.h"

#define GroupMaxCapacity 300

#define PrivateMaxCapacity 10

static NSString *identifier = @"Cell";

@interface GuideWayController ()<UITableViewDataSource,UITableViewDelegate,QCKeyboardViewDelegate,UITextFieldDelegate,MOSwitchCellDelegate,QCTextFieldCellDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *cardKinds;

@property(nonatomic,strong)QCTextField *capacityTF;

@property(nonatomic,strong)MOPickerView *capacityPickerView;

@property(nonatomic,strong)NSIndexPath *currentIndexPath;

@property(nonatomic,strong)UIButton *confirmButton;

@property(nonatomic,strong)NSMutableArray *capacityArray;

@end

@implementation GuideWayController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createData];
    
    [self createUI];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    self.cardKinds = [NSMutableArray array];
    
    for (CardKind *card in self.course.cardKinds) {
        
        [self.cardKinds addObject:[card copy]];
        
    }
    
    self.capacityArray = [NSMutableArray array];
    
    NSInteger max = self.course.type == CourseTypeGroup?GroupMaxCapacity:PrivateMaxCapacity;
    
    for (NSInteger i = 1; i<=max; i++) {
        
        [self.capacityArray addObject:[NSString stringWithInteger:i]];
        
    }
    
    if (!self.cardKinds.count) {
        
        CardKind *card1 = [[CardKind alloc]init];
        
        card1.cardKindName = @"默认储值卡";
        
        card1.type = CardKindTypePrepaid;
        
        [self.cardKinds addObject:card1];
        
        CardKind *card2 = [[CardKind alloc]init];
        
        card2.cardKindName = @"默认次卡";
        
        card2.type = CardKindTypeCount;
        
        [self.cardKinds addObject:card2];
        
        CardKind *card3 = [[CardKind alloc]init];
        
        card3.cardKindName = @"默认年卡";
        
        card3.type = CardKindTypeTime;
        
        [self.cardKinds addObject:card3];
        
    }
    
}

-(void)reloadData
{
    
    for (CardKind *cardKind in self.cardKinds) {
        
        if (!cardKind.isUsed) {
            
            [cardKind.costs removeAllObjects];
            
        }else
        {
            
            if (cardKind.type != CardKindTypeTime) {
                
                if (cardKind.costs.count<[self.capacityTF.text integerValue]) {
                    
                    for (NSInteger i = cardKind.costs.count ; i<[self.capacityTF.text integerValue]; i++) {
                        
                        CardCost *cost = [[CardCost alloc]init];
                        
                        cost.fromNumber = i+1;
                        
                        cost.toNumber = i+2;
                        
                        if (self.course.type == CourseTypeGroup && cardKind.costs.count) {
                            
                            CardCost *firstCost = [cardKind.costs firstObject];
                            
                            cost.perCost = firstCost.perCost;
                            
                        }
                        
                        [cardKind.costs addObject:cost];
                        
                    }
                    
                }else if (cardKind.costs.count > [self.capacityTF.text integerValue]){
                    
                    cardKind.costs = [[cardKind.costs subarrayWithRange:NSMakeRange(0, [self.capacityTF.text integerValue])] mutableCopy];
                    
                }
                
            }
            
        }
        
    }
    
    [self.tableView reloadData];
    
    [self check];
    
}

-(void)createUI
{
    
    self.title = @"设置结算方式";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 63, MSW, MSH-63) style:UITableViewStyleGrouped];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[QCTextFieldCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40)*2)];
    
    tableHeaderView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.tableHeaderView = tableHeaderView;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [tableHeaderView addSubview:topView];
    
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), topView.bottom, MSW-Width320(32), Height320(40))];
    
    topLabel.text = @"可用会员卡种类";
    
    topLabel.textColor = UIColorFromRGB(0xaaaaaa);
    
    topLabel.font = AllFont(14);
    
    [tableHeaderView addSubview:topLabel];
    
    self.capacityTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.capacityTF.placeholder = @"单节课可约人数";
    
    self.capacityTF.delegate = self;
    
    self.capacityTF.noLine = YES;
    
    [topView addSubview:self.capacityTF];
    
    if (self.course.capacity) {
        
        self.capacityTF.text = [NSString stringWithFormat:@"%ld",(long)self.course.capacity];
        
    }else{
        
        self.capacityTF.text = @"1";
        
    }
    
    QCKeyboardView *keyboardView = [QCKeyboardView defaultKeboardView];
    
    keyboardView.delegate = self;
    
    self.capacityTF.inputView = keyboardView;
    
    self.capacityPickerView = [[MOPickerView alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.capacityPickerView.titleArray = self.capacityArray;
    
    keyboardView.keyboard = self.capacityPickerView;
    
    UIView *tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40)*3)];
    
    tableFooterView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.tableFooterView = tableFooterView;
    
    UIView *footerTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40))];
    
    footerTop.backgroundColor = UIColorFromRGB(0xffffff);
    
    footerTop.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    footerTop.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [tableFooterView addSubview:footerTop];
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(140), Height320(40))];
    
    [addButton setTitle:@"+ 添加会员卡种类" forState:UIControlStateNormal];
    
    addButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    
    [addButton setTitleColor:kMainColor forState:UIControlStateNormal];
    
    addButton.titleLabel.font = AllFont(13);
    
    [addButton addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [footerTop addSubview:addButton];
    
    self.confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), footerTop.bottom+Height320(12), MSW-Width320(32), Height320(40))];
    
    self.confirmButton.backgroundColor = kMainColor;
    
    self.confirmButton.layer.cornerRadius = 2;
    
    [self.confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    
    self.confirmButton.titleLabel.font = AllFont(14);
    
    [tableFooterView addSubview:self.confirmButton];
    
    [self.confirmButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    
    [self check];
    
}

-(void)addClick:(UIButton*)button
{
    
    GuideAddCardController *svc = [[GuideAddCardController alloc]init];
    
    __weak typeof(self)weakS = self;
    
    svc.addSuccess = ^(CardKind *cardKind){
        
        [weakS.cardKinds addObject:cardKind];
        
        [weakS reloadData];
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)confirm:(UIButton*)button
{
    
    self.course.cardKinds = self.cardKinds;
    
    self.course.capacity = [self.capacityTF.text integerValue];
    
    self.course.wayOK = YES;
    
    if (self.setFinish) {
        self.setFinish();
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)setConfirmButtonCanClick:(BOOL)canClick
{
    
    if (canClick) {
        
        self.confirmButton.backgroundColor = kMainColor;
        
        self.confirmButton.userInteractionEnabled = YES;
        
    }else{
        
        self.confirmButton.backgroundColor = [kMainColor colorWithAlphaComponent:0.3];
        
        self.confirmButton.userInteractionEnabled = NO;
        
    }
    
}

-(void)check
{
    
    if (![self.capacityTF.text integerValue]) {
        
        [self setConfirmButtonCanClick:NO];
        
        return;
        
    }
    
    NSInteger cardUsedCount = 0;
    
    for (CardKind *cardKind in self.cardKinds) {
        
        if (cardKind.isUsed) {
            cardUsedCount ++;
        }
        
    }
    
    if (!cardUsedCount) {
        
        [self setConfirmButtonCanClick:NO];
        
        return;
        
    }
    
    __block BOOL empty = NO;
    
    [self.cardKinds enumerateObjectsUsingBlock:^(CardKind *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        for (CardCost *cost in obj.costs) {
            
            if (!cost.costString.length) {
                
                empty = YES;
                
                *stop = YES;
                
                break;
                
            }
            
        }
        
    }];
    
    if (empty) {
        
        [self setConfirmButtonCanClick:NO];
        
        return;
        
    }
    
    [self setConfirmButtonCanClick:YES];
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboardView
{
    
    [self.capacityTF resignFirstResponder];
    
    self.capacityTF.text = self.capacityArray[self.capacityPickerView.currentRow];
    
    self.capacityTF.rightViewMode = UITextFieldViewModeNever;
    
    [self reloadData];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.cardKinds.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    CardKind *cardKind = self.cardKinds[section];
    
    if (cardKind.isUsed) {
        
        return cardKind.type == CardKindTypeTime?0:self.course.type == CourseTypePrivate?[self.capacityTF.text integerValue]:1;
        
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
    
    [header addSubview:cell];
    
    UIView *topSep = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, 1/[UIScreen mainScreen].scale)];
    
    topSep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [header addSubview:topSep];
    
    UIView *bottomSep = [[UIView alloc]initWithFrame:CGRectMake(cardKind.isUsed&&cardKind.type!=CardKindTypeTime?Width320(16):0, cell.height-1/[UIScreen mainScreen].scale, cardKind.isUsed?cell.width-Width320(32):MSW, 1/[UIScreen mainScreen].scale)];
    
    bottomSep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [header addSubview:bottomSep];
    
    cell.delegate = self;
    
    cell.tag = section;
    
    return header;
    
}

-(void)switchCellSwitchChanged:(MOSwitchCell *)cell
{
    
    CardKind *cardKind = self.cardKinds[cell.tag];
    
    cardKind.isUsed = cell.on;
    
    if (self.capacityTF.text.length) {
        
        [self reloadData];
        
    }
    
    if (cell.on) {
        
        QCTextFieldCell *tfCell = (QCTextFieldCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:cell.tag]];
        
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
    
    if (self.course.type == CourseTypeGroup) {
        
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
    
    CardCost *cost = cardKind.costs[indexPath.row];
    
    cell.textField.text  = cost.costString.length?[NSString stringWithFormat:@"%ld",(long)cost.perCost]:@"";
    
    cell.textField.noLine = indexPath.row == [self.capacityTF.text integerValue]-1;
    
    cell.indexPath = indexPath;
    
    cell.delegate = self;
    
    return cell;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    [self check];
    
    return YES;
    
}

-(void)cell:(QCTextFieldCell *)cell textFieldDidChanged:(NSString *)string
{
    
    CardKind *cardKind = self.cardKinds[cell.indexPath.section];
    
    if (self.course.type == CourseTypeGroup) {
        
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
    
    [self check];
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}


@end
