//
//  YFTBStudentTBDatasource.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFTBStudentTBDatasource.h"

@interface YFTBStudentTBDatasource ()

@property(nonatomic, copy)DataoArrayBLock allkeyArray;


@end

@implementation YFTBStudentTBDatasource
{
    NSMutableArray *_allKeyAllay;
}

+(instancetype)tableDelegeteWithArray:(DataArrayBLock)array allKeyArray:(DataoArrayBLock)allKeyArray currentVC:(YFBaseVC *)currentVC
{
    YFTBStudentTBDatasource *model = [YFTBStudentTBDatasource tableDelegeteWithArray:array currentVC:currentVC];
    model.allkeyArray = allKeyArray;
    return model;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (self.allkeyArray) {
        NSArray *array = self.allkeyArray();
        return array;
    }
    return @[];
}
@end
