//
//  GymPayHistoryCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/17.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GymPayHistoryCell : UITableViewCell

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *valid;

@property(nonatomic,copy)NSString *price;

@property(nonatomic,copy)NSString *summary;

@property(nonatomic,assign)BOOL success;

@end
