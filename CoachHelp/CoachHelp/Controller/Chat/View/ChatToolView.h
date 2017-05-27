//
//  ChatToolView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ChatHeader.h"

typedef void (^MyTextBlock) (NSString *myText);

//录音存储地址
typedef void (^AudioBlock) (TIMMessage *msg);

//录音取消的回调
typedef void (^CancelRecordBlock)(int flag);

//图片回调
typedef void (^PictureBlock)();

@interface ChatToolView : UIView

//设置MyTextBlock
-(void) setMyTextBlock:(MyTextBlock)block;

//设置录音地址回调
-(void) setAudioSendBlock:(AudioBlock) block;

-(void)setPictureBlock:(PictureBlock)block;

@end
