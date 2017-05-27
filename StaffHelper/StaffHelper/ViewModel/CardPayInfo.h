//
//  CardPayInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/8.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Card.h"

@interface CardPayInfo : NSObject

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)payCard:(Card *)card withAccount:(NSInteger)account andPrice:(NSInteger)price andSellerId:(NSInteger)sellerId andShopId:(NSInteger)shopId andRemark:(NSString *)remark result:(void(^)(BOOL success,NSString *error))result;

@end
