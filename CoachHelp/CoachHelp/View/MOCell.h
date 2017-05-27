//
//  MOCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MOCell : UIButton

@property(nonatomic,copy)NSString *subtitle;

@property(nonatomic,assign)BOOL haveArrow;

@property(nonatomic,assign)BOOL noLine;

@property(nonatomic,assign)BOOL mustInput;

@property(nonatomic,copy)NSString *placeholder;

@property(nonatomic,strong)UIColor *subtitleColor;

@property(nonatomic,strong)UILabel *subtitleLabel;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,assign)BOOL noArrow;

@end
