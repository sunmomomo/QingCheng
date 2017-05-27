//
//  NSObject+HttpCancelHandleYF.h
//  CoachHelp
//
//  Created by FYWCQ on 16/12/17.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YFHttpService.h"


@interface NSObject (HttpCancelHandleYF)

- (void)yf_addHttpService:(YFHttpService *)service;
- (void)yf_removeHttpService:(YFHttpService *)service;

@end
