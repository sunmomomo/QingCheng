//
//  AddOrganizationController.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/26.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Organization.h"

@interface AddOrganizationController : MOViewController

@property(nonatomic,copy)void(^addSuccess)(Organization *ogn);

@end
