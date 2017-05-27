//
//  YFSignUpListBaseCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/30.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpListBaseCModel.h"

#import "YFTeamCModel.h"

@implementation YFSignUpListBaseCModel




#pragma mark Data
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"su_id":@"id",
             @"order_id":@"order.id",
             @"price":@"order.price",
             };
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"teams":YFTeamCModel.class,
             };
}



+ (NSMutableArray *)creatTestModelArray
{
    
    NSDictionary *dic = @{@"id":@(1),
                          @"gender":@(0),
                          @"username":@"陈驰远",
                          @"phone":@"1234111111",
                          @"avatar":@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png",
                          @"created_at":@"2016-03-04T09:20",
                          @"price":@(100),
                          @"teams":@[@{@"id":@(1),
                                       @"name":@"kent",
                                       },
                                     @{@"id":@(2),
                                       @"name":@"沉池园",
                                       },
                                     @{@"id":@(3),
                                       @"name":@"向鸿儒",
                                       },
                                     @{@"id":@(3),
                                       @"name":@"葫芦发",
                                       }],
                          };
    
    NSDictionary *dic1 = @{@"id":@(1),
                           @"gender":@(0),
                           @"username":@"陈驰远",
                           @"phone":@"1234111111",
                           @"avatar":@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png",
                           @"created_at":@"2016-03-04T09:20",
                           @"price":@(100),
                           @"teams":[NSNull null],
                           };
    
    NSDictionary *dic2 = @{@"id":@(1),
                           @"gender":@(0),
                           @"username":@"陈驰远",
                           @"phone":@"1234111111",
                           @"avatar":@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png",
                           @"created_at":@"2016-03-04T09:20",
                           @"price":@(100),
                           @"teams":@[@{@"id":@(1),
                                        @"name":@"kent",
                                        },
                                      @{@"id":@(2),
                                        @"name":@"沉池园",
                                        },
                                      @{@"id":@(3),
                                        @"name":@"向鸿儒",
                                        },
                                      @{@"id":@(1),
                                        @"name":@"kent",
                                        },
                                      @{@"id":@(2),
                                        @"name":@"沉池园",
                                        },
                                      @{@"id":@(3),
                                        @"name":@"向鸿儒",
                                        }]
                           };
    
    
    NSArray *aray = @[dic,dic1,dic2,dic,dic1,dic2,dic];
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    for (NSDictionary *daDic in aray)
    {
        YFSignUpListBaseCModel *model = [[self class] defaultWithYYModelDic:daDic];
        
        [dataArray addObject:model];
    }
    
    return dataArray;
    
}


- (CGFloat)nameWidth
{
    if (_nameWidth == 0)
    {
        CGSize size = YF_MULTILINE_TEXTSIZE(self.username, FontDetailTitleFY, CGSizeMake(150, 21), 0);
        
        return ceil(size.width);
    }
    return _nameWidth;
}





@end
