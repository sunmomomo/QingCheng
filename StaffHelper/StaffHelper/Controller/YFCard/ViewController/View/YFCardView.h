//
//  YFCardView.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardView.h"

@interface YFCardView : UIView

@property(nonatomic,strong)UIColor *cardBackColor;

@property(nonatomic,copy)NSString *cardName;

@property(nonatomic,copy)NSString *cardNumber;

@property(nonatomic,assign)NSInteger cardId;

@property(nonatomic,strong)NSArray *users;

@property(nonatomic,strong)NSArray *gyms;

@property(nonatomic,copy)NSString *startTime;

@property(nonatomic,copy)NSString *endTime;

@property(nonatomic,assign)CGFloat remain;

@property(nonatomic,assign)CardKindType type;

@property(nonatomic,assign)CardState state;

// 过期天数
@property(nonatomic, assign)NSInteger trial_days;

@property(nonatomic,assign)BOOL checkValid;

@property(nonatomic,assign)id<CardViewDelegate> delegate;

@end
