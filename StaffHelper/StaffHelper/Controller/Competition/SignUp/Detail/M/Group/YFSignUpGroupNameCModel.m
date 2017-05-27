//
//  YFSignUpGroupNameCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/29.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpGroupNameCModel.h"

#import "YFSignUpModifyGrouplVC.h"

#import "YFSignUpListGroupDetailVC.h"

#import "YFCompetionHeader.h"

@implementation YFSignUpGroupNameCModel


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.indexPath = indexPath;
    
    YFSignUpModifyGrouplVC *modifyNameVC = [[YFSignUpModifyGrouplVC alloc] init];
    
    modifyNameVC.groupName = self.desValue;
    
    __weak typeof(modifyNameVC)weakVC = modifyNameVC;
    
 
    weakTypesYF
    [modifyNameVC setSureNameBlock:^(NSString * name) {
       
        [weakS changeName:name currentShowVC:weakVC];
    }];
    
    [self.weakCell.currentVC.navigationController pushViewController:modifyNameVC animated:YES];
}

- (void)changeName:(NSString *)groupName currentShowVC:(UIViewController *)viewC
{
    __weak typeof(viewC)weakVC = viewC;

    YFSignUpListGroupDetailVC *currentVC = (YFSignUpListGroupDetailVC *)self.weakCell.currentVC;
    
    weakTypesYF
    currentVC.viewModel.gym_id = currentVC.gym_id;
    [currentVC.viewModel putGroupName:groupName userIds:nil teams_id:currentVC.teams_id showLoadingOn:viewC.view  successBlock:^{
        
        weakS.desValue = groupName;
        
        weakS.weakCell.currentVC.title = groupName;
        
        [weakS bindCell:weakS.weakCell indexPath:self.indexPath];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kPostChangeGroupDetailIdtifierYF object:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakVC.navigationController popViewControllerAnimated:YES];
        });
    } failBlock:^{
        
    }];
}
@end
