//
//  ChooseGymController.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/12/24.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Gym.h"

@interface ChooseGymController : MOViewController

@property(nonatomic,copy)void(^addSuccess)(Gym *gym);

@end
