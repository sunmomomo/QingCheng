//
//  YFSignUpListPerVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/27.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpListPerVC.h"

#import "YFSignUpListCModel.h"

#import "YFSignUpViewModel.h"

#import "YFEmptyView.h"

@interface YFSignUpListPerVC ()<UITextFieldDelegate>

@end

@implementation YFSignUpListPerVC
{
    YFEmptyView *_emptyViewYF;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.searchBar.placeholder = @"搜索会员姓名/手机号";

}

- (void)requestData
{
    self.viewModel.page = self.dataPage;
    self.viewModel.competition_id = self.competition_id;
    self.viewModel.gym_id = self.gym_id;
    
    weakTypesYF
    [self.viewModel getResponseDatashowLoadingOn:nil  listModelClass:[YFSignUpListCModel class] successBlock:^{
        
        weakS.peoPayNumLabel.text = [NSString stringWithFormat:@"报名人数：%@人       报名费：%.2f元",weakS.viewModel.arrayModel.total_count,weakS.viewModel.arrayModel.total_price.floatValue];

        [weakS requestSuccessArray:weakS.viewModel.arrayModel.listArray];

    } failBlock:^{
        [weakS failRequest:nil];
    }];
    
//    self.viewModel.page = self.dataPage;
//    [self requestSuccessArray:[YFSignUpListCModel creatTestModelArray]];
}




- (UIView *)emptyView
{
    if (!_emptyViewYF)
    {
        _emptyViewYF = [[YFEmptyView alloc] initWithFrame:CGRectMake(0, 60, self.baseTableView.width, self.baseTableView.height - 60)];
        
        CGFloat emptyImageWidht = 144;
        CGFloat emptyImageHeight = 146;
        
        CGFloat emptyImageYY = 126;
        
        CGFloat emptyImageXX = (_emptyViewYF.width - emptyImageWidht )/ 2.0;
        
        _emptyViewYF.emptyImg.frame = CGRectMake(emptyImageXX, emptyImageYY, emptyImageWidht, emptyImageHeight);
        
        _emptyViewYF.backgroundColor = [UIColor whiteColor];
        
        _emptyViewYF.emptyImg.image = [UIImage imageNamed:@"SmsEmptyImage"];
        
        
        _emptyViewYF.emptyLabel.textColor = YFCellSubGrayTitleColor;
        
        _emptyViewYF.emptyLabel.font = FontSizeFY(Width(16));
        
        _emptyViewYF.emptyLabel.frame = CGRectMake(_emptyViewYF.emptyLabel.mj_x, _emptyViewYF.emptyImg.bottom + Height320(3.5), _emptyViewYF.emptyLabel.width, _emptyViewYF.emptyLabel.height);
        
        _emptyViewYF.addbutton.hidden = YES;

    }
    if (self.viewModel.searchStr.length)
    {
        _emptyViewYF.emptyLabel.text = @"未找到结果";
        _emptyViewYF.frame = CGRectMake(0, 60, self.baseTableView.width, self.baseTableView.height - 60);
        
        [_emptyViewYF.emptyImg changeTop:66];
    }
    else
    {
        _emptyViewYF.frame = self.baseTableView.bounds;
        _emptyViewYF.emptyLabel.text = @"还没有人报名";
        
        [_emptyViewYF.emptyImg changeTop:126];
    }
    
    [_emptyViewYF.emptyLabel changeTop:_emptyViewYF.emptyImg.bottom + Height320(3.5)];
    
    return _emptyViewYF;
}






@end
