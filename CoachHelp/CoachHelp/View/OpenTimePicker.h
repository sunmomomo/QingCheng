//
//  OpenTimePicker.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/22.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenTimePicker : UIPickerView

@property(nonatomic,copy)NSString *hour;

@property(nonatomic,copy)NSString *minute;

@property(nonatomic,assign)NSInteger timeGap;

-(void)reload;

@end
