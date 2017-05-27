//
//  YFTBSectionsSignUpGroupModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/29.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFTBSectionsTitleModel.h"

#define MaxShowGroupMemCountYF 4


@interface YFTBSectionsSignUpGroupModel : YFTBSectionsTitleModel

@property(nonatomic, assign)BOOL isShowAll;

@property(nonatomic, strong)UIButton *addButton;

@property(nonatomic, strong)UIButton *deleteButton;


@end
