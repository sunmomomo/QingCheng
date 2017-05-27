//
//  YFStudentChooseTimeVC.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"
#import "QCKeyboardView.h"
#import "YFChooseTimeModel.h"

@interface YFStudentChooseTimeVC : YFBaseRefreshTBExtensionVC<QCKeyboardViewDelegate>


@property(nonatomic,copy)NSString *start;
@property(nonatomic,copy)NSString *end;

@property(nonatomic, copy)void(^selectBlock)();


@property(nonatomic, strong)YFChooseTimeModel *startTimeModel;
@property(nonatomic, strong)YFChooseTimeModel *endTimeModel;

@end
