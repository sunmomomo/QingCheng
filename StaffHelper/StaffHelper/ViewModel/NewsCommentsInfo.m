//
//  NewsCommentsInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/4/12.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "NewsCommentsInfo.h"

#import "MOTool.h"

#define API @"/api/news/%ld/comment/"


@interface NewsCommentsInfo ()

{
    
    NSInteger _totalPage;
    
    NSInteger _currentPage;
    
}

@end

@implementation NewsCommentsInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.comments = [NSMutableArray array];
        
        _totalPage =1;
        
        _currentPage = 0;
        
    }
    return self;
}

-(void)requestWithPress:(Press *)press result:(RequestCallBack)result
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
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,(long)press.pressId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            
            dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            
            dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
            
            _totalPage = [responseDic[@"data"][@"pages"] integerValue];
            
            _currentPage = [responseDic[@"data"][@"current_page"] integerValue];
            
            NSInteger count = [responseDic[@"data"][@"total_count"] integerValue];
            
            self.totalCount = count;
            
            [responseDic[@"data"][@"comments"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NewsComment *comment = [[NewsComment alloc]init];
                
                NSDictionary *userDict = obj[@"user"];
                
                NSDictionary *replyDict = obj[@"reply"];
                
                NSDictionary *replyUserDict = obj[@"reply"][@"user"];
                
                comment.user = [[User alloc]init];
                
                comment.user.username = userDict[@"username"];
                
                comment.user.userId = [userDict[@"id"]integerValue];
                
                comment.user.iconURL = [NSURL URLWithString:userDict[@"avatar"]];
                
                NSDate *date = [dateFormatter dateFromString:[obj[@"created_at"]stringByReplacingOccurrencesOfString:@"T" withString:@" "]];
                
                comment.time = [MOTool formatTimeStringWithDate:date];
                
                if (!comment.user.username.length) {
                    
                    comment.user.username = @"";
                    
                    comment.user.iconURL = [NSURL URLWithString:userDict[@"avatar"]];
                    
                }
                
                if ([replyUserDict[@"id"] integerValue]) {
                    
                    comment.replyUser = [[User alloc]init];
                    
                    comment.replyUser.username = replyUserDict[@"username"];
                    
                    comment.replyUser.userId = [replyUserDict[@"id"]integerValue];
                    
                    if (!comment.replyUser.username.length) {
                        
                        comment.replyUser.username = @"";
                        
                    }
                    
                    comment.replyContent = replyDict[@"text"];
                    
                }
                
                comment.content = obj[@"text"];
                
                comment.commentId = [obj[@"id"]integerValue];
                
                NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                
                [paragraphStyle setLineSpacing:Height(4)];
                
                CGSize size = [comment.content boundingRectWithSize:CGSizeMake(MSW-Width(80), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(13),NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
                
                comment.cellHeight = ceil(size.height)+Height(38)+Height(18);
                
                if (comment.replyContent.length) {
                    
                    CGSize replySize= [comment.replyContent boundingRectWithSize:CGSizeMake(MSW-Width(90), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12),NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
                    
                    comment.cellHeight = ceil(size.height)+Height(38)+Height(8)+ceil(replySize.height)+Height(24)+Height(15);
                    
                }
                
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

-(void)replyPress:(Press *)press withText:(NSString *)text withComment:(NewsComment *)comment result:(RequestCallBack)result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:text forKey:@"text"];
    
    if (comment.commentId) {
        
        [para setInteger:comment.commentId forKey:@"reply_id"];
        
    }
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:API,(long)press.pressId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            if (self.callBack) {
                
                self.callBack(YES, nil);
                
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

@implementation NewsComment

@end
