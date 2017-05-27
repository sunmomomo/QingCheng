//
//  YFcompetitionAction.m
//  StaffHelper
//
//  Created by FYWCQ on 17/4/9.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFcompetitionAction.h"

#import "YFCompetitionModule.h"

#import "NSString+YFCategory.h"

#import "YFCompetionHeader.h"

@implementation YFcompetitionAction

- (YFReturnValue)yf_select_shop:(NSDictionary *)param
{
    weakTypesYF
    
    UIViewController *controller = [YFCompetitionModule chooseGymVCCompletion:^(NSDictionary * dic) {
        
        NSString *urlString =[NSString stringWithFormat:@"window.nativeLinkWeb.callbackLst['competition/select_shop'](%@)",[NSString stringFromdictioanry_nn:dic]];
      
        DebugLogParamYF(@"%@",urlString);

        
        [[weakS vcWithParam:param].navigationController  popViewControllerAnimated:YES];
        [[weakS webViewWithParam:param] stringByEvaluatingJavaScriptFromString:urlString];
    }];
    
    [[self vcWithParam:param].navigationController pushViewController:controller animated:YES];
    return YF_YES;
}

- (YFReturnValue)yf_form:(NSDictionary *)param
{
    NSLog(@"0000239993939jjjj");
    
    NSNumber *gym_id = [param[@"gym_id"] guardNumberYF];
    
    NSNumber *competion_id = [param[@"id"] guardNumberYF];
    
    if (gym_id.integerValue <=0 || competion_id.integerValue <= 0)
    {
        return YF_NO;
    }
    
     UIViewController *contestVC = [YFCompetitionModule signUpListVCWithGym:gym_id comeptitionId:competion_id];
    
    [[self vcWithParam:param].navigationController pushViewController:contestVC animated:YES];
    return YF_YES;

}





@end
