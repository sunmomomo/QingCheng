//
//  YFChooseGymCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/4/5.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFChooseGymCModel.h"

#import "YFChooseGymCell.h"

#import "YYModel.h"

#import "YFChooseGymVC.h"

#import "YFModifyGymDetailController.h"

#import "NSMutableDictionary+YFExtension.h"

#import "YFHttpService+Extension.h"

#import "Parameters+YFExtension.h"

#import "YFCompetionHeader.h"

#import "UIView+YFLoadingView.h"

#import "YFAppService.h"

#import "YFGymModule.h"

static NSString *yFChooseGymCell = @"YFChooseGymCell";

@interface YFChooseGymCModel ()<YYModel>

@end

@implementation YFChooseGymCModel

- (void)cellSettingYF
{
    self.cellHeight = 78;
    self.cellIdentifier = yFChooseGymCell;
    self.cellClass = [YFChooseGymCell class];
    self.edgeInsets = UIEdgeInsetsMake(0, 78, 0, 0);
}

- (void)bindCell:(YFChooseGymCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    baseCell.titleLabel.text = self.gym.name;
    baseCell.detailLabel.text = self.gym.brand.name;
    [baseCell.headImageView sd_setImageWithURL:self.gym.imgUrl];
    

        if (self.gym.gd_district)
        {
            baseCell.gotoDisLabel.hidden = YES;
            baseCell.arrowImageView.hidden = YES;
        }
        else
        {
            baseCell.gotoDisLabel.hidden = NO;
            baseCell.arrowImageView.hidden = NO;
        }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Parameters *para = [Parameters instanceYFWithGym:self.gym];
    
    NSString *urlString = [NSString stringWithFormat:kStaffsCompetitionGymIsSuperusersTeamsYF,ROOT,@(StaffId)];
    weakTypesYF
    [self.weakCell.currentVC.view showLoadingViewWithMessage:nil];
    [YFHttpService getList:urlString parameters:para.data modelClass:nil showLoadingOnView:nil success:^(YFRespoStatusModel * _Nullable statusModel, YFRespoDataArrayYYModel * _Nullable arrayModel) {
       
        if (statusModel.isSuccess)
        {
        BOOL isSuper = [[statusModel.dataModel.dic objectForKey:@"is_superuser"] boolValue];
            
            if (isSuper)
            {
                [weakS successGoto];
            }else
            {
                [YFAppService showAlertMessage:@"仅超级管理员有权限报名"];
            }
        }
        
        
        [weakS.weakCell.currentVC.view stopLoadingViewWithMessage:nil];
    } failure:^(NSError * _Nullable error) {
        [weakS.weakCell.currentVC.view stopLoadingViewWithMessage:nil];
    }];
}

- (void)successGoto
{
    YFChooseGymVC *vc = (YFChooseGymVC *)self.weakCell.currentVC;

    if (self.gym.gd_district)
    {
        if (vc.chooseGymBlock)
        {
            NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
            
            [dataDic setObject_FY:@(self.gym.gym_IdForCompet) forKey:@"gym_id"];
            [dataDic setObject_FY:self.gym.name forKey:@"name"];
            
            vc.chooseGymBlock(dataDic);
        }
    }
    else
    {
        __weak typeof(vc)weakVC = vc;
        UIViewController *svc = [YFGymModule modifyGymVCWithGym:self.gym modifySuccessBlock:^(id model) {
            [weakVC refreshTableListDataNoPull];
            [weakVC.navigationController popViewControllerAnimated:YES];
        }];
        
        [self.weakCell.currentVC.navigationController pushViewController:svc animated:YES];
    }

}



@end
