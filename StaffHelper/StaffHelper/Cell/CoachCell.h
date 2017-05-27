//
//  CoachCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Coach.h"

@interface CoachCell : UITableViewCell

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *phone;

@property(nonatomic,copy)NSURL *imgUrl;

@property(nonatomic,assign)SexType sex;

@property(nonatomic,assign)BOOL select;

@end
