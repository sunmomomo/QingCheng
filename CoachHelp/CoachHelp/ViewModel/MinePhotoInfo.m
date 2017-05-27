//
//  MinePhotoInfo.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 2017/3/9.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "MinePhotoInfo.h"

#define API @"/api/coaches/photos/"

@implementation MinePhoto



@end

@implementation MinePhotoInfo

-(void)requestResult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API] param:nil success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSMutableArray *photos = [NSMutableArray array];
            
            [responseDic[@"data"][@"photos"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                MinePhoto *photo = [[MinePhoto alloc]init];
                
                photo.urlString = obj[@"photo"];
                
                photo.photoId = [obj[@"id"]integerValue];
                
                [photos addObject:photo];
                
            }];
            
            self.photos = photos;
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else{
            
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

-(void)addPhoto:(NSString *)photoURLString result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:photoURLString forKey:@"photo"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:API] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else{
            
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

-(void)deletePhotos:(NSArray *)photos result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    NSString *ids = [photos componentsJoinedByString:@","];
    
    [MOAFHelp AFDeleteHost:ROOT bindPath:[NSString stringWithFormat:API] deleteParam:@{@"ids":ids} success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else{
            
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

@end
