//
//  GymBrandInfo.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 2017/3/8.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GymBrandInfo : NSObject

@property(nonatomic,strong)NSArray *brands;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestResult:(void(^)(BOOL success,NSString *error))result;

@end
