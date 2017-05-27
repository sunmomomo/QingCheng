//
//  GuideAddCardController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/2.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "CardKind.h"

@interface GuideAddCardController : MOViewController

@property(nonatomic,copy)void(^addSuccess)(CardKind *cardKind);

@end
