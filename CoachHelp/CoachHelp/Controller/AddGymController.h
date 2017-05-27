//
//  AddGymController.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/26.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Gym.h"

@interface AddGymController : MOViewController

@property(nonatomic,copy)void(^addSuccess)(Gym *gym);

@end
