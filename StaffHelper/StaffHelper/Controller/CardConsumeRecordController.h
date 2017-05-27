//
//  CardConsumeRecordController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/13.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Card.h"

@interface CardConsumeRecordController : MOViewController

@property(nonatomic,strong)Card *card;

@property(nonatomic,copy)NSString *totalRecharge;

@property(nonatomic,copy)NSString *totalCost;

@property(nonatomic,copy)NSString *remain;

@end
