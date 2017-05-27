//
//  CheckinHistoryCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckinHistoryCell : UITableViewCell

@property(nonatomic,assign)BOOL haveCanceled;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,assign)SexType sex;

@property(nonatomic,copy)NSURL *imageURL;

@property(nonatomic,copy)NSString *checkinTime;

@property(nonatomic,copy)NSString *checkoutTime;

@end
