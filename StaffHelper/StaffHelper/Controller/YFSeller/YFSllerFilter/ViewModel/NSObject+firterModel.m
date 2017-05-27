//
//  NSObject+firterModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/4/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "NSObject+firterModel.h"

static const void *kFiterOtherModelCaYFKeyYF = @"kFiterOtherModelCaYFKeyYF";

static const void *kFitershowRightBlockCaYFKeyYF = @"kFitershowRightBlockCaYFKeyYF";


@implementation NSObject (firterModel)



- (YFFilterOtherModel *)fiterOtherModelCaYF
{
    YFFilterOtherModel *model = objc_getAssociatedObject(self, &kFiterOtherModelCaYFKeyYF);

    if (!model)
    {
        model = [[YFFilterOtherModel alloc] init];
        objc_setAssociatedObject(self, &kFiterOtherModelCaYFKeyYF, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    }
    return model;
}

- (void)setFiterOtherModelCaYF:(YFFilterOtherModel *)fiterOtherModelCaYF
{
    if (fiterOtherModelCaYF) {
        objc_setAssociatedObject(self, &kFiterOtherModelCaYFKeyYF, fiterOtherModelCaYF, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void (^)(id))showRightBlockCaYF
{
    id block  = objc_getAssociatedObject(self, &kFitershowRightBlockCaYFKeyYF);

    if (!block)
    {
        block = ^(id model){
            
        };
        objc_setAssociatedObject(self, &kFitershowRightBlockCaYFKeyYF, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return  block;
}

- (void)setShowRightBlockCaYF:(void (^)(id))showRightBlockCaYF
{
    if (showRightBlockCaYF) {
        objc_setAssociatedObject(self, &kFitershowRightBlockCaYFKeyYF, showRightBlockCaYF, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}
@end
