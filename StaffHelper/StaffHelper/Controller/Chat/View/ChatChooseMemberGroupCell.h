//
//  ChatChooseMemberGroupCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/29.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatChooseMemberGroupCell : UITableViewCell

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *phone;

@property(nonatomic,copy)NSURL *iconURL;

@property(nonatomic,assign)BOOL choosed;

@property(nonatomic,copy)NSString *position;

@property(nonatomic,assign)BOOL noline;

@end
