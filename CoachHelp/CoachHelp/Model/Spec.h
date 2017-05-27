//
//  Spec.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CardKind.h"

typedef enum : NSUInteger {
    SpecTypeNormal,
    SpecTypeOther,
} SpecType;

@class CardKind;

@interface Spec : NSObject

@property(nonatomic,copy)NSString *price;

@property(nonatomic,copy)NSString *charge;

@property(nonatomic,assign)NSInteger validTime;

@property(nonatomic,copy)NSString *summary;

@property(nonatomic,assign)SpecType type;

@property(nonatomic,assign)BOOL choosed;

@property(nonatomic,assign)BOOL checkValid;

@property(nonatomic,assign)BOOL canCreate;

@property(nonatomic,assign)BOOL canRecharge;

@property(nonatomic,strong)CardKind *cardKind;

@property(nonatomic,assign)NSInteger specId;

@end
