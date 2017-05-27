//
//  YFCardKindPopView.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/8.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFCardKindPopView.h"

#import "YFCardKindVC.h"

@interface YFCardKindPopView ()

@property(nonatomic, strong)YFCardKindVC *cardKindVC;

@end

@implementation YFCardKindPopView

- (instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView childrenFrame:(CGRect)childrenFrame sufient:(BOOL)isSuffent
{
    self = [super initWithFrame:frame superView:superView childrenFrame:childrenFrame sufient:isSuffent];
    if (self)
    {
    
    }
    return self;
}

- (void)setIsNotSuffient:(BOOL)isNotSuffient
{
    [super setIsNotSuffient:isNotSuffient];
//    [self cardKindVC];
    self.cardKindVC.view.frame = CGRectMake(0, 0, self.originFrame.size.width, self.originFrame.size.height);
    
    self.cardKindVC.refreshScrollView.frame = CGRectMake(self.cardKindVC.firstTableView.width, 0, MSW - self.cardKindVC.firstTableView.width , self.cardKindVC.view.height);
    
    self.cardKindVC.firstTableView.frame = CGRectMake(self.cardKindVC.firstTableView.mj_x,0, self.cardKindVC.firstTableView.width, self.cardKindVC.view.height);
    
    [self.childredView addSubview:self.cardKindVC.view];
    
    
    
    self.childredView.clipsToBounds = YES;
    
    self.cardKindVC.view.clipsToBounds = YES;

}

-(YFCardKindVC *)cardKindVC
{
    if (!_cardKindVC) {
        _cardKindVC = [[YFCardKindVC alloc] init];
        self.popSubVC = _cardKindVC;
        
        weakTypesYF
        [_cardKindVC setSureBlock:^{
            if (weakS.selectBlock) {
                weakS.param = weakS.cardKindVC.cardModel.paramOfCard;
                weakS.value = weakS.cardKindVC.cardModel.name;
                weakS.selectBlock(@"",weakS.cardKindVC.cardModel.paramOfCard);
            }
        }];
    }
    _cardKindVC.isNotSuffient = self.isNotSuffient;
    
    return _cardKindVC;
}

- (void)reloadConditionData
{
    self.cardKindVC = nil;
    
    [self setIsNotSuffient:self.isNotSuffient];
//    self.cardKindVC.view.hidden = YES;
//    [self.cardKindVC refreshTableListDataNoPull];
}

@end
