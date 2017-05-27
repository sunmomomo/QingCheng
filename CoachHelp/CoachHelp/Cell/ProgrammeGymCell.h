//
//  ProgrammeGymCell.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 2016/11/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgrammeGymCell : UITableViewCell

@property(nonatomic,assign)BOOL isVerified;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSURL *imgURL;

@property(nonatomic,assign)BOOL havePermission;

@end
