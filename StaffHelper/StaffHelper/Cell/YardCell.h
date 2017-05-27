//
//  YardCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Yard.h"

@interface YardCell : UITableViewCell

@property(nonatomic,copy)NSString *yardName;

@property(nonatomic,assign)YardType yardType;

@property(nonatomic,assign)NSInteger yardCapacity;


@end
