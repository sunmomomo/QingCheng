//
//  StaffCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/10.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Coach.h"

@interface StaffCell : UITableViewCell

@property(nonatomic,copy)NSString *position;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *phone;

@property(nonatomic,copy)NSURL *iconURL;

@property(nonatomic,assign)SexType sex;

@end
