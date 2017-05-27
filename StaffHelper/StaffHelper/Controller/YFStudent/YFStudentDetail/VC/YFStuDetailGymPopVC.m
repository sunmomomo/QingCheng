//
//  YFStuDetailGymPopVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/26.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFStuDetailGymPopVC.h"

#import "YFStuDetailPopViewCModel.h"

#import "ServicesInfo.h"

#import "UIView+YFLoadAniView.h"

@interface YFStuDetailGymPopVC ()

@end

@implementation YFStuDetailGymPopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navi removeFromSuperview];
    
//    [self refreshTableListDataNoPull];
}

- (void)requestData
{
//    if ([[ServicesInfo shareInfo] services].count > 0)
//    {
//        [self resultGyms:[[ServicesInfo shareInfo] services]];
//
//    }else
//    {
//        ServicesInfo *gymInfo = [[ServicesInfo alloc] init];
//        
//        __weak typeof(gymInfo)weakInfo = gymInfo;
//        
//        weakTypesYF
//        [gymInfo requestSuccess:^{
//            [weakS resultGyms:weakInfo.services];
//        } Failure:^{
//            [[ServicesInfo shareInfo] setServices:nil];
//        }];
//    }
}



- (void)resultGyms:(NSArray *)gymArray
{
    
    YFStuDetailPopViewCModel *model = [YFStuDetailPopViewCModel allModel];
 
    NSMutableArray *dataArra= [NSMutableArray array];
    
    [dataArra addObject:model];
    
    for (Gym *gym in gymArray) {
        
//        if (gym.brand.brandId == BRANDID.integerValue)
//        {
//            YFStuDetailPopViewCModel *subModel = [YFStuDetailPopViewCModel defaultWithYYModelDic:nil];
//            subModel.gym = gym;
//            [dataArra addObject:subModel];
//        }

        YFStuDetailPopViewCModel *subModel = [YFStuDetailPopViewCModel defaultWithYYModelDic:nil];
        subModel.gym = gym;
        if (gym.shopId == AppGym.shopId || self.gym.shopId == gym.shopId) {
            subModel.isSelected = YES;
            _selelcModel = subModel;
        }
        DebugLogParamYF(@"--%@--%@--%@",@(AppGym.shopId),@(gym.shopId),@(self.gym.shopId));
        [dataArra addObject:subModel];
    }
    self.baseDataArray = dataArra;
    [self.baseTableView reloadData];
//    [self requestSuccessArray:dataArra];
}

- (void)showLoadingViewWithMessage:(NSString *)message
{
//    [super showLoadingViewWithMessage:message];
//    self.view.loadViewYF.frame = CGRectMake(0, 0, Width320(218), Width320(205));
}

-(void)setSelelcModel:(YFStuDetailPopViewCModel *)selelcModel
{
    if (_selelcModel && [_selelcModel isEqual:selelcModel] == NO) {
        _selelcModel.isSelected = NO;
    }
    _selelcModel = selelcModel;
    [self.baseTableView reloadData];
    self.title = _selelcModel.gym.name;
    if (_selelcModel.isAll == YES)
    {
        self.title = @"全部场馆";
    }
    if (self.selectBlock) {
        self.selectBlock();
    }
}


@end
