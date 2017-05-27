//
//  CardDetailController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/14.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Card.h"

#import "YFBaseRefreshTBExtensionVC.h"

@interface CardDetailController : YFBaseRefreshTBExtensionVC

@property(nonatomic,strong)Card *card;

@property(nonatomic,copy)void(^editFinish)();

@property(nonatomic ,strong)Gym *gym;


@end
