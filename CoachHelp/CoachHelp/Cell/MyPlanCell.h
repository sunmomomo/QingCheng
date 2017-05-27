//
//  MyPlanCell.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/16.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Plan.h"

@interface MyPlanCell : UITableViewCell

@property(nonatomic,copy)NSString *title;

@property(nonatomic,strong)NSArray *tags;

@property(nonatomic,copy)NSString *gymName;

@property(nonatomic,assign)PlanType type;

@end
