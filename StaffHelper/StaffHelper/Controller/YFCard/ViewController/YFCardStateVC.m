//
//  YFCardStateVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/9.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFCardStateVC.h"

#import "YFCardStateModel.h"

#import "YFTBSectionLineEdgeDelegate.h"

@interface YFCardStateVC ()

@end

@implementation YFCardStateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.canGetMore = NO;
    [self.navi removeFromSuperview];

    YFCardStateModel *model = [self modelWithName:@"默认" state:0];
    self.cardStateModel = model;
    [self.baseDataArray addObject:model];
    [self.baseDataArray addObject:[self modelWithName:@"正常" state:1]];
    [self.baseDataArray addObject:[self modelWithName:@"请假中" state:2]];
    if (self.isNotSuffient == NO)
    {
    [self.baseDataArray addObject:[self modelWithName:@"已停卡" state:3]];
    }
    [self.baseDataArray addObject:[self modelWithName:@"已过期" state:4]];

    
    [self.baseTableView reloadData];
}

- (YFCardStateModel *)modelWithName:(NSString *)name state:(CardState)state
{
    YFCardStateModel *model = [[YFCardStateModel alloc] initWithYYModelDictionary:nil];
    model.name = name;
    model.cardState = state;
    return model;
}

-(void)setCardStateModel:(YFCardStateModel *)cardStateModel
{
    _cardStateModel.isSelected = NO;
    cardStateModel.isSelected = YES;
    _cardStateModel = cardStateModel;
    [self.baseTableView reloadData];
}

-(YFTBBaseDelegate *)delegateTBYF
{
    weakTypesYF
    return [YFTBSectionLineEdgeDelegate tableDelegeteWithArray:^NSMutableArray *{
        return weakS.baseDataArray;
        
    } currentVC:self];
}

@end
