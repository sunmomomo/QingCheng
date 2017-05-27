//
//  YFConditionTimeUpgradeBasePopView.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/5/5.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFConditionTimeUpgradeBasePopView.h"

@interface YFConditionTimeUpgradeBasePopView ()

@end

@implementation YFConditionTimeUpgradeBasePopView

-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView
{
    self = [super initWithFrame:frame superView:superView];
    if (self)
    {
        self.isValidParam = YES;
        self.timeVC = [[YFStudentChooseLatestTimeVC alloc] init];
       
        [self settingTimeVC];
        weakTypesYF
        [self.timeVC setSelectBlock:^{
            if (weakS.selectBlock)
            {
                weakS.isValidParam = YES;

                weakS.conditionsParam = weakS.timeVC.conditionsParam;
                
                weakS.selectBlock(weakS.value,weakS.param);
            }
        }];
        [self.childredView addSubview:self.timeVC.view];
        
        self.timeVC.view.frame = CGRectMake(0, 0, self.frame.size.width, 186);
        
        self.timeVC.baseTableView.frame = self.timeVC.view.bounds;
        
        self.isValidParam = YES;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.childredView.backgroundColor = [UIColor clearColor];
        
        self.chirderViewSuperView.backgroundColor = RGBA_YF(0, 0, 0, 0.5);
    }
    return self;
}
- (void)settingTimeVC
{
    
}


- (void)setOriginFrame:(CGRect)originFrame
{
    [super setOriginFrame:originFrame];
    self.chirdrenHeight = 186;
    if (self.timeVC.view.height != 186)
    {
        self.timeVC.view.frame = CGRectMake(self.timeVC.view.mj_y, 0, MSW, 186);
        self.timeVC.baseTableView.frame = CGRectMake(self.timeVC.baseTableView.mj_x, 0, MSW, 186);
    }
}


-(void)hide
{
    [self hideAnimate:YES];
}
-(void)show
{
    
    self.chirdrenHeight = 186;
    //    self.childredView.frame =CGRectMake(self.childredView.mj_x, self.childredView.mj_y, MSW, 93);
    
    [self showAnimate:YES];
//#warning NONONONO
    if (self.timeVC.view.height != 186)
    {
        self.timeVC.view.frame = CGRectMake(self.timeVC.view.mj_y, 0, MSW, 186);
        self.timeVC.baseTableView.frame = CGRectMake(self.timeVC.baseTableView.mj_y, 0, MSW, 186);
    }
}


-(NSDictionary *)conditionsParam
{
    if (self.timeVC.conditionsParam.count) {
        return self.timeVC.conditionsParam;
    }
    return [super conditionsParam];
}

-(NSDictionary *)param
{
    if (self.timeVC.param)
    {
        return self.timeVC.param;
    }
    return @{};
}

-(NSString *)value
{
    return self.timeVC.selectModel.valueStr;;
}

-(void)setTitle:(NSString *)title
{
    self.timeVC.title = title;
    [super setTitle:title];
}

- (void)afterSetRightVCAllConditionsParam:(NSDictionary *)patamDic
{
    self.timeVC.start = patamDic[@"start"];
    self.timeVC.end = patamDic[@"end"];
    self.timeVC.timeType = [patamDic[YFIsRegisterTimeKey] integerValue];
    
}

@end
