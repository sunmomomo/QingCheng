//
//  WorksInfo.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/21.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Work.h"

@interface WorksInfo : NSObject

@property(nonatomic,strong)NSMutableArray *works;

@property(nonatomic,assign)NSInteger pages;

@property(nonatomic,copy)void(^request)(BOOL success);

@property(nonatomic,assign)BOOL noHide;

-(void)updataData;

@end
