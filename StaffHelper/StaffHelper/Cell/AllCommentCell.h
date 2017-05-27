//
//  AllCommentCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/4/11.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllCommentCell : UITableViewCell

@property(nonatomic,copy)NSString *reply;

@property(nonatomic,copy)NSString *replyForReply;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *userForReply;

@property(nonatomic,copy)NSURL *iconURL;

@property(nonatomic,copy)NSString *time;

@end
