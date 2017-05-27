
//
//  YFAppUIConfig.h
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/18.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#define ScreenWYF ([UIScreen mainScreen].bounds.size.width)
#define ScreenHYF ([UIScreen mainScreen].bounds.size.height)


//-- MD_MULTILINE_TEXTSIZE  字体内容多少判断label的size
#define YF_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;

#define XFrom6YF(x) (long)([[UIScreen mainScreen] bounds].size.width / 375.0 * (x))

#define YFrom6YF(y) (long)([[UIScreen mainScreen] bounds].size.height / 667.0 * (y))

#define XFrom5YF(x) (long)([[UIScreen mainScreen] bounds].size.width / 320.0 * (x))

#define YFrom5YF(y) (long)([[UIScreen mainScreen] bounds].size.height / 568.0 * (y))

#define XFrom5To6YF(x) (long)(375.0 / 320.0 * (x))



#define RGB_YF(r,g,b) [UIColor colorWithRed:(r)/255. green:(g)/255. blue:(b)/255. alpha:1.0]

#define RGBA_YF(r,g,b,a) [UIColor colorWithRed:(r)/255. green:(g)/255. blue:(b)/255. alpha:a]

#define IPhone4_5_6_6PYF(a,b,c,d) (CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) ?(a) :(CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) ? (b) : (CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) ?(c) : (CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) ?(d) : (a)))))


#define  YFMainBackColor [UIColor whiteColor]
#define  YFLineViewColor RGB_YF(221, 221, 221)
#define  YFGrayViewColor RGB_YF(244, 244, 244)

#define  YFSelectedButtonColor RGB_YF(24, 181, 83)


#define  YFCellTitleColor RGB_YF(51, 51, 51)
#define  YFCellSubTitleColor RGB_YF(139, 139, 139)

#define  YFCellSubGrayTitleColor RGB_YF(136, 136, 136)

#define  YFCellSubHintGrayTitleColor RGB_YF(187, 187, 187)

#define FontSizeFY(b) [UIFont systemFontOfSize:(b)]

#define BoldFontSizeFY(b) [UIFont boldSystemFontOfSize:(b)]



#define FontBigTitleFY [UIFont systemFontOfSize:18.]

#define FontCellTitleFY [UIFont systemFontOfSize:16.]

#define FontCellSubTitleFY [UIFont systemFontOfSize:11.]

#define FontCellTitleValueFY [UIFont systemFontOfSize:13.]

#define FontCurrencyTitleFY [UIFont systemFontOfSize:14.]

#define FontDetailTitleFY [UIFont systemFontOfSize:15.]

#define StudentRightShowScale 0.84


#define YFFirstChartDeColor [UIColor colorWithRed:110/255.0 green:184/255.0 blue:241.0/255.0 alpha:1.0]
#define YFSecondChartDeColor [UIColor colorWithRed:249/255.0 green:148/255.0 blue:78.0/255.0 alpha:1.0]
#define YFThreeChartDeColor RGBCOLOR(13, 177, 75)

#define YFRectMake(a, b, c, d) CGRectMake(Width320(a), Width320(b), Width320(c), Width320(d))


#define YFRectSixMake(a, b, c, d) CGRectMake(Width(a), Width(b), Width(c), Width(d))


