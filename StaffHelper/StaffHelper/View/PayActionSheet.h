//
//  PayActionSheet.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PayActionSheetDelegate <NSObject>

-(void)payActionSheetDismissWithPayWay:(PayWay)payWay;

@end

@interface PayActionSheet : UIView

@property(nonatomic,assign)PayWay payWay;

@property(nonatomic,assign)id<PayActionSheetDelegate> delegate;

+(instancetype)defaultActionSheet;

+(instancetype)noPermissionActionSheet;

-(void)showInView:(UIView*)view;

@end
