//
//  CardKindSuitGymController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

@interface CardKindSuitGymController : MOViewController

@property(nonatomic,copy)void(^chooseFinish)(NSMutableArray *gyms);

@property(nonatomic,strong)NSMutableArray *gyms;

@property(nonatomic,assign)BOOL isAdd;

@end
