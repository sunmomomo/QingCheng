//
//  HomeBrandCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeBrandCell : UITableViewCell

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *subtitle;

@property(nonatomic,copy)NSURL *imgURL;

@property(nonatomic,assign)BOOL choosed;

@end
