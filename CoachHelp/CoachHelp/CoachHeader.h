//
//  CoachHelper.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/15.
//  Copyright (c) 2015年 馍馍帝👿. All rights reserved.
//

#ifdef __OBJC__
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIViewController+BackButtonHandler.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "MOAFHelp.h"
#import "UIView+Frame.h"
#import "Parameters.h"
#import "Login.h"
#import "UILabel+AutoSize.h"
#import "Enum.h"
#import "UIScrollView+EmptyDataSet.h"
#import "UIImage+Category.h"
#import "AppDelegate.h"
#import "PermissionInfo.h"
#import "NSString+Category.h"
#import "NSObject+FBKVOController.h"
#import "UIView+CustomAutoLayout.h"
#import "ColorHeaders.h"
#import "ConstHeader.h"
#import "AnimationHeaders.h"

typedef void(^RequestCallBack)(BOOL success,NSString *error);

#endif

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#ifndef _______jlzs_h
#define _______jlzs_h


#endif

#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

#define SESSIONERROR 400001

//客服电话

#define QCPhone @"400-900-7986"

//版本号
#define VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define AppIsAppStore 0

#define AppDebug 1

#define LocalServer 0

#define UMKey @"5657d16ae0f55a276c004065"

//APP name

#if AppIsAppStore
#define APPNAME @"TrainerAppStore"
#else
#define APPNAME @"Trainer"
#endif

//微信key

#if AppIsAppStore
#define WXKEY @"wxfd52b612935d84ea"
#else
#define WXKEY @"wx81e378c8fd03319d"
#endif


#if AppDebug
#define TencentIMType 12162
#else
#define TencentIMType 12165
#endif

#if AppDebug
#define TencentIMID 1400029014
#else
#define TencentIMID 1400029022

#endif

//BPushKey

#if AppIsAppStore
#define BPUSHKEY @"Ep0PPHw3uKytxGhuZU2344Ys"
#else
#if AppDebug
#define BPUSHKEY @"5PwmN7f86ru61DsGwPhN1Qva"
#else
#define BPUSHKEY @"8GcpaltlqsX3Ln4kZkz58CPu"
#endif
#endif

//高德Key

#if AppIsAppStore
#define GDKEY @"109b4d7e06754bf1cd08fef50896f07b"
#else
#define GDKEY @"760672b8986bc3bef97f745c649d984c"
#endif

//RootAPI

#if AppDebug
#define ROOT [[NSUserDefaults standardUserDefaults]boolForKey:@"localServer"]?@"http://dev.qingchengfit.cn:7777":@"http://cloudtest.qingchengfit.cn"
#else
#define ROOT @"http://cloud.qingchengfit.cn"
#endif

#if AppIsAppStore

// AppStore版本
#if DEBUG

#if AppDebug
#define TIMPushID 4522
#else
#define TIMPushID 4530
#endif

#else

#if AppDebug
#define TIMPushID 4523
#else
#define TIMPushID 4531
#endif

#endif

#else

#if DEBUG

#if AppDebug
#define TIMPushID 4520
#else
#define TIMPushID 4528
#endif

#else

#if AppDebug
#define TIMPushID 4521
#else
#define TIMPushID 4529
#endif

#endif

#endif

//推送渠道

#if AppDebug
#define PushDistribute @"coach-test"
#else
#if AppIsAppStore
#define PushDistribute @"coach-appstore"
#else
#define PushDistribute @"coach-qingcheng"
#endif
#endif

#if AppDebug
#define ChatPrefix @"qctest_"
#else
#define ChatPrefix @"qc_"
#endif

//主体色调
#define kMainColor UIColorFromRGB(0x0db14b)

#define kDeleteColor UIColorFromRGB(0xEA6161)

//STFont
#define STFont(a)  [UIFont systemFontOfSize:a]

#define AllFont(a)  [UIFont systemFontOfSize:IPhone4_5_6_6P(a,a,a+1,a+2)]

//ST粗体
#define STBFont(a) [UIFont boldSystemFontOfSize:a]

#define AllBFont(a) [UIFont boldSystemFontOfSize:IPhone4_5_6_6P(a,a,a+1,a+2)]

//CoachId
#define CoachId (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"coachId"]

//CoachName
#define CoachName [[NSUserDefaults standardUserDefaults]valueForKey:@"coachName"]

//CoachIcon
#define CoachIcon [[NSUserDefaults standardUserDefaults]valueForKey:@"coachIcon"]

//UserId
#define UserId (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"userId"]

//UserPhone
#define UserPhone [[NSUserDefaults standardUserDefaults]valueForKey:@"userPhone"]

//UserSig
#define UserSig [[NSUserDefaults standardUserDefaults]valueForKey:@"userSig"]

//HeitiFont
#define HNFont(a) [UIFont fontWithName:@"HelveticaNeue-Light" size:a]

//1像素
#define OnePX 1/[UIScreen mainScreen].scale

// 屏幕的宽
#define MSW ([UIScreen mainScreen].bounds.size.width)

// 屏幕的高
#define MSH ([UIScreen mainScreen].bounds.size.height)

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//字体内容多少判断label的size
#define MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;


#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) : NO)


#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) : NO)

#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) : NO)

#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.2 ? YES : NO)

#define IPhoneAll(a,b) (CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) ?(a) :(CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) ? (b) : (CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) ?(b*375.0/320.0) : (CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) ?(b*414.0/320.0) : a))))

#define Width320(a) (long)(CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) ?(a) :(CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) ? (a) : (CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) ?(a*375.0/320.0) : (CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) ?(a*414.0/320.0) : (a*768.0/320.0)))))

#define Height320(a) (long)(CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) ?(a) :(CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) ? (a) : (CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) ?(a*375.0/320.0) : (CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) ?(a*414.0/320.0) : (a*768.0/320.0)))))

#define Width(a) (long)(CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) ?(a*320.0/375.0) :(CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) ? (a*320.0/375.0) : (CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) ?(a) : (CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) ?(a*414.0/375.0) : (a*768.0/375.0)))))

#define Height(a) (long)(CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) ?(a*320.0/375.0) :(CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) ? (a*320.0/375.0) : (CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) ?(a) : (CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) ?(a*414.0/375.0) : (a*768.0/375.0)))))

#define IPhone4_5_6_6P(a,b,c,d) (CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) ?(a) :(CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) ? (b) : (CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) ?(c) : (CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) ?(d) : a))))
