//
//  RenewHintView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/6/6.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RenewHintViewDelegate <NSObject>

-(void)renewConfirm;

@end

@interface RenewHintView : UIView

@property(nonatomic,assign)id<RenewHintViewDelegate> delegate;

@property(nonatomic,copy)NSString *systemEnd;

@end
