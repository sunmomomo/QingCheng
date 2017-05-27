//
//  ChatMemberCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/27.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ChatMemberCellTypeAdd,
    ChatMemberCellTypeSub,
    ChatMemberCellTypeNormal,
} ChatMemberCellType;

@protocol ChatMemberCellDelegate;

@interface ChatMemberCell : UICollectionViewCell

@property(nonatomic,copy)NSURL *iconURL;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,assign)BOOL editing;

@property(nonatomic,assign)ChatMemberCellType type;

@property(nonatomic,weak)id<ChatMemberCellDelegate>delegate;

@end

@protocol ChatMemberCellDelegate <NSObject>

@optional

-(void)deleteUserWithCell:(ChatMemberCell*)cell;

@end
