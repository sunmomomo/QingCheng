//
//  YFStudnetChooseGenderVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/4/12.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFStudnetChooseGenderVC.h"

#import "YFChooseGenderCModel.h"


@interface YFStudnetChooseGenderVC ()

@end

@implementation YFStudnetChooseGenderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.canGetMore = NO;
    [self.navi removeFromSuperview];
    
    YFChooseGenderCModel *model = [self modelWithName:@"不限" gender:nil];
    self.selectModel = model;
    [self.baseDataArray addObject:model];
    [self.baseDataArray addObject:[self modelWithName:@"男" gender:@"0"]];
    [self.baseDataArray addObject:[self modelWithName:@"女" gender:@"1"]];
    
    [self.baseTableView reloadData];

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

@end
