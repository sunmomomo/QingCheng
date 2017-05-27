//
//  YFCardConditionPopView.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/10.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFCardConditionPopView.h"

#import "YFCardConditionVC.h"

@interface YFCardConditionPopView ()

@property(nonatomic, strong)YFCardConditionVC *conditionVC;

@end

@implementation YFCardConditionPopView
{
    UIControl *_blackGroundView;
}

- (instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView childrenFrame:(CGRect)childrenFrame
{
    childrenFrame  = CGRectMake(0, 0, MSW, XFrom5To6YF(40) * 4 + 15 + YFDonwnButtonSHeight);
    self = [super initWithFrame:frame superView:superView childrenFrame:childrenFrame];
    if (self)
    {
        
        _blackGroundView = [[UIControl alloc] initWithFrame:CGRectZero];
        _blackGroundView.backgroundColor = RGBACOLOR(0, 0, 0, 0.4);
        [_blackGroundView addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_blackGroundView];
        [self sendSubviewToBack:_blackGroundView];
        
        self.conditionVC.view.frame = CGRectMake(0, 0, self.originFrame.size.width, self.originFrame.size.height);
        
        [self.childredView addSubview:self.conditionVC.view];
        
        self.originFrame = self.conditionVC.baseTableView.frame;
        
        self.childredView.clipsToBounds = YES;
        
        self.conditionVC.view.clipsToBounds = YES;
        self.backgroundColor = RGBA_YF(0, 0, 0, 0.4);
        
        self.childredView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)initChildrenViewWithFrame:(CGRect)frame
{
//
    [super initChildrenViewWithFrame: frame];
}

- (void)showAnimate:(BOOL)isAmate
{
    self.hiddenFrame = CGRectMake(self.originFrame.origin.x, self.originFrame.origin.y, self.originFrame.size.width, 0);
    
    _blackGroundView.frame = CGRectMake(self.originFrame.origin.x, self.originFrame.origin.y, self.originFrame.size.width, self.height - self.originFrame.origin.y);
    
    
    self.childredView.frame = self.hiddenFrame;
    [super showAnimate:isAmate];
}

-(YFCardConditionVC *)conditionVC
{
    if (!_conditionVC) {
        _conditionVC = [[YFCardConditionVC alloc] init];
        weakTypesYF
        [_conditionVC setSureBlock:^{
            if (weakS.selectBlock) {
                weakS.param = weakS.conditionVC.paramOfCondition;
                weakS.selectBlock(@"",nil);
            }
        }];
    }
    return _conditionVC;
}

-(void)setCardListSetting:(CardListInfo *)cardSetInfo
{
    [self.conditionVC setCardListSetting:cardSetInfo];
}


@end
