//
//  ChatListTopCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/15.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ChatListModel.h"

@interface ChatListTopCell : UITableViewCell

@property(nonatomic,assign)ChatListModelType type;

@property(nonatomic,copy)NSString *content;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *shopName;

@property(nonatomic,assign)BOOL unRead;

@property(nonatomic,assign)BOOL topLine;

@property(nonatomic,assign)BOOL botLine;

@end
