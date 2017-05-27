//
//  ChatChoosedCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/31.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChatChoosedCellDelegate;

@interface ChatChoosedCell : UITableViewCell

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *phone;

@property(nonatomic,copy)NSURL *iconURL;

@property(nonatomic,weak)id<ChatChoosedCellDelegate>delegate;

@end

@protocol ChatChoosedCellDelegate <NSObject>

@optional

-(void)deleteWithChatChoosedCell:(ChatChoosedCell*)cell;

@end
