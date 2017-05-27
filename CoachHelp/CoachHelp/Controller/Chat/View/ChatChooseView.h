//
//  ChatChooseView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/30.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChatChooseViewDelegate <NSObject>

@optional

-(void)showChooseView;

-(void)chooseViewConfirm;

@end

@interface ChatChooseView : UIView

@property(nonatomic,assign)NSInteger chooseNumber;

@property(nonatomic,weak)id<ChatChooseViewDelegate>delegate;

@end
