//
//  YFTBSwitchCardPayModel.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/5/9.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFTBSwitchCardPayModel.h"

@interface YFTBSwitchCardPayModel ()<CardPayChooseViewDelegate>


@property(nonatomic,strong)Card *chooseCard;

@end

@implementation YFTBSwitchCardPayModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.switModel.des = @"是否收费";
        [self.switModel setScaleHeight];
        self.switModel.on = YES;
        [self.dataArray addObject:self.payModel];
        [self.dataArray addObject:self.inputModel];
        
        self.cardView.delegate = self;
    }
    return self;
}
- (NSUInteger)sectionCount
{
    if (self.switModel.on == NO) {
        return 1;
    }
    return self.dataArray.count;
}

- (void)changedSwith:(id)model
{
if (self.inputModel.changeValueTYF)
{
    self.inputModel.changeValueTYF(self.inputModel.valueStringFY);
}
}

- (YFPayStyleModel *)payModel
{
    if (!_payModel)
    {
        weakTypesYF
        YFPayStyleModel *payModel = [YFPayStyleModel defaultWithYYModelDic:nil selectBlock:^(id model) {
            [weakS choosePayStyle];
        }];
        payModel.des = @"支付方式";
        payModel.isShowSubValue = NO;
        payModel.desValue = @"请选择支付方式";
        _payModel = payModel;
    }
    return _payModel;
}


- (YFInputValueCModel *)inputModel
{
    if (!_inputModel)
    {
        _inputModel =  [YFInputValueCModel defaultWithYYModelDic:nil];
        
        [_inputModel setScaleHeight];
        
        _inputModel.conditionName = @"金额 (元)";
        
        _inputModel.conditionTextColor = RGB_YF(153, 153, 153);
        
        
    }
    return _inputModel;
}

- (void)choosePayStyle
{
    [self.cardView show];
}


- (CardPayChooseView *)cardView
{
    if (_cardView == nil)
    {
        CardPayChooseView *cardView = [CardPayChooseView defaultView];
        
        cardView.isShowCardPay = NO;
        
        _cardView = cardView;
    }
    
    
    return _cardView;
    
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
    [self.weakTableView reloadData];
    
    if (self.inputModel.changeValueTYF)
    {
        self.inputModel.changeValueTYF(self.inputModel.valueStringFY);
    }
}

-(void)setPayWay:(PayWay)payWay
{
    _payWay = payWay;
    
    if (_payWay) {
        
        self.payModel.desValue = _payWay == PayWayCash?@"现金支付":_payWay == PayWayCard?@"刷卡支付":_payWay == PayWayTransfer?@"转账支付":@"其他";
        
        self.payModel.isShowSubValue = NO;
        
        self.inputModel.conditionName = @"金额（元）";
        
    }
}

-(void)setChooseCard:(Card *)chooseCard
{
    _chooseCard = chooseCard;
    
    self.payModel.desValue = _chooseCard.cardKind.cardKindName;
    
    self.payModel.isShowSubValue = YES;
    
    if (_chooseCard.cardKind.type == CardKindTypePrepaid) {
        
        self.payModel.desSubValue = [NSString stringWithFormat:@"余额：%.0f元",_chooseCard.remain];
        
        self.inputModel.conditionName = @"金额（元）";
        
    }else{
        
        self.payModel.desSubValue = [NSString stringWithFormat:@"余额：%.0f次",_chooseCard.remain];
        
        self.inputModel.conditionName = @"金额（次）";
        
    }
}

@end
