//
//  NewsCommentCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/3.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCommentCell : UITableViewCell

@property(nonatomic,copy)NSURL *iconURL;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *content;

@property(nonatomic,copy)NSString *replyName;

@property(nonatomic,copy)NSString *replyContent;

@end
