//
//  BrandGymCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/13.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrandGymCell : UITableViewCell

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *phone;

@property(nonatomic,copy)NSString *position;

@property(nonatomic,copy)NSURL *iconURL;

@property(nonatomic,copy)NSString *superuserName;

@property(nonatomic,assign)BOOL pro;

@property(nonatomic, strong)UIButton *deleteButton;

@property(nonatomic, copy)void(^deleteBlock)(NSInteger);

@end
