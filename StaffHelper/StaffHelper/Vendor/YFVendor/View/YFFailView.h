//
//  YFFailView.h
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/16.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFFailView : UIView

- (instancetype)initWithFrame:(CGRect)frame LoadBlock:(void(^)())loadBlock;

- (void)removeSelfFromView;
@end
