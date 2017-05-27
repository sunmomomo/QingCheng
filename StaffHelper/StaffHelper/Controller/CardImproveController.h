//
//  CardImproveController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Card.h"

#import "Spec.h"

@interface CardImproveController : MOViewController

@property(nonatomic,strong)Card *card;

@property(nonatomic,strong)Spec *spec;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,assign)PayType type;

@end
