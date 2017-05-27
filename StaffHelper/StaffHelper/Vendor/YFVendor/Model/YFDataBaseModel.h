//
//  YFDataBaseModel.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YFHttpService+Extension.h"


@interface YFDataBaseModel : NSObject

+(instancetype)dataModel;

-(void)showAlertMessage:(NSString *)message;
-(void)getResponseDatashowLoadingOn:(UIView *)superView successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

- (void)getResponseDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

-(Parameters *)paraWithGym:(Gym *)gym;

-(Parameters *)parameteYF;

@end
