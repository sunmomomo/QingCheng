//
//  WorkListCell.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/26.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkListCell : UITableViewCell

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *city;

@property(nonatomic,copy)NSURL *icon;

@property(nonatomic,assign)BOOL isHide;

@property(nonatomic,assign)BOOL isCertificated;

@property(nonatomic,copy)NSString *time;

@end
