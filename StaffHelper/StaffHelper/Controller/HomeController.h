//
//  HomeController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/15.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "HomeInfo.h"

#import "BrandListInfo.h"

@interface HomeController : MOViewController

@property(nonatomic,strong)HomeInfo *homeInfo;

@property(nonatomic,strong)BrandListInfo *brandInfo;

+(HomeController*)sharedController;

@end
