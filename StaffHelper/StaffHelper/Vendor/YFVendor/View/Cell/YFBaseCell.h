//
//  YFBaseCell.h
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/14.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

// 1
@interface YFBaseCell : UITableViewCell

@property(nonatomic,weak)UIViewController *currentVC;

@property(nonatomic,copy)void(^changeValueBlock)(id);

//跳转页面
@property(nonatomic,copy)void(^pushVC)(UIViewController*);

@end
