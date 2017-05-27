//
//  YFTBStudentTBDatasource.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFTBSectionsDataSource.h"

@interface YFTBStudentTBDatasource : YFTBSectionsDataSource

+(instancetype)tableDelegeteWithArray:(DataArrayBLock)array allKeyArray:(DataoArrayBLock)allKeyArray currentVC:(YFBaseVC *)currentVC;


@end
