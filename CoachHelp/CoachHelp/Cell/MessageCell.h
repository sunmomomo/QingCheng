//
//  MessageCell.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/18.
//  Copyright (c) 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell

@property(nonatomic,assign)BOOL haveRead;

@property(nonatomic,copy)NSURL *iconURL;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *descriptions;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *gymName;

@property(nonatomic,assign)BOOL haveArrow;

@end
