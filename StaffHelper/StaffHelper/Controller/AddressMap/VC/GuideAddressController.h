//
//  GuideAddressController.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/11/14.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

@interface GuideAddressController : MOViewController

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,copy)void(^fillFinish)(Gym *gym);

@property(nonatomic, copy)NSString *lat;

@property(nonatomic, copy)NSString *lng;

@end
