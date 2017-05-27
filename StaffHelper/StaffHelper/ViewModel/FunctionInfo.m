//
//  FunctionInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/10/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "FunctionInfo.h"

#define ScanAPI @"/api/scans/%@/"

@implementation FunctionInfo

-(void)scanWithString:(NSString *)str andURL:(NSString *)url result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:[[NSUserDefaults standardUserDefaults]valueForKey:@"sessionId"] forKey:@"session_id"];
    
    [para setParameter:url forKey:@"url"];
      
    NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)str, NULL, NULL,  kCFStringEncodingUTF8 ));
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:ScanAPI,encodedString] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"data"][@"successful"] boolValue]) {
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO,nil);
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error);
            
        }
        
    }];
    
}

-(void)scanWithString:(NSString *)str andModule:(NSString *)module result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:[[NSUserDefaults standardUserDefaults]valueForKey:@"sessionId"] forKey:@"session_id"];
    
    NSString *url = [NSString stringWithFormat:@"%@/app2web/?",ROOT];
    
    if(AppGym.gymId && AppGym.type){
        
        url = [NSString stringWithFormat:@"%@&id=%ld&model=%@",url,(long)AppGym.gymId,AppGym.type];
        
    }else if (AppGym.shopId && AppGym.brand.brandId){
        
        url = [NSString stringWithFormat:@"%@&shop_id=%ld&brand_id=%ld",url,(long)AppGym.shopId,(long)AppGym.brand.brandId];
        
    }else{
        
        url = [NSString stringWithFormat:@"%@&brand_id=%ld",url,(long)[BRANDID integerValue]];
        
    }
    
    url = [NSString stringWithFormat:@"%@&module=%@",url,module];
    
    [para setParameter:url forKey:@"url"];
    
    NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)str, NULL, NULL,  kCFStringEncodingUTF8 ));
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:ScanAPI,encodedString] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"data"][@"successful"] boolValue]) {
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO,nil);
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error);
            
        }
        
    }];
    
}

@end
