//
//  Seller.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/10/18.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    SellerTypeNone,
    SellerTypeNormal,
} SellerType;

@interface Seller : NSObject

@property(nonatomic,copy)NSURL *iconURL;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,assign)NSInteger sellerId;

@property(nonatomic,copy)NSString *sellerStrId;

@property(nonatomic,copy)NSString *avatar;

@property(nonatomic,strong)NSArray *users;

@property(nonatomic,assign)NSInteger userCount;

@property(nonatomic,assign)SexType sexType;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,assign)SellerType type;

@end
