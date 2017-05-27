//
//  YFCardStatePopView.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/8.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFCardStatePopView.h"

#import "YFCardStateVC.h"

@interface YFCardStatePopView ()

@property(nonatomic, strong)YFCardStateVC *cardStateVC;

@end

@implementation YFCardStatePopView

- (instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView childrenFrame:(CGRect)childrenFrame sufient:(BOOL)isSuffent
{
    if (isSuffent) {
        childrenFrame = CGRectMake(0, 0, childrenFrame.size.width, XFrom5To6YF(40) * 4);
    }else
    {
        childrenFrame = CGRectMake(0, 0, childrenFrame.size.width, XFrom5To6YF(40) * 5);
    }
    
    
    self = [super initWithFrame:frame superView:superView childrenFrame:childrenFrame sufient:isSuffent];
    if (self)
    {
        
       
        
    }
    return self;
}
- (void)setIsNotSuffient:(BOOL)isNotSuffient
{
    [super setIsNotSuffient:isNotSuffient];
    
    self.cardStateVC.view.frame = CGRectMake(0, 0, self.originFrame.size.width, self.originFrame.size.height);
    
    self.cardStateVC.refreshScrollView.frame = CGRectMake(0, 0, MSW , self.cardStateVC.view.height);
    
    
    [self.childredView addSubview:self.cardStateVC.view];
    
    self.childredView.clipsToBounds = YES;
    self.cardStateVC.view.clipsToBounds = YES;
}

-(YFCardStateVC *)cardStateVC
{
    if (!_cardStateVC) {
        _cardStateVC = [[YFCardStateVC alloc] init];
        self.popSubVC = _cardStateVC;
        
        weakTypesYF
        [_cardStateVC setSureBlock:^{
            if (weakS.selectBlock) {
                weakS.param = weakS.cardStateVC.cardStateModel.paramOfState;
                weakS.value = weakS.cardStateVC.cardStateModel.name;
                weakS.selectBlock(@"",weakS.cardStateVC.cardStateModel.paramOfState);
            }
        }];
    }
    _cardStateVC.isNotSuffient = self.isNotSuffient;
    return _cardStateVC;
}


@end
