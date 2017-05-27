//
//  YFCompetitionModule.m
//  StaffHelper
//
//  Created by FYWCQ on 17/4/9.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFCompetitionModule.h"

#import "YFContestListVC.h"

#import "YFSignUpListVC.h"

#import "YFSignUpPerDetailVC.h"

#import "YFSignUpListAddPerVC.h"

#import "YFSignUpListAddGroupVC.h"

#import "YFChooseGymVC.h"

#import "WebViewController.h"


@implementation YFCompetitionModule


+ (UIViewController *)contestListVC
{
    WebViewController *contestVC = [[WebViewController alloc] init];
    contestVC.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/mobile/staff/training/",ROOT]];
    return contestVC;
}

+ (UIViewController *)signUpListVCWithGym:(NSNumber *)gym_id comeptitionId:(NSNumber *)comeptition_id
{
    if (comeptition_id.integerValue <= 0)
    {
        return nil;
    }
    YFSignUpListVC *contestVC = [[YFSignUpListVC alloc] init];
    contestVC.gym_id = gym_id;
    contestVC.comeptition_id = comeptition_id;
    return contestVC;
}

+ (UIViewController *)signUpChoosePerListVCWithGym:(NSNumber *)gym_id comeptitionId:(NSNumber *)comeptition_id chooseidNumSet:(NSSet *)chooseidNumSet completion:(void(^)(NSMutableArray *,id))chooseBlock
{
    if (comeptition_id.integerValue <= 0)
    {
        return nil;
    }
    
    YFSignUpListAddPerVC *contestVC = [[YFSignUpListAddPerVC alloc] init];
    contestVC.gym_id = gym_id;
    contestVC.title = @"添加成员";
    contestVC.competition_id = comeptition_id;
    contestVC.chooseArrayB = chooseBlock;
    contestVC.choosedNumIdDic = chooseidNumSet;
    
    return contestVC;
}


+ (UIViewController *)signUpAddGroupListVCWithGym:(NSNumber *)gym_id comeptitionId:(NSNumber *)comeptition_id completion:(void(^)(id))addBlock
{
    if (comeptition_id.integerValue <= 0)
    {
        return nil;
    }
    YFSignUpListAddGroupVC *contestVC = [[YFSignUpListAddGroupVC alloc] init];
    contestVC.gym_id = gym_id;
    contestVC.addSuccessBlock = addBlock;
    contestVC.comeptition_id = comeptition_id;
    return contestVC;
}

+ (UIViewController *)signUpDetailVCOrderId:(NSNumber *)orderId
{
    YFSignUpPerDetailVC *detailVC = [[YFSignUpPerDetailVC alloc] init];
    
    detailVC.orderId = orderId;
    
    return detailVC;
}

+ (UIViewController *)chooseGymVCCompletion:(void(^)(NSDictionary*))gymBlock
{
    YFChooseGymVC *gymVC = [[YFChooseGymVC alloc] init];
    
    gymVC.chooseGymBlock = gymBlock;
    
    return gymVC;
}

@end
