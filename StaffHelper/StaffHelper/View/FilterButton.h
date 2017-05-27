//
//  FilterButton.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterButton : UIButton

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,assign)BOOL filtered;

@end
