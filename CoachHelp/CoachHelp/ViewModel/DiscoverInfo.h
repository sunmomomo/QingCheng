//
//  DiscoverInfo.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 2016/12/16.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscoverInfo : NSObject

@property(nonatomic,assign)BOOL haveNew;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestResult:(void(^)(BOOL success,NSString *error))result;

@end
