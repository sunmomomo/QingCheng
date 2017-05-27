//
//  StudentCell.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/16.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Gym.h"

@interface StudentCell : UITableViewCell

@property(nonatomic,copy)NSString *phone;

@property(nonatomic,copy)NSString *noTitlePhone;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSURL *imgUrl;

@property(nonatomic,assign)SexType sex;

@end
