//
//  YFConditionGenderPopView.m
//  StaffHelper
//
//  Created by FYWCQ on 17/4/12.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFConditionGenderPopView.h"

#import "YFStudnetChooseGenderVC.h"

@interface YFConditionGenderPopView ()

@property(nonatomic, strong)YFStudnetChooseGenderVC *chooseGenderVC;

@end

@implementation YFConditionGenderPopView


- (instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView
{
    CGRect  childrenFrame = CGRectMake(0, 0, superView.width, XFrom5To6YF(40) * 3);
    
    self = [super initWithFrame:frame superView:superView childrenFrame:childrenFrame sufient:NO];
    
    if (self)
    {
        self.chooseGenderVC.view.frame = CGRectMake(0, 0, self.originFrame.size.width, self.originFrame.size.height);
        
        self.chooseGenderVC.refreshScrollView.frame = CGRectMake(0, 0, MSW , self.chooseGenderVC.view.height);
        
        
        [self.childredView addSubview:self.chooseGenderVC.view];
        
        self.childredView.clipsToBounds = YES;
        self.chooseGenderVC.view.clipsToBounds = YES;

        
        
    }
    return self;
}


-(YFStudnetChooseGenderVC *)chooseGenderVC
{
    if (!_chooseGenderVC) {
        _chooseGenderVC = [[YFStudnetChooseGenderVC alloc] init];
        self.popSubVC = _chooseGenderVC;
        
        weakTypesYF
        [_chooseGenderVC setSureBlock:^{
            if (weakS.selectBlock) {
                weakS.param = weakS.chooseGenderVC.selectModel.paramOfState;
                weakS.value = weakS.chooseGenderVC.selectModel.name;
                weakS.selectBlock(@"",weakS.chooseGenderVC.selectModel.paramOfState);
            }
        }];
    }
    return _chooseGenderVC;
}


@end
