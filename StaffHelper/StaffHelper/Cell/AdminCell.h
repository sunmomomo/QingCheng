//
//  AdminCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminCell : UITableViewCell

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSURL *iconURL;

@property(nonatomic,copy)NSString *phone;

@property(nonatomic,assign)SexType sex;

@end
