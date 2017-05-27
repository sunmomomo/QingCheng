//
//  UserDetailInfo.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/23.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "UserDetailInfo.h"

#define API @"/api/coaches/%ld/detail/"

#define OrderAPI @"/api/order-center/"

@interface UserDetailInfo ()<NSXMLParserDelegate>

@property(nonatomic,copy)NSString *elenmentName;

@end

@implementation UserDetailInfo

-(void)requestOrder:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    [MOAFHelp AFGetHost:ROOT bindPath:OrderAPI param:nil success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            self.orderNumber = [responseDic[@"data"][@"orders"] count];
            
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

-(void)requestResult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    if (!CoachId) {
        
        self.user = nil;
        
        if (self.callBack) {
            
            self.callBack(NO, nil);
            
            self.callBack = nil;
            
        }
        
        return;
        
    }
    
    NSString *api = [NSString stringWithFormat:API,CoachId];
    
    [MOAFHelp AFGetHost:ROOT bindPath:api param:nil success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            [[NSUserDefaults standardUserDefaults]setValue:responseDic[@"data"][@"coach"][@"username"] forKey:@"coachName"];
            
            if ([responseDic[@"data"][@"coach"][@"avatar"] length]) {
                
                [[NSUserDefaults standardUserDefaults]setValue:responseDic[@"data"][@"coach"][@"avatar"] forKey:@"coachIcon"];
                
            }
            
            [self createDataWithDict:responseDic[@"data"][@"coach"]];
            
        }else
        {
            
            self.user = nil;
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"]);
                
                self.callBack = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.user = nil;
        
        if (self.callBack) {
            
            self.callBack(NO,error);
            
            self.callBack = nil;
            
        }
        
    }];
    
}

-(void)createDataWithDict:(NSDictionary *)dict
{
    
    self.user = [[User alloc]init];
    
    self.user.intro = [NSMutableArray array];
    
    self.user.districtCode = dict[@"gd_district"][@"code"];
    
    self.user.wechat = dict[@"weixin"];
    
    self.user.phone = dict[@"phone"];
    
    self.user.coachId = [dict[@"id"]integerValue];
    
    if ([dict[@"description"] isKindOfClass:[NSArray class]]) {
        
         self.user.intro = dict[@"description"];
        
    }
    
    self.user.sex = [dict[@"gender"] integerValue];
    
    self.user.username = dict[@"username"];
    
    self.user.shortIntro = dict[@"short_description"];
    
    self.user.iconURL = [NSURL URLWithString:dict[@"avatar"]];
    
    self.user.tags = dict[@"tags"];
    
    self.user.totalCount = [dict[@"evaluate"][@"total_count"] integerValue];
    
    self.user.courseScore = [dict[@"evaluate"][@"course_score"] doubleValue];
    
    self.user.coachScore = [dict[@"evaluate"][@"coach_score"] doubleValue];
    
    NSString *string = [[@"<all>" stringByAppendingString:dict[@"description"]] stringByAppendingString:@"</all>"];
    
    [self parser:string];
    
}


-(void)parser:(NSString*)string
{
    //系统自带的
    NSXMLParser *par = [[NSXMLParser alloc] initWithData:[string dataUsingEncoding:NSUTF8StringEncoding]];
    [par setDelegate:self];//设置NSXMLParser对象的解析方法代理
    [par parse];
}

#pragma mark xmlparser
////step 1 :准备解析
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    
    
}
//step 2：准备解析节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    self.elenmentName = elementName;
    
    if ([self.elenmentName isEqualToString:@"img"]) {
        
        NSDictionary *dict = @{@"type":@"img",@"content":attributeDict[@"src"]};
        
         [self.user.intro addObject:dict];
        
    }
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([self.elenmentName isEqualToString:@"p"]) {
        
        NSDictionary *dic = @{@"type":@"word",@"content":string};
        
        [self.user.intro addObject:dic];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    
    if (self.callBack) {
        
        self.callBack(YES,nil);
        
        self.callBack = nil;
        
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    
    if (self.callBack) {
        
        self.callBack(YES,nil);
        
        self.callBack = nil;
        
    }
    
}



@end
