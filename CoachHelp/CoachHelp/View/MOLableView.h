//
//  MOLableView.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/21.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MOLableView : UIView

@property(nonatomic,strong)NSArray *dataArray;

@property(nonatomic,assign)CGFloat labelGap;

@property(nonatomic,assign)CGFloat rowGap;

@property(nonatomic,assign)CGFloat labelHeight;

@property(nonatomic,strong)UIFont *font;

@property(nonatomic,strong)UIColor *textColor;

@property(nonatomic,copy)NSString *key1;

@property(nonatomic,copy)NSString *key2;

@property(nonatomic,assign)BOOL highLight;

@property(nonatomic,assign)NSInteger highNum;

@property(nonatomic,assign)BOOL haveArrow;

@end
