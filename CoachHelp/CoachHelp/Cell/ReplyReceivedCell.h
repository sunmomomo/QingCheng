//
//  ReplyReceivedCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/2.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReplyReceivedCellDelegate;

@interface ReplyReceivedCell : UITableViewCell

@property(nonatomic,copy)NSURL *iconURL;

@property(nonatomic,copy)NSURL *pressIconURL;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *replyForName;

@property(nonatomic,copy)NSString *replyContent;

@property(nonatomic,copy)NSString *pressTitle;

@property(nonatomic,copy)NSString *pressContent;

@property(nonatomic,assign)NSInteger pressId;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,weak)id<ReplyReceivedCellDelegate> delegate;

@end

@protocol ReplyReceivedCellDelegate <NSObject>

-(void)replyWithReplyCell:(ReplyReceivedCell*)cell;

@end
