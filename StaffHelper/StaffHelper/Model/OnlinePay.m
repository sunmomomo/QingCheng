//
//  OnlinePay.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/10/20.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "OnlinePay.h"

@implementation OnlinePay

-(id)copy
{
    
    OnlinePay *pay = [[OnlinePay alloc]init];
    
    pay.isUsed = self.isUsed;
    
    pay.cost = self.cost;
    
    pay.costStr = self.costStr;
    
    pay.name = self.name;
    
    pay.type = self.type;
    
    pay.astrict = self.astrict;
    
    pay.astrictNumber = self.astrictNumber;
    
    pay.astrictNewLogin = self.astrictNewLogin;
    
    pay.astrictFollowing = self.astrictFollowing;
    
    pay.astrictNormal = self.astrictNormal;
    
    return pay;

}

@end
