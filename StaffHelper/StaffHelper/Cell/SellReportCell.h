//
//  SellReportCell.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/18.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardKind.h"

@interface SellReportCell : UITableViewCell

@property(nonatomic,copy)NSString *title;

@property(nonatomic,assign)BOOL sectionFirst;

@property(nonatomic,assign)BOOL sectionLast;

@property(nonatomic,copy)NSString *month;

@property(nonatomic,copy)NSString *day;

@property(nonatomic,copy)NSString *seller;

@property(nonatomic,copy)NSString *users;

@property(nonatomic,assign)float cost;

@property(nonatomic,assign)TradeType tradeType;

@property(nonatomic,assign)PayWay payWay;

@property(nonatomic,assign)float price;

@property(nonatomic,assign)CardKindType cardKindType;

-(void)setPrice:(float)price andCost:(float)cost;

@end
