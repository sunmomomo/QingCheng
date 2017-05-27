//
//  CoursePlanBatch.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/4.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePlanBatch.h"

@implementation CoursePlanBatch

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.course = [[Course alloc]init];
        
        self.coach = [[Coach alloc]init];
        
        self.yards = [NSMutableArray array];
        
        self.cardKinds = [NSMutableArray array];
        
        self.onlinePays = [NSMutableArray array];
        
        self.pictures = [NSMutableArray array];
        
        self.gym = [[Gym alloc]init];
        
    }
    return self;
}

-(id)copy
{
    
    CoursePlanBatch *batch = [[CoursePlanBatch alloc]init];
    
    batch.start = self.start;
    
    batch.end = self.end;
    
    batch.course = self.course;
    
    batch.coach = self.coach;
    
    batch.yards = [self.yards copy];
    
    NSMutableArray *cardKinds = [NSMutableArray array];
    
    for (CardKind *tempCardKind in self.cardKinds) {
        
        CardKind *copyCardKinds = [tempCardKind copy];
        
        [cardKinds addObject:copyCardKinds];
        
    }
    
    batch.cardKinds = cardKinds;
    
    NSMutableArray *onlinePays = [NSMutableArray array];
    
    for (OnlinePay *onlinePay in self.onlinePays) {
        
        OnlinePay *tempPay = [onlinePay copy];
        
        [onlinePays addObject:tempPay];
        
    }
    
    batch.onlinePays = onlinePays;
    
    batch.plans = [self.plans copy];
    
    batch.batchId = self.batchId;
    
    batch.date = self.date;
    
    batch.pictures = [self.pictures copy];
    
    batch.courseURL = self.courseURL;
    
    batch.isFree = self.isFree;
    
    batch.hasOrder = self.hasOrder;
    
    return batch;

}

@end
