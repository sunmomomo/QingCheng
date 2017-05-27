//
//  ChangeGymController.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/1/5.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Gym.h"

@interface ChangeGymController : MOViewController

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)Permission *permission;

@property(nonatomic,copy)void(^changed)(Gym *gym);

@end
