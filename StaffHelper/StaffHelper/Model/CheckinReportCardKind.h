//
//  CheckinReportCardKind.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckinReportCardKind : NSObject

@property(nonatomic,assign)NSInteger checkinCount;

@property(nonatomic,assign)float receive;

@property(nonatomic,assign)float cost;

@property(nonatomic,assign)CardKindType cardKindType;

@end
