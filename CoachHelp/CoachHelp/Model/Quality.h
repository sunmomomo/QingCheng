//
//  Quality.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/22.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Organization.h"

typedef enum : NSUInteger {
    QualityTypeMeeting = 1,
    QualityTypeTrain = 2,
    QualityTypeMatch = 3,
} QualityType;

@interface Quality : NSObject

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *certificateName;

@property(nonatomic,strong)Organization *organization;

@property(nonatomic,assign)NSInteger qualityId;

@property(nonatomic,copy)NSString *issueTime;

@property(nonatomic,copy)NSString *startTime;

@property(nonatomic,copy)NSString *endTime;

@property(nonatomic,copy)NSString *grade;

@property(nonatomic,copy)NSURL *photo;

@property(nonatomic,assign)QualityType type;

@property(nonatomic,assign)BOOL isVerified;

@property(nonatomic,assign)BOOL isHidden;

@property(nonatomic,assign)BOOL willExpired;

@end
