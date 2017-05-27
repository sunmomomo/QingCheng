//
//  MOMenuView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/2/6.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MOMenuDelegate;

@interface MOMenuView : UIView

@property(nonatomic,assign)UIControlContentHorizontalAlignment textAlignment;

@property(nonatomic,assign,nonnull)id<MOMenuDelegate> delegate;

+(nullable instancetype)menuWithTitie:(nullable NSString*)title delegate:(nonnull id<MOMenuDelegate>)delegate destructiveButtonTitle:(nullable NSString *)destructiveTitle cancelButtonTitle:(nullable NSString *)cancelTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ...;

-(void)show;

@end

@protocol MOMenuDelegate <NSObject>

-(void)actionSheet:(nonnull MOMenuView*)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;

@end
