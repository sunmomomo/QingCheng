//
//  MONumberPickerView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MONumberPickerView : UIPickerView

@property(nonatomic,assign)NSInteger minNumber;

@property(nonatomic,assign)NSInteger maxNumber;

@property(nonatomic,assign)NSInteger currentNumber;

@property(nonatomic,strong)UIColor *labelColor;

@end
