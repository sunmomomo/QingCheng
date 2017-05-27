//
//  MOPickerView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/2.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MOPickerViewDelegate;

@interface MOPickerView : UIPickerView

@property(nonatomic,strong)NSArray *titleArray;

@property(nonatomic,assign)NSInteger currentRow;

@property(nonatomic,strong)UIColor *labelColor;

@property(nonatomic,weak)id<MOPickerViewDelegate> pickerDelegate;

@end

@protocol MOPickerViewDelegate <NSObject>

@optional

-(void)pickerView:(MOPickerView*)pickerView didSelectRow:(NSInteger)row;

@end
