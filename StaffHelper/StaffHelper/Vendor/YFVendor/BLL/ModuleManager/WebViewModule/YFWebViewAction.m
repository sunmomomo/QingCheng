//
//  YFWebViewAction.m
//  StaffHelper
//
//  Created by FYWCQ on 17/4/9.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFWebViewAction.h"

#import "YFQrCodePopView.h"

#import "NSString+YFCategory.h"

#import "GymQRCodeAlert.h"

#import "YFCompetionHeader.h"

@implementation YFWebViewAction


- (YFReturnValue)yf_qr_code:(NSDictionary *)param
{
    DebugLogParamYF(@"-----:%@",param);
    
    NSString *url = [[param[@"url"] guardStringYF] URLDecodedYF];
    
    NSString *title = [[param[@"title"] guardStringYF] URLDecodedYF];
    NSString *content = [[param[@"content"] guardStringYF] URLDecodedYF];
    

    
    if (url.length == 0)
    {
        return YF_NO;
    }
    
    GymQRCodeAlert *codeAlert = [GymQRCodeAlert defaultAlert];
    
    codeAlert.urlString = url;
    
    codeAlert.topTitleName = title;
    
    codeAlert.gymName = content;
    
    [codeAlert show];
    
    return YF_YES;
}

@end
