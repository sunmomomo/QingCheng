//
//  QualityDetailController.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/23.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Quality.h"

@interface QualityDetailController : MOViewController

@property(nonatomic,strong)Quality *quality;

@property(nonatomic,copy)void(^edit)();

@end
