//
//  YFConditionRecommPopView.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFConditionRecommPopView.h"
#import "YFStudentRecommendVC.h"


@interface YFConditionRecommPopView ()

@property(nonatomic, strong)YFStudentRecommendVC *recomendVC;

@end

@implementation YFConditionRecommPopView


-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView
{
    self = [super initWithFrame:frame superView:superView];
    if (self)
    {
        self.recomendVC = [[YFStudentRecommendVC alloc] init];
        
        weakTypesYF
        [self.recomendVC setSelectBlock:^{
            if (weakS.selectBlock)
            {
                if ([weakS.recomendVC.selectModel.username isEqualToString:@"全部"]) {
                    weakS.isValidParam = NO;
                }else
                {
                    weakS.isValidParam = YES;
                }
                weakS.selectBlock(weakS.value,weakS.param);
            }
        }];

        [self.childredView addSubview:self.recomendVC.view];

        self.recomendVC.view.frame = self.bounds;
        self.recomendVC.baseTableView.frame = self.bounds;
        
    }
    return self;
}


-(void)setGym:(Gym *)gym
{
    [super setGym:gym];
    self.recomendVC.gym = gym;
}


-(NSDictionary *)param
{
    if (self.recomendVC.selectModel.r_id.length)
    {
        return @{@"recommend_user_id":self.recomendVC.selectModel.r_id};
    }
    return @{};
}

-(NSString *)value
{
//    if (self.recomendVC.selectModel.username)
//    {
//        return self.recomendVC.selectModel.username;
//    }
    return @"";
}

- (void)afterSetAllConditionsParam:(NSDictionary *)patamDic
{
}


@end
