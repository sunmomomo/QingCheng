//
//  YFSmsRecipentCModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

#import "YFSmsRecipentSubCModel.h"

@class YFTBSmsDetailSectionModel;
@interface YFSmsRecipentCModel : Student

@property(nonatomic, copy)NSString *allNameTitle;

@property(nonatomic, copy)NSString *firstNameTitle;



@property(nonatomic, copy)NSMutableAttributedString *atriFirstNameString;

@property(nonatomic, assign)UIEdgeInsets showEdgeInsets;


@property(nonatomic, weak)YFTBSmsDetailSectionModel *weakSectionModel;

- (void)getInforFrom:(YFSmsRecipentSubCModel *)model;


@end
