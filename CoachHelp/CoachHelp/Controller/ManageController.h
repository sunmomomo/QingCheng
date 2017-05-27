//
//  ManageController.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/11/10.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

@interface ManageController : MOViewController

+ (ManageController*)sharedSliderController;

-(void)pushWithBrand:(Brand*)brand;

-(void)addGym;

@end
