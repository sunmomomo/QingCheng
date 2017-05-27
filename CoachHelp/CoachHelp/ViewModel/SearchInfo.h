//
//  SearchInfo.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/28.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Organization.h"

#import "Gym.h"

@interface SearchInfo : NSObject

@property(nonatomic,strong)NSMutableArray *organizationsArr;

@property(nonatomic,strong)NSMutableArray *hotOrganizationsArr;

@property(nonatomic,strong)NSMutableArray *gymArr;

@property(nonatomic,strong)NSMutableArray *hotGymArr;

@property(nonatomic,copy)NSString *searchStr;

@property(nonatomic,copy)void(^request)(BOOL success);

-(instancetype)initOgnInfoWithStr:(NSString *)str;

-(instancetype)initGymInfoWithStr:(NSString *)str;

@end
