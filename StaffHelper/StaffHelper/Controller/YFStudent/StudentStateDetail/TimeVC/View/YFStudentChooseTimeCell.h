//
//  YFStudentChooseTimeCell.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCell.h"
#import "QCKeyboardView.h"

@interface YFStudentChooseTimeCell : YFBaseCell

@property(nonatomic, strong)UIImageView *arrowImageView;

@property(nonatomic,strong)UITextField *startTimeTF;
@property(nonatomic, strong)UILabel *nameLabel;

@property(nonatomic,strong)QCKeyboardView *startKV;

@property(nonatomic,strong)UIDatePicker *startDP;


@end
