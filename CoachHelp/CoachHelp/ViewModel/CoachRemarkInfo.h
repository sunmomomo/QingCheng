//
//  CoachRemarkInfo.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/24.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoachRemarkInfo : NSObject

@property(nonatomic,strong)NSArray *tags;

@property(nonatomic,copy)void(^request)(BOOL success);

@end
