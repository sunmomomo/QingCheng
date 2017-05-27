//
//  SellReport.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/18.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CardKind.h"

#import "Staff.h"

@interface SellReport : NSObject

@property(nonatomic,assign)float cost;

@property(nonatomic,assign)float account;

@property(nonatomic,copy)NSString *date;

@property(nonatomic,copy)NSString *remarks;

@property(nonatomic,copy)NSString *userName;

@property(nonatomic,strong)NSArray *users;

@property(nonatomic,strong)Seller *seller;

@property(nonatomic,strong)Card *card;

@property(nonatomic,copy)NSString *createTime;

@property(nonatomic,assign)PayWay payWay;

@property(nonatomic,assign)TradeType tradeType;

@end
