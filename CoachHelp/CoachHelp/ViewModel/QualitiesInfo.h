//
//  QualitiesInfo.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/21.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Quality.h"

@interface QualitiesInfo : NSObject

@property(nonatomic,strong)NSMutableArray *qualities;

@property(nonatomic,assign)NSInteger pages;

@property(nonatomic,copy)void(^request)(BOOL success);

@property(nonatomic,assign)BOOL noHide;

-(void)updataData;

@end
