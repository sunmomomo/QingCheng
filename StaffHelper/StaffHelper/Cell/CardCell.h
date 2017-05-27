//
//  CardCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/16.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Card.h"

@interface CardCell : UITableViewCell

@property(nonatomic,strong)UIColor *cardBackColor;

@property(nonatomic,assign)CardState cardState;

@property(nonatomic,assign)NSInteger cardNumber;

@property(nonatomic,copy)NSString *cardName;

@property(nonatomic,strong)NSArray *users;

@property(nonatomic,assign)CGFloat remain;

@property(nonatomic,assign)CardKindType cardType;

@end
