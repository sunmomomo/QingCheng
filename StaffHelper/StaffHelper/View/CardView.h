//
//  CardView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/16.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Card.h"

@protocol CardViewDelegate <NSObject>

-(void)cardRecharge;

-(void)cardCost;

-(void)cardRest;

-(void)cardRenew;

@end

@interface CardView : UIView

@property(nonatomic,strong)UIColor *cardBackColor;

@property(nonatomic,copy)NSString *cardName;

@property(nonatomic,copy)NSString *cardNumber;

@property(nonatomic,assign)NSInteger cardId;

@property(nonatomic,strong)NSArray *users;

@property(nonatomic,strong)NSArray *gyms;

@property(nonatomic,copy)NSString *startTime;

@property(nonatomic,copy)NSString *endTime;

@property(nonatomic,assign)NSInteger remain;

@property(nonatomic,assign)CardKindType type;

@property(nonatomic,assign)CardState state;

@property(nonatomic,assign)BOOL checkValid;

@property(nonatomic,assign)id<CardViewDelegate> delegate;

@end
