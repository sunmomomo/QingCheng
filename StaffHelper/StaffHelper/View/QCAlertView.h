//
//  QCAlertView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QCAlertViewDelegate;

@interface QCAlertView : UIView

@property(nonatomic,assign,nonnull)id<QCAlertViewDelegate> delegate;

+(nullable instancetype)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id)delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString*)otherButtonTitles,...;

-(void)show;

@end

@protocol QCAlertViewDelegate <NSObject>

-(void)alertView:(nonnull QCAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
