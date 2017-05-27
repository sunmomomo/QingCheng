//
//  ReportOrder.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/8.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CardKind.h"

#import "Student.h"

@interface ReportOrder : NSObject

@property(nonatomic,strong)CardKind *cardKind;

@property(nonatomic,strong)Student *user;

@property(nonatomic,assign)float price;

@property(nonatomic,assign)float realPrice;

@property(nonatomic,assign)NSInteger count;

@end
