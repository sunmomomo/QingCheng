//
//  InsertWordController.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/25.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

@interface InsertWordController : MOViewController

@property(nonatomic,copy)NSString *text;

@property(nonatomic,assign)BOOL isEdit;

@property(nonatomic,copy)void(^inputFinish)(NSString *text);

@end
