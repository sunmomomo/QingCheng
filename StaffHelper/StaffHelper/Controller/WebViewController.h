//
//  WebViewController.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/28.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

@interface WebViewController : MOViewController

@property(nonatomic,copy)NSURL *url;

@property(nonatomic,assign)BOOL shouldHint;

@property(nonatomic,assign)BOOL isBanner;

@property(nonatomic,copy)NSURL *hintURL;

@property(nonatomic,copy)NSURL *detailURL;

@property(nonatomic,assign)BOOL isCoach;

@property(nonatomic,copy)void(^completeAction)();

@property(nonatomic,copy)void(^paySuccess)();

@end
