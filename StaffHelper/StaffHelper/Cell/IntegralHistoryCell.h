//
//  IntegralHistoryCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntegralHistoryCell : UITableViewCell

@property(nonatomic,assign)float integral;

@property(nonatomic,assign)float currentIntegral;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *place;

@property(nonatomic,copy)NSString *award;

@property(nonatomic,copy)NSString *summary;

@end
