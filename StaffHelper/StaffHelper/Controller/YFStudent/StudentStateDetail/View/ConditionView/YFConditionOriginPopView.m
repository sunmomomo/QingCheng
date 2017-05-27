//
//  YFConditionOriginPopView.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFConditionOriginPopView.h"
#import "YFStudnetOriginVC.h"

@interface YFConditionOriginPopView ()

@property(nonatomic, strong)YFStudnetOriginVC *originVC;

@end

@implementation YFConditionOriginPopView

-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView
{
    self = [super initWithFrame:frame superView:superView];
    if (self)
    {
        self.originVC = [[YFStudnetOriginVC alloc] init];
        self.originVC.isFilter = YES;
        weakTypesYF
        [self.originVC setSelectBlock:^{
            if (weakS.selectBlock)
            {
                if ([weakS.originVC.selectModel.name isEqualToString:@"全部"]) {
                    weakS.isValidParam = NO;
                }else
                {
                    weakS.isValidParam = YES;
                }
                weakS.selectBlock(weakS.value,weakS.param);
            }
        }];
        
        [self.childredView addSubview:self.originVC.view];
        
        self.originVC.view.frame = self.bounds;
        self.originVC.baseTableView.frame = self.bounds;
        
        
    }
    return self;
}

-(void)setGym:(Gym *)gym
{
    [super setGym:gym];
    self.originVC.gym = gym;
}

-(NSDictionary *)param
{
    if (self.originVC.selectModel.name.length && [self.originVC.selectModel.name isEqualToString:@"全部"] == NO)
    {
        return @{@"origin":self.originVC.selectModel.name};
    }
    return @{};
}


- (void)setOriginFrame:(CGRect)originFrame
{
    [super setOriginFrame:originFrame];
    
    self.originVC.view.frame = CGRectMake(0, 0, originFrame.size.width, originFrame.size.height);
    self.originVC.baseTableView.frame = self.originVC.view.bounds;
}

-(NSString *)value
{
//    if (self.originVC.selectModel.name)
//    {
//        return self.originVC.selectModel.name;
//    }
    return @"";
}

- (void)afterSetAllConditionsParam:(NSDictionary *)patamDic
{

}

- (void)afterSetRightVCAllConditionsParam:(NSDictionary *)patamDic
{
    NSString *name = patamDic[@"origin"];
    
    [self.originVC setChooseName:name];
}


@end
