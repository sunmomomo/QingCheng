//
//  YFAppConfig.h
//  OCTBLogical
//
//  Created by YFWCQ on 16/12/14.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFHeader.h"

#import "YFAppUIConfig.h"

#ifndef YFAppConfig_h
#define YFAppConfig_h





#import "NSObject+YFExtension.h"
#import "NSMutableDictionary+YFExtension.h"
#import "NSMutableArray+YFExtension.h"
#import "Parameters+YFExtension.h"

// 上拉 下拉 延迟调用设置，有延迟 是为了 在网络快，和测试时 看 下拉的刷新动画测试用的
#if DEBUG

#define  kYFRefreshDelaySecondsssss  0.0
//#define DebugLogYF( s, ... ) \
//fprintf(stderr, "%s\n", [[NSString stringWithFormat:@"<%@%@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
//[NSString stringWithUTF8String:__PRETTY_FUNCTION__], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__]] UTF8String])
#define DebugLogYF( s, ... )

#define DebugLogParamYF( s, ... ) \
fprintf(stderr, "%s\n", [[NSString stringWithFormat:@"<%@%@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
[NSString stringWithUTF8String:__PRETTY_FUNCTION__], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__]] UTF8String])

#else

#define kYFRefreshDelaySecondsssss  0.0
#define DebugLogYF( s, ... )
#define DebugLogParamYF( s, ... )

#endif

#define ListPageSizeYF @(20)

#define weakTypesYF  __weak typeof(self)weakS = self;

#define YFurlstring(a) [NSString stringWithFormat:@"%@%@",ROOT,a]


//-- MD_MULTILINE_TEXTSIZE  字体内容多少判断label的size
#define YF_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;


#define XFromWidthYF(widthYF,orighWidth,x) (long)(round((widthYF / (orighWidth) * (x))))

#define XFromCellHeightYF(cell,orighiHeight,x) (long)(round(cell.contentView.height / (orighiHeight) * (x)))



#define RGB_YF(r,g,b) [UIColor colorWithRed:(r)/255. green:(g)/255. blue:(b)/255. alpha:1.0]

#define RGBA_YF(r,g,b,a) [UIColor colorWithRed:(r)/255. green:(g)/255. blue:(b)/255. alpha:a]

#define IPhone4_5_6_6PYF(a,b,c,d) (CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) ?(a) :(CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) ? (b) : (CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) ?(c) : (CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) ?(d) : (a)))))

#define YFurlstring(a) [NSString stringWithFormat:@"%@%@",ROOT,a]


#define  YFMainBackColor [UIColor whiteColor]
#define  YFLineViewColor RGB_YF(221, 221, 221)
#define  YFGrayViewColor RGB_YF(244, 244, 244)

#define  YFSelectedButtonColor RGB_YF(24, 181, 83)


#define  YFCellTitleColor RGB_YF(51, 51, 51)
#define  YFCellSubTitleColor RGB_YF(139, 139, 139)

#define FontSizeFY(b) [UIFont systemFontOfSize:(b)]

#define FontScale320SizeFY(b) [UIFont systemFontOfSize:(Width320(b))]
#define FontScaleSizeFY(b) [UIFont systemFontOfSize:(Width(b))]


#define BoldFontSizeFY(b) [UIFont boldSystemFontOfSize:(b)]



#define FontBigTitleFY [UIFont systemFontOfSize:18.]

#define FontCellTitleFY [UIFont systemFontOfSize:16.]

#define FontCellSubTitleFY [UIFont systemFontOfSize:11.]

#define FontCellTitleValueFY [UIFont systemFontOfSize:13.]

#define FontCurrencyTitleFY [UIFont systemFontOfSize:14.]


#define StudentRightShowScale 0.84

#define YFIsNewRe @"0"
#define YFIsFollowing @"1"
#define YFIsMember @"2"

#define  allocInObjYF(object) [[object alloc] init];

#define  ImageWithNameYF(name) [UIImage imageNamed:name]


typedef NS_ENUM(NSInteger, YFRequestType) {
    YFRequestTypeNone,
    YFRequestTypeLoading,
    YFRequestTypeSuccess,
    YFRequestTypeFail
};

// 定义通用颜色
#define kBlackColorYF         [UIColor blackColor]
#define kDarkGrayColorYF      [UIColor darkGrayColor]
#define kLightGrayColorYF     [UIColor lightGrayColor]
#define kWhiteColorYF         [UIColor whiteColor]
#define kGrayColorYF          [UIColor grayColor]
#define kRedColorYF           [UIColor redColor]
#define kGreenColorYF         [UIColor greenColor]
#define kBlueColorYF          [UIColor blueColor]
#define kCyanColorYF          [UIColor cyanColor]
#define kYellowColorYF        [UIColor yellowColor]
#define kMagentaColorYF       [UIColor magentaColor]
#define kOrangeColorYF        [UIColor orangeColor]
#define kPurpleColorYF        [UIColor purpleColor]
#define kClearColorYF         [UIColor clearColor]

#define kRandomFlatColor    [UIColor randomFlatColor]

#endif /* YFAppConfig_h */
