//
//  ChestReturnController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChestReturnController.h"

#import "MOSwitchCell.h"

#import "QCTextField.h"

#import "CardPayChooseCell.h"

#import "CardPayChooseView.h"

#import "StudentDetailInfo.h"

#import "ChestBorrowInfo.h"

#import "CardCreateChooseKindController.h"

@interface ChestReturnController ()<MOSwitchCellDelegate,CardPayChooseViewDelegate>

@property(nonatomic,strong)UIScrollView *mainView;

@property(nonatomic,strong)UIView *secView;

@property(nonatomic,strong)MOSwitchCell *returnCell;

@property(nonatomic,strong)CardPayChooseCell *cardCell;

@property(nonatomic,strong)CardPayChooseView *cardView;

@property(nonatomic,strong)UILabel *cardLabel;

@property(nonatomic,strong)UILabel *remainLabel;

@property(nonatomic,strong)QCTextField *returnTF;

@property(nonatomic,strong)UIButton *confirmButton;

@property(nonatomic,strong)Card *chooseCard;

@property(nonatomic,assign)PayWay payWay;

@property(nonatomic,strong)StudentDetailInfo *stuInfo;

@end

@implementation ChestReturnController

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
    
    self.stuInfo = [[StudentDetailInfo alloc]init];
    
    __weak typeof(self)weakS = self;
    
    self.stuInfo.cardDataFinish = ^(BOOL success){
        
        NSMutableArray *cards = [NSMutableArray array];
        
        for (Card *card in weakS.stuInfo.cardArray) {
            
            if (card.cardKind.type != CardKindTypeTime) {
                
                [cards addObject:card];
                
            }
            
        }
        
        weakS.cardView.cards = cards;
        
        if (cards.count) {
            
            weakS.chooseCard = [cards firstObject];
            
        }else{
            
            weakS.payWay = PayWayCash;
            
        }
        
    };
    
    [self.stuInfo requestChestCardInfoWithStudent:self.chest.borrowUser];
    
}

-(void)createUI
{
    
    self.title = @"归还更衣柜";
    
    self.mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.mainView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.view addSubview:self.mainView];
    
    UILabel *chestNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(20), MSW, Height320(27))];
    
    chestNameLabel.text = self.chest.name;
    
    chestNameLabel.textColor = kMainColor;
    
    chestNameLabel.textAlignment = NSTextAlignmentCenter;
    
    chestNameLabel.font = AllFont(24);
    
    [self.mainView addSubview:chestNameLabel];
    
    UILabel *areaLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, chestNameLabel.bottom, chestNameLabel.width, Height320(14))];
    
    areaLabel.text = self.chest.area.areaName;
    
    areaLabel.textColor = kMainColor;
    
    areaLabel.textAlignment = NSTextAlignmentCenter;
    
    areaLabel.font = AllFont(12);
    
    [self.mainView addSubview:areaLabel];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(81), MSW, Height320(150))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = OnePX;
    
    [self.mainView addSubview:topView];
    
    UILabel *firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(15), Width320(64), Height320(16))];
    
    firstLabel.text = @"状 态";
    
    firstLabel.textColor = UIColorFromRGB(0x999999);
    
    firstLabel.font = AllFont(14);
    
    [topView addSubview:firstLabel];
    
    UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(89), firstLabel.top, Width320(180), Height320(16))];
    
    stateLabel.text = @"长期租用";
    
    stateLabel.textColor = UIColorFromRGB(0xf9944e);
    
    stateLabel.font = AllFont(14);
    
    [topView addSubview:stateLabel];
    
    UILabel *secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstLabel.left, firstLabel.bottom+Height320(10), firstLabel.width, firstLabel.height)];
    
    secondLabel.text = @"期 限";
    
    secondLabel.textColor = UIColorFromRGB(0x999999);
    
    secondLabel.font = AllFont(14);
    
    [topView addSubview:secondLabel];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(89), secondLabel.top, Width320(180), Height320(16))];
    
    timeLabel.text = [NSString stringWithFormat:@"%@至%@",_chest.start,_chest.end];
    
    timeLabel.textColor = UIColorFromRGB(0x333333);
    
    timeLabel.font = AllFont(14);
    
    [topView addSubview:timeLabel];
    
    UILabel *thirdLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstLabel.left, secondLabel.bottom+Height320(10), firstLabel.width, firstLabel.height)];
    
    thirdLabel.text = @"会 员";
    
    thirdLabel.textColor = UIColorFromRGB(0x999999);
    
    thirdLabel.font = AllFont(14);
    
    [topView addSubview:thirdLabel];
    
    UILabel *userLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(89), thirdLabel.top, Width320(180), Height320(16))];
    
    userLabel.text = _chest.borrowUser.name;
    
    userLabel.textColor = UIColorFromRGB(0x333333);
    
    userLabel.font = AllFont(14);
    
    [topView addSubview:userLabel];
    
    UILabel *forthLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstLabel.left, thirdLabel.bottom+Height320(10), firstLabel.width, firstLabel.height)];
    
    forthLabel.text = @"手 机";
    
    forthLabel.textColor = UIColorFromRGB(0x999999);
    
    forthLabel.font = AllFont(14);
    
    [topView addSubview:forthLabel];
    
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(89), forthLabel.top, Width320(180), Height320(16))];
    
    phoneLabel.text = _chest.borrowUser.phone;
    
    phoneLabel.textColor = UIColorFromRGB(0x333333);
    
    phoneLabel.font = AllFont(14);
    
    [topView addSubview:phoneLabel];
    
    UILabel *fifthLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstLabel.left, forthLabel.bottom+Height320(10), firstLabel.width, firstLabel.height)];
    
    fifthLabel.text = @"剩余天数";
    
    fifthLabel.textColor = UIColorFromRGB(0x999999);
    
    fifthLabel.font = AllFont(14);
    
    [topView addSubview:fifthLabel];
    
    UILabel *remainLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(89), fifthLabel.top, Width320(180), Height320(16))];
    
    remainLabel.textColor = UIColorFromRGB(0x333333);
    
    NSString *remain = [NSString stringWithFormat:@"%ld 天",(long)_chest.remain];
    
    if (_chest.remain<=0) {
        
        NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:remain];
        
        [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xEA6161) range:NSMakeRange(0, astr.length-2)];
        
        remainLabel.attributedText = astr;
        
    }else{
        
        remainLabel.text = remain;
        
    }
    
    remainLabel.font = AllFont(14);
    
    [topView addSubview:remainLabel];
    
    self.secView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(12), MSW, Height320(40))];
    
    self.secView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.secView.layer.borderWidth = OnePX;
    
    self.secView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    [self.mainView addSubview:self.secView];
    
    self.returnCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.returnCell.titleLabel.text = self.chest.remain>=0?@"是否退费":@"是否收费";
    
    self.returnCell.noLine = YES;
    
    self.returnCell.delegate = self;
    
    [self.secView addSubview:self.returnCell];
    
    self.cardCell = [[CardPayChooseCell alloc]initWithFrame:CGRectMake(0 ,self.returnCell.bottom, MSW, self.chest.remain>=0?Height320(40):Height320(54))];
    
    self.cardCell.hidden = YES;
    
    [self.secView addSubview:self.cardCell];
    
    [self.cardCell addTarget:self action:@selector(cardChoose) forControlEvents:UIControlEventTouchUpInside];
    
    self.returnTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), self.cardCell.bottom, MSW-Width320(32), Height320(40))];
    
    self.returnTF.placeholder = self.chest.remain>=0?@"收费金额（元）":@"退费金额（元）";
    
    self.returnTF.hidden = YES;
    
    self.returnTF.keyboardType = UIKeyboardTypeDecimalPad;
    
    [self.secView addSubview:self.returnTF];
    
    self.confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), self.secView.bottom+Height320(12), MSW-Width320(32), Height320(40))];
    
    self.confirmButton.backgroundColor = kMainColor;
    
    self.confirmButton.layer.cornerRadius = Width320(2);
    
    [self.confirmButton setTitle:@"确定归还" forState:UIControlStateNormal];
    
    [self.confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    [self.mainView addSubview:self.confirmButton];
    
    [self.confirmButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    
    self.cardView = [CardPayChooseView defaultView];
    
    self.cardView.delegate = self;
    
    [self.view addSubview:self.cardView];
    
}

-(void)confirm:(UIButton*)button
{
    
    [self.view endEditing:YES];
    
    ChestBorrowInfo *info = [[ChestBorrowInfo alloc]init];
    
    if (self.returnCell.on) {
        
        if (!self.chooseCard && !self.payWay){
            
            [[[UIAlertView alloc]initWithTitle:@"请选择支付方式" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }else if(!self.returnTF.text.length){
            
            [[[UIAlertView alloc]initWithTitle:self.chest.remain>=0?@"请填写退费金额":@"请填写收费金额" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }else{
            
            button.userInteractionEnabled = NO;
            
            [info returnLongUseChest:self.chest andCard:self.chooseCard orPayWay:self.payWay andCost:[self.returnTF.text integerValue] result:^(BOOL success, NSString *error) {
                
                button.userInteractionEnabled = YES;
                
                MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
                
                hud.mode = MBProgressHUDModeText;
                
                [self.view addSubview:hud];
                
                if (success) {
                    
                    hud.label.text = @"归还成功";
                    
                    [hud showAnimated:YES];
                    
                    [hud hideAnimated:YES afterDelay:1.5];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [self popViewControllerAndReloadData];
                        
                    });
                    
                }else{
                    
                    hud.label.text = error;
                    
                    hud.label.numberOfLines = 0;
                    
                    [hud showAnimated:YES];
                    
                    [hud hideAnimated:YES afterDelay:1.5];
                    
                }
                
            }];
            
        }
        
    }else{
        
        [info returnLongUseChest:self.chest result:^(BOOL success, NSString *error) {
            
            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
            
            hud.mode = MBProgressHUDModeText;
            
            [self.view addSubview:hud];
            
            if (success) {
                
                hud.label.text = @"归还成功";
                
                [hud showAnimated:YES];
                
                [hud hideAnimated:YES afterDelay:1.5];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self popViewControllerAndReloadData];
                    
                });
                
            }else{
                
                hud.label.text = error;
                
                hud.label.numberOfLines = 0;
                
                [hud showAnimated:YES];
                
                [hud hideAnimated:YES afterDelay:1.5];
                
            }
            
        }];
        
    }
    
}

-(void)switchCellSwitchChanged:(MOSwitchCell *)cell
{
    
    if (cell.on) {
        
        [self.secView changeHeight:self.returnTF.bottom];
        
        self.returnCell.noLine = NO;
        
        self.cardCell.hidden = NO;
        
        self.returnTF.hidden = NO;
        
    }else{
        
        self.returnCell.noLine = YES;
        
        self.cardCell.hidden = YES;
        
        self.returnTF.hidden = YES;
        
        [self.secView changeHeight:Height320(40)];
        
    }
    
    [self.confirmButton changeTop:self.secView.bottom+Height320(12)];
    
}

-(void)cardPayChooseCard:(Card *)card orPayWay:(PayWay)payWay
{
    
    if (card) {
        
        self.chooseCard = card;
        
        _payWay = PayWayNone;
        
    }else if (payWay){
        
        self.payWay = payWay;
        
        _chooseCard = nil;
        
    }
    
}

-(void)buyCard
{
    
    CardCreateChooseKindController *svc = [[CardCreateChooseKindController alloc]init];
    
    svc.gym = AppGym;
    
    svc.student = self.chest.borrowUser;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)setPayWay:(PayWay)payWay
{
    
    _payWay = payWay;
    
    if (_payWay) {
        
        self.cardCell.cardName = _payWay == PayWayCash?@"现金支付":_payWay == PayWayCard?@"刷卡支付":_payWay == PayWayTransfer?@"转账支付":@"其他";
        
        self.returnTF.placeholder = self.chest.remain>=0?@"退费金额（元）":@"收费金额（元）";
        
        if (self.chest.remain<0) {
            
            if (self.returnCell.on) {
                
                [self.cardCell changeHeight:Height320(40)];
                
                [self.returnTF changeTop:self.cardCell.bottom];
                
                [self.secView changeHeight:self.returnTF.bottom];
                
                [self.confirmButton changeTop:self.secView.bottom+Height320(12)];
                
            }
            
            self.cardCell.remain = nil;
            
        }
        
    }
    
}

-(void)setChooseCard:(Card *)chooseCard
{
    
    _chooseCard = chooseCard;
    
    self.cardCell.cardName = _chooseCard.cardKind.cardKindName;
    
    if (_chooseCard.cardKind.type == CardKindTypePrepaid) {
        
        self.returnTF.placeholder = self.chest.remain>=0?@"退费金额（元）":@"收费金额（元）";
        
    }else{
        
        self.returnTF.placeholder = self.chest.remain>=0?@"退费金额（次）":@"收费金额（次）";
        
    }
    
    if (self.chest.remain<0) {
        
        if (_chooseCard.cardKind.type == CardKindTypePrepaid) {
            
            self.cardCell.remain = [NSString stringWithFormat:@"余额：%.0f元",_chooseCard.remain];
            
        }else{
            
            self.cardCell.remain = [NSString stringWithFormat:@"余额：%.0f次",_chooseCard.remain];
            
        }
        
        if (self.returnCell.on) {
            
            [self.cardCell changeHeight:Height320(54)];
            
            [self.returnTF changeTop:self.cardCell.bottom];
            
            [self.secView changeHeight:self.returnTF.bottom];
            
            [self.confirmButton changeTop:self.secView.bottom+Height320(12)];
            
        }
        
    }
    
}

-(void)cardChoose
{
    
    [self.view endEditing:YES];
    
    [self.cardView show];
    
}


@end
