//
//  YFAppService.m
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/14.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFAppService.h"

#import "YFAlertView.h"

#import "YFStaticsSubModel.h"
#import "UIAlertView+YFAdditions.h"

@implementation YFAppService

+(void)asypath:(void (^)())action mainAction:(void (^)())mainAction
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 清除缓存
        action();
        //回调 主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            //调用Block
            if (mainAction)
            {
                mainAction();
            }
        });
    });
}

+(void)showAlertMessage:(NSString *)message
{
    [YFAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
        
    } title:message message:nil cancelButtonName:@"确定" otherButtonTitles:nil];
}

+(void)showAlertMessageWithError:(NSError *)error
{
    [self showAlertMessage:[self errorStringFromError:error]];
}

+(void)showAlertMessage:(NSString *)message oneTitle:(NSString *)oneTitle
{
    [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
        
    } title:message message:nil cancelButtonName:oneTitle otherButtonTitles:nil];
}

+(void)showAlertMessage:(NSString *)message sureTitle:(NSString *)sureTitle sureBlock:(void(^)())sureBlock
{
    
    [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
        
        if (buttonIndex == 1)
        {
            if (sureBlock)
            {
                sureBlock();
            }
        }
//        NSLog(@"%ld",buttonIndex);
        
    } title:message message:nil cancelButtonName:@"取消" otherButtonTitles:sureTitle,nil];
    
//    [YFAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
//        if (buttonIndex == 1)
//        {
//            if (sureBlock)
//            {
//                sureBlock();
//            }
//        }
//        NSLog(@"%ld",buttonIndex);
//    } title:@"温馨提示" message:message cancelButtonName:@"取消" otherButtonTitles:sureTitle,nil];

}

+(void)showAlertMessage:(NSString *)message sureBlock:(void(^)())sureBlock
{
    [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
        
        if (buttonIndex == 1)
        {
            if (sureBlock)
            {
                sureBlock();
            }
        }
//        NSLog(@"%ld",buttonIndex);
        
    } title:message message:nil cancelButtonName:@"取消" otherButtonTitles:@"确定",nil];
}

+(void)showAlertMessage:(NSString *)message onlySureBlock:(void(^)())sureBlock
{
    [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
        
        if (buttonIndex == 0)
        {
            if (sureBlock)
            {
                sureBlock();
            }
        }
        //        NSLog(@"%ld",buttonIndex);
        
    } title:message message:nil cancelButtonName:@"确定" otherButtonTitles:nil];
}


+(NSString *)errorStringFromError:(NSError *)error
{
    
    if(error.code == -1009)
    {
        // 网络断开链接
        return @"网络断开链接";
    }
    
//    -999 取消
    //    kCFURLErrorCannotFindHost
    //        else if (error.code == -1003 || error.code == - 1004)
    //        {
    //            // 服务器异常
    //        }else if (error.code == -1001)
    //        {
    //            // 网络超时
    //        }else if (error.code == 3848)// 这种情况 是在 开发时 用的 上线时 这种情况不用处理 可以归为网络异常 或别的 上线之后 出现情况 找写接口的那口子  让他改
    //        {
    //            // 转换json 格式错误
    //        }else
    //        {
    //            //
    //            NSLog(@" 未处理 %ld error.code",(long)error.code);
    //        }
    return @"网络不给力";
}

/*
 //    kCFURLErrorCannotFindHost = -1003, // 找不到服务器
 //    kCFURLErrorCannotConnectToHost = -1004, // 链接不上服务器
 //   kCFURLErrorNotConnectedToInternet = -1009 // 网络断开
 //kCFURLErrorCancelled = -999 取消下载  （operation cancel）
 
 //    if(error.code == -1009)
 //    {
 //        // 网络断开链接
 //    }else if (error.code == -1003 || error.code == - 1004)
 //    {
 //        // 服务器异常
 //    }else if (error.code == -1001)
 //    {
 //        // 网络超时
 //    }else if (error.code == 3848)// 这种情况 是在 开发时 用的 上线时 这种情况不用处理 可以归为网络异常 或别的 上线之后 出现情况 找写接口的那口子  让他改
 //    {
 //        // 转换json 格式错误
 //    }else
 //    {
 //        //
 //        NSLog(@" 未处理 %ld error.code",(long)error.code);
 //    }
 //
 //    // 实际开发 时可能处理的情况 都是几种合在一起的 比如网易新闻  请求失败 都是 网络不给力 一种处理方式

 */

- (void)solveSevenDaySortModelArray:(NSMutableArray *)array widthDaysArray:(NSArray *)daysArray
{

}


@end
