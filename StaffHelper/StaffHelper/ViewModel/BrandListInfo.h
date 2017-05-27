//
//  BrandListInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Brand.h"

@interface BrandListInfo : NSObject

@property(nonatomic,strong)NSMutableArray *brands;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestResult:(void(^)(BOOL success,NSString *error))result;

-(void)changeBrand:(Brand *)brand result:(void(^)(BOOL success,NSString *error))result;

-(void)changeCreaterOfBrand:(Brand *)brand withCode:(NSString*)code result:(void(^)(BOOL success,NSString *error))result;

@end
