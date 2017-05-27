//
//  ChatChooseMemberCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/28.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatChooseMemberCell : UITableViewCell

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *phone;

@property(nonatomic,copy)NSURL *iconURL;

@property(nonatomic,assign)BOOL choosed;

@end
