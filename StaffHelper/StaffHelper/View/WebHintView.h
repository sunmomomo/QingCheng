//
//  WebHintView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/6/5.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WebHintViewDelegate <NSObject>

-(void)showDetailHint;

@end

@interface WebHintView : UIView

@property(nonatomic,copy)NSURL *hintURL;

@property(nonatomic,assign)id<WebHintViewDelegate> delegate;

@end
