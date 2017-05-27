//
//  ChooseYardCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/6.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseYardCell : UITableViewCell

@property(nonatomic,assign)CourseType courseType;

@property(nonatomic,copy)NSString *yardName;

@property(nonatomic,assign)YardType yardType;

@property(nonatomic,assign)NSInteger yardCapacity;

@property(nonatomic,assign)BOOL select;

@end
