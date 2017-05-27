//
//  WXAPIManager.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/2/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "WXAPIManager.h"

#import "payRequsestHandler.h"

@implementation WXAPIManager

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WXAPIManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXAPIManager alloc] init];
    });
    return instance;
}


#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    
    if([resp isKindOfClass:[PayResp class]]){
        
        if ([self.delegate respondsToSelector:@selector(payResult:)]) {
            
            [self.delegate payResult:resp.errCode];
            
        }
        
    }else if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        
        if ([self.delegate respondsToSelector:@selector(shareResult:andType:)]) {
            
            [self.delegate shareResult:resp.errCode andType:self.type];
            
        }
        
    }
    
}

-(void)payWithParameters:(NSDictionary *)parameter
{
    
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.openID              = [parameter objectForKey:@"appid"];
    req.partnerId           = [parameter objectForKey:@"partnerid"];
    req.prepayId            = [parameter objectForKey:@"prepayid"];
    req.nonceStr            = [parameter objectForKey:@"noncestr"];
    req.timeStamp           = [[parameter objectForKey:@"timestamp"] intValue];
    req.package             = [parameter objectForKey:@"package"];
    req.sign                = [parameter objectForKey:@"sign"];
    [WXApi sendReq:req];
    
}

-(void)shareWithParameters:(NSDictionary *)para andScene:(int)scene
{
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    
    req.scene = scene;
    
    WXMediaMessage *message = [[WXMediaMessage alloc]init];
    
    message.title = para[@"title"];
    
    message.description = para[@"content"];
    
    WXWebpageObject *webObj = [[WXWebpageObject alloc]init];
    
    webObj.webpageUrl = para[@"link"];
    
    message.mediaObject = webObj;
    
    if (para[@"imgURL"]) {
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:para[@"imgURL"]]]];
        
        CGSize size = CGSizeMake(120, image.size.height/image.size.width*120);
        
        UIGraphicsBeginImageContext (size);
        
        [image drawInRect : CGRectMake (0,0,size.width,size.height)];
        
        UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext ();
        
        UIGraphicsEndImageContext ();
        
        [message setThumbImage:newImage];
        
    }else if (para[@"imageName"]){
        
        UIImage *image = [UIImage imageNamed:para[@"imageName"]];
        
        CGSize size = CGSizeMake(120, image.size.height/image.size.width*120);
        
        UIGraphicsBeginImageContext (size);
        
        [image drawInRect : CGRectMake (0,0,size.width,size.height)];
        
        UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext ();
        
        UIGraphicsEndImageContext ();
        
        [message setThumbImage:newImage];
        
    }
    
    req.message = message;
    
    self.type = scene == 0?ShareTypeFreind:ShareTypeMoment;
    
    [WXApi sendReq:req];
    
}

@end
