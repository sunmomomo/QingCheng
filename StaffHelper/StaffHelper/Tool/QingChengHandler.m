//
//  QingChengHandler.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/11/7.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "QingChengHandler.h"

#import "CourseArrangeController.h"

#import "WebViewController.h"

#import "CoachListController.h"

#import "YFModuleManager.h"

#import "YardListController.h"

#import "StaffListController.h"

#import "CardKindListGymController.h"

#import "CardListController.h"

#import "ProgrammeController.h"

#import "AllReportController.h"

#import "CheckinController.h"

#import "ChestListController.h"

#import "FunctionHintController.h"

#import "IntegralListController.h"

#import "AllFunctionController.h"

#import "CheckinSettingController.h"

#import "NewsCommentsController.h"
#import "YFCompetitionModule.h"

#import "ReplyReceivedController.h"
#import "NSString+YFCategory.h"

#import "YFGymModule.h"

@implementation QingChengHandler

+(MOViewController *)handlerOpenURL:(NSURL *)url
{
    
    MOViewController *vc = nil;
    
    if (!StaffId) {
        
        return nil;
        
    }
    
    NSString *path;
    
    if (url.path.length) {
        
        path = [url.path substringFromIndex:1];
        
    }
    
    if ([url.host isEqualToString:@"openurl"]) {
        
        vc = [[WebViewController alloc]init];
        
        ((WebViewController*)vc).url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",path]];
        
    }
    
    if ([url.host isEqualToString:@"news"]) {
        
        if ([url.relativePath isEqualToString:@"/comments"]) {
            
            NSInteger pressId = [[[url.query componentsSeparatedByString:@"="] lastObject]integerValue];
            
            Press *press = [[Press alloc]init];
            
            press.pressId = pressId;
            
            vc = [[NewsCommentsController alloc]init];
            
            ((NewsCommentsController*)vc).press = press;
            
        }else if([url.relativePath isEqualToString:@"/replies"]){
            
            vc = [[ReplyReceivedController alloc]init];
            
        }
        
    }
    
    return vc;
    
}

+(UIViewController *)handlerOpenWithFunction:(Function *)function
{
    
    if ([function.title isEqualToString:@"团课"]) {
        
        if ([PermissionInfo sharedInfo].gym.permissions.groupArrangePermission.readState) {
            
            CourseArrangeController *svc = [[CourseArrangeController alloc]init];
            
            svc.courseType = CourseTypeGroup;
            
            return svc;
            
        }else{
            
            [self showNoPermissionAlert];
            
            return nil;
            
        }
        
    }if ([function.title isEqualToString:@"私教"]) {
        
        if ([PermissionInfo sharedInfo].gym.permissions.privateArrangePermission.readState) {
            
            CourseArrangeController *svc = [[CourseArrangeController alloc]init];
            
            svc.courseType = CourseTypePrivate;
            
            return svc;
            
        }else{
            
            [self showNoPermissionAlert];
            
            return nil;
            
        }
        
    }else if ([function.title isEqualToString:@"代约团课"]){
        
        WebViewController *svc = [[WebViewController alloc]init];
        
        NSString *urlStr = [NSString stringWithFormat:@"%@/fitness/redirect/staff/group/",ROOT];
        
        if (AppGym.shopId && AppGym.brand.brandId) {
            
            urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"?shop_id=%ld&brand_id=%ld",(long)AppGym.shopId,(long)AppGym.brand.brandId]];
            
        }else if (AppGym.gymId && AppGym.type.length){
            
            urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"?id=%ld&model=%@",(long)AppGym.gymId,AppGym.type]];
            
        }
        
        svc.url = [NSURL URLWithString:urlStr];
        
        return svc;
        
    }else if ([function.title isEqualToString:@"代约私教"]){
        
        WebViewController *svc = [[WebViewController alloc]init];
        
        NSString *urlStr = [NSString stringWithFormat:@"%@/fitness/redirect/staff/private/",ROOT];
        
        if (AppGym.shopId && AppGym.brand.brandId) {
            
            urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"?shop_id=%ld&brand_id=%ld",(long)AppGym.shopId,(long)AppGym.brand.brandId]];
            
        }else if (AppGym.gymId && AppGym.type.length){
            
            urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"?id=%ld&model=%@",(long)AppGym.gymId,AppGym.type]];
            
        }
        
        svc.url = [NSURL URLWithString:urlStr];
        
        return svc;
        
    }else if ([function.title isEqualToString:@"教练"]){
        
        if ([PermissionInfo sharedInfo].gym.permissions.coachPermission.readState) {
            
            CoachListController *svc = [[CoachListController alloc]init];
            
            svc.gym = AppGym;
            
            return svc;
            
        }else{
            
            [self showNoPermissionAlert];
            
            return nil;
            
        }
        
    }else if ([function.title isEqualToString:@"课程排期"]){
        
        if ([PermissionInfo sharedInfo].gym.permissions.groupArrangePermission.readState || [PermissionInfo sharedInfo].gym.permissions.privateArrangePermission.readState) {
            
            CourseArrangeController *svc = [[CourseArrangeController alloc]init];
            
            svc.gym = AppGym;
            
            return svc;
            
        }else{
            
            [self showNoPermissionAlert];
            
            return nil;
            
        }
        
    }else if ([function.title isEqualToString:@"会员"]){
        
        if ([PermissionInfo sharedInfo].gym.permissions.userPermission.readState || [PermissionInfo sharedInfo].gym.permissions.personalUserPermission.readState) {
            
            
            UIViewController *studentVC = [YFModuleManager memberFollowUpWithGym:AppGym dicArray:nil actionBlock:nil];
            
            if (studentVC)
            {
                
                return studentVC;
                
            }else{
                
                return nil;
                
            }
        }else{
            
            [self showNoPermissionAlert];
            
            return nil;
            
        }
        
    }else if ([function.title isEqualToString:@"场地"]){
        
        if ([PermissionInfo sharedInfo].gym.permissions.spacePermission.readState) {
            
            YardListController *svc = [[YardListController alloc]init];
            
            svc.gym = AppGym;
            
            return svc;
            
        }else{
            
            [self showNoPermissionAlert];
            
            return nil;
            
        }
        
    }else if ([function.title isEqualToString:@"工作人员"]){
        
        if ([PermissionInfo sharedInfo].gym.permissions.staffPermission.readState) {
            
            StaffListController *svc = [[StaffListController  alloc]init];
            
            svc.gym = AppGym;
            
            return svc;
            
        }else{
            
            [self showNoPermissionAlert];
            
            return nil;
            
        }
        
    }else if ([function.title isEqualToString:@"会员卡种类"]){
        
        if ([PermissionInfo sharedInfo].gym.permissions.cardKindPermission.readState) {
            
            CardKindListGymController *svc = [[CardKindListGymController alloc]init];
            
            return svc;
            
        }else{
            
            [self showNoPermissionAlert];
            
            return nil;
            
        }
        
    }else if ([function.title isEqualToString:@"会员卡"]){
        
        if ([PermissionInfo sharedInfo].gym.permissions.cardPermission.readState||[PermissionInfo sharedInfo].gym.permissions.personalCardPermission.readState) {
            
            
            UIViewController *carkListVC = [YFModuleManager cardListViewControllerGym:AppGym];

            
            return carkListVC;
            
        }else{
            
            [self showNoPermissionAlert];
            
            return nil;
            
        }
        
    }else if ([function.title isEqualToString:@"课程预约"]){
        
        if ([PermissionInfo sharedInfo].gym.permissions.courseOrderPermission.readState||[PermissionInfo sharedInfo].gym.permissions.personalCourseOrderPermission.readState) {
            
            ProgrammeController *svc = [[ProgrammeController alloc]init];
            
            svc.isGym = YES;
            
            svc.gym = AppGym;
            
            return svc;
            
        }else{
            
            [self showNoPermissionAlert];
            
            return nil;
            
        }
        
    }else if ([function.title isEqualToString:@"课程报表"]){
        
        if ([PermissionInfo sharedInfo].gym.permissions.courseReportPermission.readState) {
            
            AllReportController *svc = [[AllReportController alloc]init];
            
            svc.isGym = YES;
            
            svc.gym = AppGym;
            
            svc.type = ReportInfoTypeSchedule;
            
            return svc;
            
        }else{
            
            [self showNoPermissionAlert];
            
            return nil;
            
        }
        
    }else if ([function.title isEqualToString:@"销售报表"]){
        
        if ([PermissionInfo sharedInfo].gym.permissions.sellReportPermission.readState ||[PermissionInfo sharedInfo].gym.permissions.personalSellReportPermission.readState) {
            
            AllReportController *svc = [[AllReportController alloc]init];
            
            svc.isGym = YES;
            
            svc.gym = AppGym;
            
            svc.type = ReportInfoTypeSell;
            
            return svc;
            
        }else{
            
            [self showNoPermissionAlert];
            
            return nil;
            
        }
        
    }else if ([function.title isEqualToString:@"签到报表"]){
        
        if ([PermissionInfo sharedInfo].gym.permissions.checkinReportPermission.readState) {
            
            AllReportController *svc = [[AllReportController alloc]init];
            
            svc.isGym = YES;
            
            svc.gym = AppGym;
            
            svc.type = ReportInfoTypeCheckin;
            
            return svc;
            
        }else{
            
            [self showNoPermissionAlert];
            
            return nil;
            
        }
        
    }else if ([function.title isEqualToString:@"签到处理"]){
        
        if ([PermissionInfo sharedInfo].gym.permissions.checkinPermission.readState){
            
            CheckinController *svc = [[CheckinController alloc]init];
            
            svc.gym = AppGym;
            
            return svc;
            
        }else{
            
            [self showNoPermissionAlert];
            
            return nil;
            
        }
        
    }else if ([function.title isEqualToString:@"入场签到"]){
        
        if ([PermissionInfo sharedInfo].gym.permissions.checkinPermission.addState){
            
            CheckinSettingController *svc = [[CheckinSettingController alloc]init];
            
            return svc;
            
        }else{
            
            [self showNoPermissionAlert];
            
            return nil;
            
        }
        
    }else if ([function.title isEqualToString:@"更衣柜"]){
        
        if ([PermissionInfo sharedInfo].gym.permissions.lockerPermission.readState){
            
            ChestListController *svc = [[ChestListController alloc]init];
            
            return svc;
            
        }else{
            
            [self showNoPermissionAlert];
            
            return nil;
            
        }
        
    }else if ([function.title isEqualToString:@"会员积分"]){
        
        IntegralListController *svc = [[IntegralListController alloc]init];
        
        return svc;
        
    }else if([function.title isEqualToString:@"全部功能"]){
        
        AllFunctionController *svc = [[AllFunctionController alloc]init];
        
        return svc;
        
    }else{
        
        NSString *module = function.module;
        
        if([function.title isEqualToString:@"场馆信息"])
        {
            if ([PermissionInfo sharedInfo].permissions.studioPermission.readState && [PermissionInfo sharedInfo].permissions.studioPermission.editState) {
                
                UIViewController *svc = [YFGymModule modifyGymVCWithGym:AppGym modifySuccessBlock:nil];
                
                return svc;
                
            }else if ([PermissionInfo sharedInfo].permissions.studioPermission.readState)
            {
                UIViewController *svc = [YFGymModule scanGymVCWithGym:AppGym];
                
                return svc;
            }
            else{
                
                
                [self showNoPermissionAlert];
                
                return nil;
                
            }
            
        }else if([function.title isEqualToString:@"营业时间"])
        {
            
            if ([PermissionInfo sharedInfo].permissions.studioPermission.readState) {
                
                FunctionHintController *svc = [[FunctionHintController alloc]init];
                
                svc.module = module;
                
                return svc;
                
            }else{
                
                [self showNoPermissionAlert];
                
                return nil;
                
            }
            
        }else if([function.title isEqualToString:@"短信提醒"])
        {
            
            if ([PermissionInfo sharedInfo].permissions.messagePermission.readState) {
                
                FunctionHintController *svc = [[FunctionHintController alloc]init];
                
                svc.module = module;
                
                return svc;
                
            }else{
                
                [self showNoPermissionAlert];
                
                return nil;
                
            }
            
        }else if([function.title isEqualToString:@"权限管理"])
        {
            
            if ([PermissionInfo sharedInfo].permissions.permissionPermission.readState) {
                
                FunctionHintController *svc = [[FunctionHintController alloc]init];
                
                svc.module = module;
                
                return svc;
                
            }else{
                
                [self showNoPermissionAlert];
                
                return nil;
                
            }
            
        }else if([function.title isEqualToString:@"约课限制"])
        {
            
            if ([PermissionInfo sharedInfo].permissions.courseOrderPermission.readState) {
                
                FunctionHintController *svc = [[FunctionHintController alloc]init];
                
                svc.module = module;
                
                return svc;
                
            }else{
                
                [self showNoPermissionAlert];
                
                return nil;
                
            }
            
        }else if([function.title isEqualToString:@"体测数据模板"])
        {
            
            if ([PermissionInfo sharedInfo].permissions.measureSettingPermission.readState) {
                
                FunctionHintController *svc = [[FunctionHintController alloc]init];
                
                svc.module = module;
                
                return svc;
                
            }else{
                
                [self showNoPermissionAlert];
                
                return nil;
                
            }
            
        }else if([function.title isEqualToString:@"课程计划模板"])
        {
            
            if ([PermissionInfo sharedInfo].permissions.coursePlansSettingPermission.readState) {
                
                FunctionHintController *svc = [[FunctionHintController alloc]init];
                
                svc.module = module;
                
                return svc;
                
            }else{
                
                [self showNoPermissionAlert];
                
                return nil;
                
            }
            
        }else if([function.title isEqualToString:@"账单"])
        {
            
            if ([PermissionInfo sharedInfo].permissions.billPermission.readState) {
                
                FunctionHintController *svc = [[FunctionHintController alloc]init];
                
                svc.module = module;
                
                return svc;
                
            }else{
                
                [self showNoPermissionAlert];
                
                return nil;
                
            }
            
        }else if([function.title isEqualToString:@"支付设置"])
        {
            
            if ([PermissionInfo sharedInfo].permissions.paySettingPermission.readState) {
                
                FunctionHintController *svc = [[FunctionHintController alloc]init];
                
                svc.module = module;
                
                return svc;
                
            }else{
                
                [self showNoPermissionAlert];
                
                return nil;
                
            }
            
        }else if([function.title isEqualToString:@"接入口碑网"])
        {
            
            if ([PermissionInfo sharedInfo].permissions.koubeiPermission.readState) {
                
                FunctionHintController *svc = [[FunctionHintController alloc]init];
                
                svc.module = module;
                
                return svc;
                
            }else{
                
                [self showNoPermissionAlert];
                
                return nil;
                
            }
            
        }else if([function.title isEqualToString:@"活动"])
        {
            
            if ([PermissionInfo sharedInfo].permissions.activitySettingPermission.readState) {
                
                FunctionHintController *svc = [[FunctionHintController alloc]init];
                
                svc.module = module;
                
                return svc;
                
            }else{
                
                [self showNoPermissionAlert];
                
                return nil;
                
            }
            
        }else if([function.title isEqualToString:@"广告位"])
        {
            
            if ([PermissionInfo sharedInfo].permissions.advertisementPermission.readState) {
                
                FunctionHintController *svc = [[FunctionHintController alloc]init];
                
                svc.module = module;
                
                return svc;
                
            }else{
                
                [self showNoPermissionAlert];
                
                return nil;
                
            }
            
        }else if([function.title isEqualToString:@"场馆公告"])
        {
            
            if ([PermissionInfo sharedInfo].permissions.noticePermission.readState) {
                
                FunctionHintController *svc = [[FunctionHintController alloc]init];
                
                svc.module = module;
                
                return svc;
                
            }else{
                
                [self showNoPermissionAlert];
                
                return nil;
                
            }
        }else if([function.title isEqualToString:@"赛事训练营"])
        {
            UIViewController *contestVC = [YFCompetitionModule contestListVC];
            
        return contestVC;
        }
        else if([function.title isEqualToString:@"注册送会员卡"])
        {
            
            if ([PermissionInfo sharedInfo].permissions.giftCardPermission.readState) {
                
                FunctionHintController *svc = [[FunctionHintController alloc]init];
                
                svc.module = module;
                
                return svc;
                
            }else{
                
                [self showNoPermissionAlert];
                
                return nil;
                
            }
            
        }else if([function.title isEqualToString:@"商店"])
        {
            
            if ([PermissionInfo sharedInfo].permissions.productPermission.readState) {
                
                FunctionHintController *svc = [[FunctionHintController alloc]init];
                
                svc.module = module;
                
                return svc;
                
            }else{
                
                [self showNoPermissionAlert];
                
                return nil;
                
            }
            
        }else if ([function.title isEqualToString:@"自由训练"]){
            
            FunctionHintController *svc = [[FunctionHintController alloc]init];
            
            svc.module = module;
            
            return svc;
            
        }else if ([function.title isEqualToString:@"体测表模板"]){
            
            FunctionHintController *svc = [[FunctionHintController alloc]init];
            
            svc.module = module;
            
            return svc;
            
        }else if ([function.title isEqualToString:@"主页广告"]){
            
            FunctionHintController *svc = [[FunctionHintController alloc]init];
            
            svc.module = module;
            
            return svc;
            
        }else if ([function.title isEqualToString:@"在线支付"]){
            
            FunctionHintController *svc = [[FunctionHintController alloc]init];
            
            svc.module = module;
            
            return svc;
            
        }else if ([function.title isEqualToString:@"评分报表"]){
            
            FunctionHintController *svc = [[FunctionHintController alloc]init];
            
            svc.module = module;
            
            return svc;
            
        }else if ([function.title isEqualToString:@"会员卡报表"]){
            
            FunctionHintController *svc = [[FunctionHintController alloc]init];
            
            svc.module = module;
            
            return svc;
            
        }else if ([function.title isEqualToString:@"短信"]){
            
            FunctionHintController *svc = [[FunctionHintController alloc]init];
            
            svc.module = module;
            
            return svc;
            
        }else if ([function.title isEqualToString:@"会员端配置"]){
            
            FunctionHintController *svc = [[FunctionHintController alloc]init];
            
            svc.module = module;
            
            return svc;
            
        }else if ([function.title isEqualToString:@"微信公众号"]){
            
            FunctionHintController *svc = [[FunctionHintController alloc]init];
            
            svc.module = module;
            
            return svc;
            
        }else{
            
            return nil;
            
        }
        
    }
    
}


+(void)showNoPermissionAlert
{
    
    [[[UIAlertView alloc]initWithTitle:@"抱歉，您无该功能权限" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    
}


@end
