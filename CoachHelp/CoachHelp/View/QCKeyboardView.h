//
//  QCKeyboardView.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/15.
//  Copyright (c) 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QCKeyboardViewDelegate;

@interface QCKeyboardView : UIView

@property(nonatomic,assign,setter=setHaveCancel:)BOOL haveCancel;

@property(nonatomic,strong,setter=setKeyboard:)UIView *keyboard;

@property(nonatomic,assign)id<QCKeyboardViewDelegate> delegate;

+(QCKeyboardView*)defaultKeboardView;

@end

@protocol QCKeyboardViewDelegate <NSObject>


@optional

-(void)keyboardConfirm:(QCKeyboardView*)keyboadeView;

-(void)keyboardCancel:(QCKeyboardView*)keyboadeView;

@end
