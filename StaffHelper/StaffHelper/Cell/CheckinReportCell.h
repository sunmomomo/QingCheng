//
//  CheckinReportCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckinReportCell : UITableViewCell

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *subtitle;

@property(nonatomic,assign)BOOL sectionFirst;

@property(nonatomic,assign)BOOL sectionLast;

@property(nonatomic,copy)NSString *month;

@property(nonatomic,copy)NSString *day;

@property(nonatomic,copy)NSURL *imgURL;

@property(nonatomic,copy)NSString *cardText;

@property(nonatomic,assign)CheckinType checkinType;

@property(nonatomic,copy)NSString *checkoutTime;

@end
