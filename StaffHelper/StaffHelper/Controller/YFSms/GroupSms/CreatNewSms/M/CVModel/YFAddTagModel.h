//
//  YFAddTagModel.h
//  YFTagView
//
//  Created by FYWCQ on 17/3/20.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

#import "YFBaseCModel.h"

// 因为有两个 不是 tagstring 所以 是17，最多显示 15个 tag
#define MaxShowCount 17

static NSString *yFAddTagCViewCell = @"YFAddTagCViewCell";

@interface YFAddTagModel : YFBaseCModel

@property(nonatomic, copy)void(^addTagBlock)(id);


@end
