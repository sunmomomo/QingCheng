//
//  StaffUserInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/9.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "StaffUserInfo.h"

#define API @"/api/staffs/%ld/"

@implementation StaffUserInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.staff = [[Staff alloc]init];
        
    }
    return self;
}

-(void)requestResult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    if (!StaffId) {
        
        self.staff = nil;
        
        if (self.callBack) {
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }
        
        return;
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] param:nil success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] ==200) {
            
            NSDictionary *staffDict = responseDic[@"data"][@"staff"];
            
            self.staff.name = staffDict[@"username"];
            
            self.staff.phone = staffDict[@"phone"];
            
            self.staff.staffId = [staffDict[@"id"] integerValue];
            
            self.staff.iconUrl = [NSURL URLWithString:staffDict[@"avatar"]];
            
            self.staff.sex = [staffDict[@"gender"] integerValue]?SexTypeWoman:SexTypeMan;
            
            self.staff.userId = [staffDict[@"user_id"]integerValue];
            
            self.staff.districtCode = staffDict[@"gd_district"][@"code"];
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else
        {
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"]);
                
                self.callBack = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error);
            
            self.callBack = nil;
            
        }
        
    }];
    
}

-(void)updateStaffResult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:self.staff.name forKey:@"username"];
    
    [para setParameter:self.staff.phone forKey:@"phone"];
    
    [para setParameter:self.staff.iconUrl.absoluteString forKey:@"avatar"];
    
    [para setParameter:[NSNumber numberWithInteger:self.staff.sex] forKey:@"gender"];
    
    [para setParameter:self.staff.districtCode forKey:@"gd_district_id"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }else
        {
            
            self.callBack(NO,responseDic[@"msg"]);
            
            self.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBack(NO,error);
        
        self.callBack = nil;
        
    }];
    
}

@end
