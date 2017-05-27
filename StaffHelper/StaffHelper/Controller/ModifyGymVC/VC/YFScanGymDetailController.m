//
//  YFScanGymDetailController.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/18.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFScanGymDetailController.h"

#import "YFGymLogoCModel.h"

#import "YFDesTitleCModel.h"

#import "YFTBSectionLineEdgeDelegate.h"

@interface YFScanGymDetailController ()

@end

@implementation YFScanGymDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"场馆信息";

    [self requestData];
}

- (void)requestData
{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    YFGymLogoCModel *logoM = [YFGymLogoCModel defaultWithYYModelDic:nil];
    logoM.title =@"场馆logo";
    logoM.imageUrl = self.gym.imgUrl;
    
    YFDesTitleCModel *nameModel = [YFDesTitleCModel defaultWithYYModelDic:nil];
    nameModel.desStr = @"场馆名称(店名)";
    nameModel.title = self.gym.name;
    
    YFDesTitleCModel *addressModel = [YFDesTitleCModel defaultWithYYModelDic:nil];
    addressModel.desStr = @"地址";
    addressModel.title = self.gym.address;
    
    
    YFDesTitleCModel *phoneModel = [YFDesTitleCModel defaultWithYYModelDic:nil];
    phoneModel.desStr = @"联系方式";
    phoneModel.title = self.gym.contact;
    
    YFDesTitleCModel *desModel = [YFDesTitleCModel defaultWithYYModelDic:nil];
    desModel.desStr = @"描述";
    desModel.title = self.gym.summary;

    [dataArray addObject:logoM];
    [dataArray addObject:nameModel];
    [dataArray addObject:addressModel];
    [dataArray addObject:phoneModel];
    [dataArray addObject:desModel];
    
    self.baseDataArray = dataArray;
    
    [self.baseTableView reloadData];
}

-(YFTBSectionLineEdgeDelegate *)delegateTBYF
{
    weakTypesYF
    return  [YFTBSectionLineEdgeDelegate tableDelegeteWithArray:^NSMutableArray *{
        return weakS.baseDataArray;
    } currentVC:self];
}


@end
