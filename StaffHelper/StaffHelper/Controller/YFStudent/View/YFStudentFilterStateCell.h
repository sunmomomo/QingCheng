//
//  YFStudentFilterStateCell.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCell.h"

#define YFCellButtonBaColor RGB_YF(244, 244, 244)
#define YFCellBeginGap XFrom6YF(14.0)
#define YFCellButtonsGap XFrom6YF(14.0)


@interface YFStudentFilterStateCell : YFBaseCell

@property(nonatomic,strong)UILabel *meStateDesLabel;

@property(nonatomic,strong)UIButton *nRegisterButton;
@property(nonatomic,strong)UIButton *followIngButton;
@property(nonatomic,strong)UIButton *memberButton;


@end
