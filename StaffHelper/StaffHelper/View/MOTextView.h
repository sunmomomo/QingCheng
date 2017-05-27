//
//  MOTextView.h
//  健身教练助手
//
//  Created by 馍馍帝😈 on 15/8/14.
//  Copyright (c) 2015年 馍馍帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MOTextViewDelegate <NSObject>

@optional

-(void)textViewShouldReturn;

-(void)textViewDidChanged;

@end

@interface MOTextView : UITextView

@property(nonatomic,copy,setter=setPlaceholder:)NSString *placeholder;

@property(nonatomic,assign)BOOL needNext;

@property(nonatomic,strong,setter=setPlaceholderColor:)UIColor *placeholderColor;

@property(nonatomic,assign)id<MOTextViewDelegate> textDelegate;

@end
