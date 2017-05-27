//
//  ChatCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/18.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ChatModel.h"

#import "MOChatImageView.h"

#import "MOChatLabelView.h"

@protocol ChatCellFunctionDelegate;

@interface ChatCell : UITableViewCell

{
@protected
    
    UIView *_backView;
    
    UIImageView *_layerView;
    
    UIImageView *_iconView;
    
    UILabel *_nameLabel;
    
}

@property(nonatomic,copy)NSURL *iconURL;

@property(nonatomic,assign)BOOL isMine;

@property(nonatomic,assign)BOOL isGroup;

@property(nonatomic,copy)NSString *userName;

@property(nonatomic,assign)NSInteger index;

@property(nonatomic,weak)id<ChatCellFunctionDelegate>delegate;

@end

@protocol ChatCellFunctionDelegate <NSObject>

-(void)functionWithCell:(ChatCell*)cell;

@end

@interface ChatImageCell : ChatCell

{
@protected
    
    UIImageView *_imageView;
    
}

@property(nonatomic,copy)NSURL *imageURL;

@property(nonatomic,assign)NSInteger imageHeight;

@end

@interface ChatVoiceCell : ChatCell

{
@protected
    
    UIImageView *_voiceImg;
    
    UIImageView *_voiceAnimationImg;
    
    UILabel *_timeLabel;
    
    UIView *_unreadView;
    
}

@property(nonatomic,assign)NSInteger voiceLength;

@property(nonatomic,copy)NSURL *voiceURL;

@property(nonatomic,assign)BOOL unread;

-(void)play;

-(void)stop;

@end

@interface ChatTextCell : ChatCell

{
@protected
    
    UILabel *_titleLabel;
        
}

@property(nonatomic,copy)NSString *content;

@end

@interface ChatTimeCell : UITableViewCell

{
    
    UILabel *_timeLabel;
    
}

@property(nonatomic,copy)NSString *time;

@end

@interface ChatSystemCell : UITableViewCell

{
    
    UIView *_contentBack;
    
    UILabel *_contentLabel;
    
}

@property(nonatomic,copy)NSString *content;

@end
