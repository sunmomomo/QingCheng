//
//  CardFilterController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Card.h"

@interface CardFilterController : MOViewController

@property(nonatomic,strong)CardKind *cardKind;

@property(nonatomic,assign)CardState state;

@property(nonatomic,copy)void(^filtered)(CardKind *cardKind,CardState state);

@end
