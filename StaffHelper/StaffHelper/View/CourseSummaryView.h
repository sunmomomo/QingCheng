//
//  CourseSummaryView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseSummaryView : UIView

@property(nonatomic,copy)NSString *htmlData;

-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
