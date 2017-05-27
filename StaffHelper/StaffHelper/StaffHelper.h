//
//  StaffHelper.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/1/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//


#ifdef __OBJC__
#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "UIView+Frame.h"
#import "UILabel+AutoSize.h"
#import "MOAFHelp.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "MJRefresh.h"
#import "Parameters.h"
#import "UIScrollView+EmptyDataSet.h"
#import "AppDelegate.h"
#import "QCLoadingHUD.h"
#import "NSString+Category.h"
#import "Enum.h"
#import "PermissionInfo.h"
#import "UIImage+Category.h"
#import <tingyunApp/NBSAppAgent.h>
#import "NSObject+FBKVOController.h"
#import "UIView+CustomAutoLayout.h"
#import "ColorHeaders.h"
#import "ConstHeader.h"
#import "AnimationHeaders.h"

typedef void(^RequestCallBack)(BOOL success,NSString *error);

#endif

#define SESSIONERROR 400001

//客服电话

#define QCPhone @"400-900-7986"

//版本号
#define VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define AppIsAppStore 1

#define AppDebug 0

#define LocalServer 0

#ifndef DEBUG
#define DEBUG 0
#endif

//APP name

#if AppIsAppStore
#define APPNAME @"StaffAppStore"
#else
#define APPNAME @"Staff"
#endif

#define UMKey @"57511f23e0f55ad421000189"

//微信key

#if AppIsAppStore
#define WXKEY @"wxb46b0430029d65d4"
#else
#define WXKEY @"wx2beb386a0021ed3f"
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
#define BPUSHKEY @"W80XYzO0DiGiZGsTYkx9l5qX"
#else
#if AppDebug
#define BPUSHKEY @"vBoNCsuBDZRPdTiWyM6Qenf8"
#else
#define BPUSHKEY @"agoNGF2mEfnBDDIAfDzkZd7d"
#endif
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
#define TIMPushID 4518
#else
#define TIMPushID 4526
#endif

#else

#if AppDebug
#define TIMPushID 4519
#else
#define TIMPushID 4527
#endif

#endif

#else

#if DEBUG

#if AppDebug
#define TIMPushID 4516
#else
#define TIMPushID 4524
#endif

#else

#if AppDebug
#define TIMPushID 4517
#else
#define TIMPushID 4525
#endif

#endif

#endif

//高德Key

#if AppIsAppStore
#define GDKEY @"87d982c1af4404f15d3afcc0208276a8"
#else
#define GDKEY @"feffb30e9d39312366ec8238efda32b9"
#endif

//推送渠道

#if AppDebug
#define PushDistribute @"staff-test"
#else
#if AppIsAppStore
#define PushDistribute @"staff-appstore"
#else
#define PushDistribute @"staff-qingcheng"
#endif
#endif

#if AppDebug
#define ChatPrefix @"qctest_"
#else
#define ChatPrefix @"qc_"
#endif

//主体色调
#define kMainColor UIColorFromRGB(0x0DB14B)

#define kDeleteColor UIColorFromRGB(0xEA6161)

//STFont
#define STFont(a)  [UIFont systemFontOfSize:a]

#define AllFont(a)  [UIFont systemFontOfSize:IPhone4_5_6_6P(a,a,a+1,a+2)]

//ST粗体

#define STBFont(a) [UIFont boldSystemFontOfSize:a]

#define AllBFont(a) [UIFont boldSystemFontOfSize:IPhone4_5_6_6P(a,a,a+1,a+2)]

//1像素

#define OnePX 1/[UIScreen mainScreen].scale

//StaffId
#define StaffId (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"staffId"]

//UserId
#define UserId (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"userId"]

//UserPhone
#define UserPhone [[NSUserDefaults standardUserDefaults]valueForKey:@"userPhone"]

//UserSig
#define UserSig [[NSUserDefaults standardUserDefaults]valueForKey:@"userSig"]

// 屏幕的宽
#define MSW ([UIScreen mainScreen].bounds.size.width)

// 屏幕的高
#define MSH ([UIScreen mainScreen].bounds.size.height)


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) : NO)

#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) : NO)

#define iPad ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(768, 1024), [[UIScreen mainScreen] bounds].size) : NO)

#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.2 ? YES : NO)

#define IPhoneAll(a,b) (CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) ?(a) :(CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) ? (b) : (CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) ?(b*375.0/320.0) : (CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) ?(b*414.0/320.0) : (a*768.0/320.0)))))

#define Width320(a) (long)(CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) ?(a) :(CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) ? (a) : (CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) ?(a*375.0/320.0) : (CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) ?(a*414.0/320.0) : (a*768.0/320.0)))))

#define Height320(a) (long)(CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) ?(a) :(CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) ? (a) : (CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) ?(a*375.0/320.0) : (CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) ?(a*414.0/320.0) : (a*768.0/320.0)))))

#define Width(a) (long)(CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) ?(a*320.0/375.0) :(CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) ? (a*320.0/375.0) : (CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) ?(a) : (CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) ?(a*414.0/375.0) : (a*768.0/375.0)))))

#define Height(a) (long)(CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) ?(a*320.0/375.0) :(CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) ? (a*320.0/375.0) : (CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) ?(a) : (CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) ?(a*414.0/375.0) : (a*768.0/375.0)))))

#define IPhone4_5_6_6P(a,b,c,d) (CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) ?(a) :(CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) ? (b) : (CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) ?(c) : (CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) ?(d) : a))))

