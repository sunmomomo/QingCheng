//
//  YFTBSectionsSellerModel.h
//  StaffHelper
//
//  Created by FYWCQ on 2017/5/5.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFTBSectionsTitleModel.h"

#import "YFStudentFilterSellerCModel.h"

@interface YFTBSectionsSellerModel : YFTBSectionsTitleModel

@property(nonatomic, weak)UITableView *tableView;

@property(nonatomic, strong)YFStudentFilterSellerCModel *sellerCModel;

-(void)setStudentFilterRePeo;

@end
