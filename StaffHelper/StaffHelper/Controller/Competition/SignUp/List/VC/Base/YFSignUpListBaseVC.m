//
//  YFSignUpListBaseVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/28.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpListBaseVC.h"

#import "UIView+lineViewYF.h"

#import "UIView+YFLoadAniView.h"

@interface YFSignUpListBaseVC ()

@end

@implementation YFSignUpListBaseVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self setRefreshHeadViewYF];

    [self refreshTableListDataNoPull];
}

- (void)initView
{
    [self.baseTableView setTableHeaderView:self.tHeadView];
    self.baseTableView.backgroundColor = YFGrayViewColor;
    
    self.baseTableView.frame = CGRectMake(0, 0, MSW, MSH - 114);
    
}
- (void)initBaseMOView
{
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length > 0)
    {
        DebugLogParamYF(@"搜索--：%@",textField.text);
    }
    
    self.viewModel.searchStr = textField.text;
    [self refreshTableListDataNoPull];
    return YES;
}

- (void)searchBarDidChanged:(UITextField *)textfield
{
    //清空
    if (textfield.text.length == 0)
    {
        self.viewModel.searchStr = textfield.text;
        
        [self refreshTableListDataNoLoading];
    }
}



#pragma mark Setter
- (UITextField *)searchBar
{
    if (_searchBar == nil) {
        
        _searchBar = [[UITextField alloc]initWithFrame:CGRectMake(12, 12, MSW - 24, 36)];
        
        _searchBar.backgroundColor = UIColorFromRGB(0xf1f1f1);
        
        _searchBar.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        _searchBar.layer.borderWidth = OnePX;
        
        
        _searchBar.font = FontSizeFY(XFrom6YF(13));
        
        _searchBar.backgroundColor = [UIColor whiteColor];
        
        _searchBar.layer.cornerRadius = 2;
        
        _searchBar.layer.masksToBounds = YES;
        
        _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _searchBar.returnKeyType = UIReturnKeySearch;
        
        _searchBar.delegate = self;
        
        [_searchBar addTarget:self action:@selector(searchBarDidChanged:) forControlEvents:UIControlEventEditingChanged];

        
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 36)];
        
        _searchBar.leftView = leftView;
        
        _searchBar.leftViewMode = UITextFieldViewModeAlways;
        
        UIImageView *leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(9, 12.5, 12, 12)];
        
        leftImg.image = [UIImage imageNamed:@"student_search"];
        
        [leftView addSubview:leftImg];
        
    }
    return _searchBar;
}

- (UIView *)tHeadView
{
    if (_tHeadView == nil) {
        _tHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MSW, 90)];
        _tHeadView.backgroundColor = YFGrayViewColor;
        _tHeadView.layer.borderColor = YFGrayViewColor.CGColor;
        _tHeadView.layer.borderWidth = 1.0;
        [_tHeadView addSubview:self.searchBar];
        [_tHeadView addSubview:self.peoPayNumLabel];
        
        [_tHeadView addLinewViewToBottom];
    }
    return _tHeadView;
}

- (UILabel *)peoPayNumLabel
{
    if (!_peoPayNumLabel)
    {
        _peoPayNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 48, MSW - 26, 41)];
        _peoPayNumLabel.textColor = YFCellSubGrayTitleColor;
        _peoPayNumLabel.font = FontSizeFY(13);
        _peoPayNumLabel.layer.borderColor = YFGrayViewColor.CGColor;
        
    }
    return _peoPayNumLabel;
}


- (YFSignUpViewModel *)viewModel
{
    if (!_viewModel)
    {
        _viewModel = [YFSignUpViewModel dataModel];
        
        _viewModel.gym_id = self.gym_id;
    }
    return _viewModel;
}

@end
