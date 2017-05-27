//
//  YFStudnetChooseStatusVC.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/5/5.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFStudnetChooseStatusVC.h"

@interface YFStudnetChooseStatusVC ()

@end

@implementation YFStudnetChooseStatusVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.canGetMore = NO;
    [self.navi removeFromSuperview];
    
    YFChooseGenderCModel *model = [self modelWithName:@"全部" gender:nil];
    self.selectModel = model;
    [self.baseDataArray addObject:model];
    [self.baseDataArray addObject:[self modelWithName:@"新注册" gender:@"0"]];
    [self.baseDataArray addObject:[self modelWithName:@"已接洽" gender:@"1"]];
    [self.baseDataArray addObject:[self modelWithName:@"会员" gender:@"2"]];
}



-(void)setSelectModel:(YFChooseGenderCModel *)selectModel
{
    _selectModel.isSelected = NO;
    selectModel.isSelected = YES;
    _selectModel = selectModel;
    [self.baseTableView reloadData];
}

- (YFChooseGenderCModel *)modelWithName:(NSString *)name gender:(NSString *)gender
{
    YFChooseGenderCModel *model = [[YFChooseGenderCModel alloc] initWithYYModelDictionary:nil];
    model.name = name;
    model.gender = gender;
    return model;
}

- (void)setSelectStatus:(NSString *)status
{
    for (YFChooseGenderCModel *model in self.baseDataArray)
    {
        if (!status && model.gender == nil)
        {
            self.selectModel = model;
        }else if ([status isEqualToString:model.gender])
        {
            self.selectModel = model;
        }
    }
}

@end
