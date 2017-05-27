//
//  AgentCourseCell.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/9.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgentCell : UITableViewCell

@property(nonatomic,copy)NSURL *imgUrl;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *subtitle;

@property(nonatomic,assign)BOOL havePower;

@end
