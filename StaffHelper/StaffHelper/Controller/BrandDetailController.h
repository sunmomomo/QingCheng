//
//  BrandDetailController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/13.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

@interface BrandDetailController : MOViewController

@property(nonatomic,strong)Brand *brand;

/**
 * 删除 场馆后的判读
 */
@property(nonatomic ,assign)NSInteger brandCount;

@end
