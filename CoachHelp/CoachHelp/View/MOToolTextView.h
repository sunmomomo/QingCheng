//
//  MOToolTextView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/4/21.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MOToolTextViewDelegate <NSObject>

@optional

-(void)textViewShouldReturn;

-(void)textViewDidChanged;

@end

@interface MOToolTextView : UITextView

@property(nonatomic,copy,setter=setPlaceholder:)NSString *placeholder;

@property(nonatomic,assign)BOOL needNext;

@property(nonatomic,strong,setter=setPlaceholderColor:)UIColor *placeholderColor;

@property(nonatomic,assign)id<MOToolTextViewDelegate> textDelegate;

@end
