//
//  GymSuitCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GymSuitCell : UITableViewCell

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *subtitle;

@property(nonatomic,assign)BOOL isChoosed;

@property(nonatomic,copy)NSURL *imgUrl;

@property(nonatomic,assign)BOOL havePower;

@end
