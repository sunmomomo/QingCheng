//
//  MessageCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
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
