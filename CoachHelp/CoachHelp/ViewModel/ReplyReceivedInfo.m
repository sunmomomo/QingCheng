//
//  ReplyReceivedInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/4/12.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ReplyReceivedInfo.h"

#import "MOTool.h"

#define API @"/api/my/news/replies/"

@interface ReplyReceivedInfo ()

{
    
    NSInteger _totalPage;
    
    NSInteger _currentPage;
    
}

@end

@implementation ReplyReceivedInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.comments = [NSMutableArray array];
        
        _currentPage = 0;
        
        _totalPage = 1;
        
    }
    return self;
}

-(void)requestResult:(RequestCallBack)result
{
    
    self.callBack = result;
    
    if(_currentPage >= _totalPage){
        
        if (self.callBack) {
            
            self.callBack(YES,@"无更多数据");
            
            self.callBack = nil;
            
            return;
            
        }
        
    }
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setInteger:_currentPage+1 forKey:@"page"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:API param:nil success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            
            dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            
            dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
            
            _totalPage = [responseDic[@"data"][@"pages"] integerValue];
            
            _currentPage = [responseDic[@"data"][@"current_page"] integerValue];
            
            NSInteger count = [responseDic[@"data"][@"total_count"] integerValue];
            
            [responseDic[@"data"][@"comments"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                ReplyReceived *comment = [[ReplyReceived alloc]init];
                
                CGSize size = [obj[@"news"][@"sub_title"] boundingRectWithSize:CGSizeMake(MSW-Width(30), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(13)} context:nil].size;
                
                comment.cellHeight = MAX(Height(15), (long)size.height)+Height(65)+Height(10)+Height(90);
                
                comment.replyId = [obj[@"id"]integerValue];
                
                comment.username = obj[@"user"][@"username"];
                
                comment.replyForName = obj[@"reply"][@"user"][@"username"];
                
                if (!comment.username.length) {
                    
                    comment.username = @"";
                    
                }
                
                if (!comment.replyForName.length) {
                    
                    comment.replyForName = @"";
                    
                }
                
                comment.iconURL = [NSURL URLWithString:obj[@"user"][@"avatar"]];
                
                NSDate *date = [dateFormatter dateFromString:[obj[@"created_at"]stringByReplacingOccurrencesOfString:@"T" withString:@" "]];
                
                comment.time = [MOTool formatTimeStringWithDate:date];
                
                comment.reply = obj[@"text"];
                
                Press *press = [[Press alloc]init];
                
                press.title = obj[@"news"][@"title"];
                
                press.content = obj[@"news"][@"sub_title"];
                
                press.iconURL = [NSURL URLWithString:obj[@"news"][@"thumbnail"]];
                
                press.pressId = [obj[@"news"][@"id"] integerValue];
                
                press.URL = [NSURL URLWithString:obj[@"news"][@"url"]];
                
                comment.press = press;
                
                [self.comments addObject:comment];
                
            }];
            
            if (self.callBack) {
                
                self.callBack(YES, count>30?nil:@"无更多数据");
                
                self.callBack = nil;
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO, responseDic[@"msg"]);
                
                self.callBack = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO, error);
            
            self.callBack = nil;
            
        }
        
    }];
    
}

@end

@implementation Press
@end

@implementation ReplyReceived
@end
