//
//  MOActionSheet.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/12/9.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MOActionSheetDelegate;

@interface MOActionSheet : UIView

@property(nonatomic,assign,nonnull)id<MOActionSheetDelegate> delegate;

+(nullable instancetype)actionSheetWithTitie:(nullable NSString*)title delegate:(nonnull id<MOActionSheetDelegate>)delegate destructiveButtonTitle:(nullable NSString *)destructiveTitle cancelButtonTitle:(nullable NSString *)cancelTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ...;

-(void)show;

@end

@protocol MOActionSheetDelegate <NSObject>

-(void)actionSheet:(nonnull MOActionSheet*)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;

@end
