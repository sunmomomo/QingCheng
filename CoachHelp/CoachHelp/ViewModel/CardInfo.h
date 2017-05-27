//
//  CardInfo.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/19.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Card.h"

@interface CardInfo : NSObject

@property(nonatomic,strong)NSMutableArray *cards;

@property(nonatomic,copy)void(^request)(BOOL success);

@end
