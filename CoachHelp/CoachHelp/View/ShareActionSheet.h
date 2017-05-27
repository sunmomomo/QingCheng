//
//  ShareActionSheet.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/26.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WXApi.h"

#import "WXAPIManager.h"

@protocol ShareActionSheetDelegate;

@interface ShareActionSheet : UIView

@property(nonatomic,copy)NSString *content;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *imgURL;

@property(nonatomic,copy)NSString *imageName;

@property(nonatomic,copy)NSString *desc;

@property(nonatomic,copy)NSString *url;

@property(nonatomic,assign)id<ShareActionSheetDelegate> delegate;

-(void)show;

@end

@protocol ShareActionSheetDelegate <WXApiManagerDelegate>

@end
