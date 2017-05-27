//
//  YFAddOriginVC.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseVC.h"
#import "YFTextView.h"

@interface YFAddOriginVC : YFBaseVC

@property(nonatomic, copy)void(^selelctBlock)(NSString *);

@property(nonatomic, strong)YFTextView *textView;

@property(nonatomic, copy)NSString *placeHolderText;

@property(nonatomic, copy)NSString *valueText;


@end
