//
//  YFModuleManager.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFModuleManager.h"

#import "Gym.h"

#import "YFStudentListVC.h"

#import "YFSliderViewController.h"

#import "YFStudentListRightVC.h"

#import "YFChooseRecoVC.h"
#import "YFStudentFilterRePeoModel.h"
#import "YFStudentFollowingVC.h"
#import "YFStudentStateDetailVC.h"
#import "YFHttpService.h"
#import "YFConditionSellerPopView.h"
#import "YFConditionOriginPopView.h"
#import "YFConditionRecommPopView.h"

// 销售名下会员
#import "SellerBelongUserController.h"

#import "CardListController.h"

#import "YFCardKindPopView.h"

#import "YFCardStatePopView.h"

#import "YFGroupSmsVC.h"

#import "SellerUserBatchEditController.h"

#import "YFConditionTimeUpgradePopView.h"
#import "CoachBelongUserController.h"

#import "YFSellerFiterViewModel.h"

#import "NSObject+firterModel.h"

#import "YFConditionStatusPopView.h"

#import "YFConditionGenderPopView.h"

@implementation YFModuleManager

+ (UIViewController *)memberFollowUpWithGym:(Gym *)gym dicArray:(NSArray *)dataArray actionBlock:(void (^)(NSUInteger))actionBlock
{
    YFSliderViewController *sliderVC = [[YFSliderViewController alloc] init];
    
    
    sliderVC.isBulr = NO;
    sliderVC.canSpanShowingRight = NO;
    YFStudentListRightVC *rightVC = [[YFStudentListRightVC alloc] init];
    rightVC.isFilter = YES;
    rightVC.gym = gym;
    sliderVC.rightVC = rightVC;
    
    __weak typeof(rightVC)rightWeak = rightVC;
    [sliderVC setShowMiddleVc:^{
        [rightWeak.view endEditing:YES];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }];

    [sliderVC setFinishShowRight:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }];

    
    YFStudentListVC *svc = [[YFStudentListVC alloc]init];
    svc.dataArray = dataArray;
    svc.gym = gym;
    svc.rightVC  = rightVC;
    svc.sliderVC = sliderVC;
    sliderVC.mainVC = svc;
    svc.headerActionBlock = actionBlock;
    
    rightVC.sureBlock = svc.sureBlock;
    sliderVC.rightViewShowScale = StudentRightShowScale;
    
    return sliderVC;
}


+ (UIViewController *)chooseOriginWithOriginId:(NSString *)originId selectBlock:(void (^)(NSString*,NSString*))selectBlock
{
        YFChooseRecoVC *recoVC = [[YFChooseRecoVC alloc] init];
    recoVC.title = @"选择推荐人";
        __weak typeof(recoVC)weakVC = recoVC;
        [recoVC setSelectBlock:^{
            if (selectBlock) {
                selectBlock(weakVC.selectModel.r_id,weakVC.selectModel.username);
            }
        }];
    return recoVC;
}

+ (UIViewController *)studentFollowingWithGym:(Gym *)gym;
{
    YFStudentFollowingVC *followVC = [[YFStudentFollowingVC alloc] init];
    followVC.gym = gym;
    return followVC;
}

+ (void)studentNewMemberWithGym:(Gym *)gym tag:(NSUInteger)tag viewController:(void (^)(UIViewController *))vcBlock
{
    if ((gym.gymId <= 0|| gym.type.length <= 0 ) && (gym.shopId <= 0 || gym.brand.brandId <= 0)) {
        return;
    }
    YFStudentStateDetailVC *stateVC = [[YFStudentStateDetailVC alloc] init];
    
    stateVC.gym = gym;
    
    NSString *sellerStr;
    if ([PermissionInfo sharedInfo].permissions.userPermission.readState == PermissionStateNone) {
        
        if ([YFHttpService sharedInstance].info.staff.name)
        {
            sellerStr =[YFHttpService sharedInstance].info.staff.name;
        }else
        {
            weakTypesYF
            [YFHttpService getUseNameComplete:^{
                [weakS studentNewMemberWithGym:gym tag:tag viewController:vcBlock];
            }];
            return;
        }
    }
    
    
    NSUInteger state = tag - 1;
    if (state == YFIsNewRe.integerValue)
    {
        if (sellerStr.length == 0)
        {
            sellerStr = @"销售";
        }
        
        stateVC.status = YFIsNewRe;
        stateVC.title = @"新增注册";
        stateVC.emptyStr = @"新增注册";
        stateVC.buttonTitlesArray = @[@"会员状态",@"今日",sellerStr,@"筛选"];
        stateVC.classsArray = @[[YFConditionStatusPopView class],[YFConditionTimeUpgradePopView class],[YFConditionSellerPopView class]];
        stateVC.fiterOtherModelCaYF.isCanFilterSeller = YES;
        stateVC.fiterOtherModelCaYF.isShouldChooseTodayWhenClear = YES;
        
        __weak typeof(stateVC)weakStateVC = stateVC;
        UIViewController *fiterVC = [YFSellerFiterViewModel addFilterVCToVC:stateVC gym:gym sureBlock:^(id model) {
            [weakStateVC refreshTableListDataForFilter];
        }];
        
        
        [stateVC setClickWithIndex:^(NSUInteger index) {
            
            if (index == 3)
            {
                if (weakStateVC.showRightBlockCaYF)
                {
                    weakStateVC.showRightBlockCaYF(nil);
                }
            }
            
        }];
        
        [stateVC.nomalUpImageArray replaceObjectAtIndex:3 withObject:@"TriangleFilter"];
        [stateVC.nomalDownImageArray replaceObjectAtIndex:3 withObject:@"TriangleFilter"];
        [stateVC.selectUpImageArray replaceObjectAtIndex:3 withObject:@"TriangleFilterGreen"];
        [stateVC.selectDownImageArray replaceObjectAtIndex:3 withObject:@"TriangleFilterGreen"];
        
        if (vcBlock) {
            vcBlock(fiterVC);
        }
        return;
    }else if (state == YFIsFollowing.integerValue){
        if (sellerStr.length == 0)
        {
            sellerStr = @"销售";
        }
        stateVC.status = YFIsFollowing;
        stateVC.title = @"新增跟进";
        stateVC.emptyStr = @"新增跟进";
        stateVC.buttonTitlesArray = @[@"会员状态",@"今日",sellerStr,@"性别"];
        stateVC.classsArray = @[[YFConditionStatusPopView class],[YFConditionTimeUpgradePopView class],[YFConditionSellerPopView class],[YFConditionGenderPopView class]];
        
    }else if (state == YFIsMember.integerValue){
        if (sellerStr.length == 0)
        {
            sellerStr = @"销售";
        }
        stateVC.status = YFIsMember;
        stateVC.title = @"新增会员";
        stateVC.emptyStr = @"新增会员";
        stateVC.buttonTitlesArray = @[sellerStr,@"今日",@"性别"];
        stateVC.classsArray = @[[YFConditionSellerPopView class],[YFConditionTimeUpgradePopView class],[YFConditionGenderPopView class]];
        
    }
    if (vcBlock) {
        vcBlock(stateVC);
    }
}

#pragma mark -- 销售分配
+ (UIViewController *)belongSellerViewControllerWith:(Seller *)seller gym:(Gym *)gym
{
    SellerBelongUserController *svc = [[SellerBelongUserController alloc]init];
    
    svc.seller = seller;
    
    if (seller.type == SellerTypeNone)
    {
        svc.seller_id = @"0";
    }else
    {
        svc.seller_id = seller.sellerStrId;
    }
    
    svc.gym = gym;
    
    return [YFSellerFiterViewModel  setFilterRightVcToVC:svc gym:gym fiterViewModel:nil];
}

+(UIViewController*)belongCoachViewControllerWith:(Coach *)coach gym:(Gym *)gym
{
    CoachBelongUserController *svc = [[CoachBelongUserController alloc]init];
    
    svc.gym = gym;
    
    svc.coach = coach;
    
    if (coach.type == CoachDistributeTypeNone)
    {
        svc.coach_id = @"0";
    }else
    {
        svc.coach_id = [NSString stringWithFormat:@"%ld",(long)coach.coachId];
    }
    
    return [YFSellerFiterViewModel  setFilterRightVcToVC:svc gym:gym fiterViewModel:nil];
}


#pragma mark -- 会员卡
+ (UIViewController *)cardListViewControllerGym:(Gym *)gym
{
    CardListController *svc = [[CardListController alloc]init];
    
    svc.isNotSuffient = NO;
    
    svc.buttonTitlesArray = @[@"会员卡种类",@"会员卡状态"];
    
    svc.classsArray = @[[YFCardKindPopView class],[YFCardStatePopView class]];
    
    svc.gym = gym;
    
    return svc;
}
// 余额不足
+ (UIViewController *)cardListOfNotSuffientViewControllerGym:(Gym *)gym
{
    CardListController *svc = [[CardListController alloc]init];
    
    svc.isNotSuffient = YES;
    
    svc.buttonTitlesArray = @[@"会员卡种类",@"会员卡状态"];
    
    svc.classsArray = @[[YFCardKindPopView class],[YFCardStatePopView class]];
    
    svc.gym = gym;
    
    return svc;
}
// 选择会员
+ (UIViewController *)chooseStudentViewControllerGym:(Gym *)gym choosedArray:(NSMutableArray *)chooseArray isShowSelectView:(BOOL)isShow chooseBlock:(void(^)(NSMutableArray *))chooseBlock
{
    YFSellerFiterViewModel *sellerFiterModel = [YFSellerFiterViewModel dataModel];
    sellerFiterModel.fiterOtherModelCaYF.isCanFilterBirthday = YES;
    
    SellerUserBatchEditController *svc = [[SellerUserBatchEditController alloc]init];
    
    svc.chooseArray = chooseArray;
    
    svc.isChooseStudent = YES;
    
    svc.isShowSelectView = isShow;
    
    svc.seller_id = @"0";
    
    svc.chooseStudentsBlock = chooseBlock;
    
    return [YFSellerFiterViewModel  setFilterRightVcToVC:svc gym:gym fiterViewModel:sellerFiterModel];
}



// 群发短信
+ (UIViewController *)groupSmsViewControllerGym:(Gym *)gym
{
    YFGroupSmsVC *smsVC = [[YFGroupSmsVC alloc] init];
    
    smsVC.gym = gym;
    
    return smsVC;
}





@end
