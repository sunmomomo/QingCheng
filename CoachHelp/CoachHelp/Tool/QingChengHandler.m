//
//  QingChengHandle.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/11/7.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "QingChengHandler.h"

#import "WebViewController.h"

#import "ReplyReceivedController.h"

#import "NewsCommentsController.h"

@implementation QingChengHandler

+(MOViewController *)handlerOpenURL:(NSURL *)url
{
    
    MOViewController *vc = nil;
    
    if (!CoachId) {
        
        return nil;
        
    }
    
    NSString *path;
    
    if (url.path.length) {
        
        path = [url.path substringFromIndex:1];
        
    }
    
    if ([url.host isEqualToString:@"openurl"]) {
        
        vc = [[WebViewController alloc]init];
        
        ((WebViewController*)vc).url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",path]];
        
    }
    
    if ([url.host isEqualToString:@"news"]) {
        
        if ([url.relativePath isEqualToString:@"/comments"]) {
            
            NSInteger pressId = [[[url.query componentsSeparatedByString:@"="] lastObject]integerValue];
            
            Press *press = [[Press alloc]init];
            
            press.pressId = pressId;
            
            vc = [[NewsCommentsController alloc]init];
            
            ((NewsCommentsController*)vc).press = press;
            
        }else if([url.relativePath isEqualToString:@"/replies"]){
            
            vc = [[ReplyReceivedController alloc]init];
            
        }
        
    }
    
    return vc;
    
}

@end
