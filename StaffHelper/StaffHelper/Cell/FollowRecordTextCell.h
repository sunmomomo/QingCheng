//
//  FollowRecordTextCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FollowRecordTextCell : UITableViewCell

@property(nonatomic,copy)NSString *content;

@property(nonatomic,copy)NSString *follower;

@property(nonatomic,copy)NSURL *iconUrl;

@property(nonatomic,copy)NSString *date;

@property(nonatomic,assign)CGSize contentSize;

@end
