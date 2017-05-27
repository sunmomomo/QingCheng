//
//  YFStudentFilterOriginCell.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCell.h"

@interface YFStudentFilterOriginCell : YFBaseCell

@property(nonatomic, strong)UILabel *nameLabel;

@property(nonatomic, strong)UIImageView *arrowImageView;

- (void)fitHeight:(CGFloat )height;

@end
