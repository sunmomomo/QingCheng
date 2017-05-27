//
//  YFTagModel.h
//  YFTagView
//
//  Created by FYWCQ on 17/3/18.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFTagModel : YFBaseCModel

@property(nonatomic, copy)NSString *tagString;

@property(nonatomic, copy)void(^deleteBlock)(id);


@end

