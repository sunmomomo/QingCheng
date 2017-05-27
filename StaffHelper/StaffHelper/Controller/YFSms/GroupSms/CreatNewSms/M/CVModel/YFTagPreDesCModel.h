//
//  YFTagPreDesCModel.h
//  YFTagView
//
//  Created by FYWCQ on 17/3/20.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

#import "YFBaseCModel.h"

static NSString *yFTagPreDesCViewCell = @"YFTagPreDesCViewCell";

@interface YFTagPreDesCModel : YFBaseCModel

@property(nonatomic, copy)NSString *des;

@property(nonatomic, copy)void(^moreTagBlock)(id);

@end
