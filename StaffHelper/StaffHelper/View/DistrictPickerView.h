//
//  DistrictPickerView.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/1/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DistrictInfo.h"

@interface DistrictPickerView : UIView

@property(nonatomic,strong,readonly)NSString *district;

@property(nonatomic,copy)NSString *districtCode;

+(instancetype)defaultPickerView;

@end
