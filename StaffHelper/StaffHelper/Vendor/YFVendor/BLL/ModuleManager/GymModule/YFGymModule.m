//
//  YFGymModule.m
//  StaffHelper
//
//  Created by FYWCQ on 17/4/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFGymModule.h"

#import "YFModifyGymDetailController.h"

#import "YFScanGymDetailController.h"

@implementation YFGymModule

+ (UIViewController *)modifyGymVCWithGym:(Gym *)gym modifySuccessBlock:(void (^)(id))modifySuccessBlock
{
    YFModifyGymDetailController *svc = [[YFModifyGymDetailController alloc]init];
    
    svc.gym = [gym copy];
    
    svc.origingym = gym;
    
    svc.modifySuccess = modifySuccessBlock;
    
    return svc;

}

+ (UIViewController *)scanGymVCWithGym:(Gym *)gym
{
    YFScanGymDetailController *svc = [[YFScanGymDetailController alloc]init];
    
    svc.gym = gym;
    
    return svc;

}

@end
