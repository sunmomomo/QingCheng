//
//  YFChooseRecoVC.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFChooseRecoVC.h"
#import "YFStudentRightDataModel.h"
#import "YFStudentFilterRePeoModel.h"
#import "YFAppService.h"

@interface YFChooseRecoVC ()<UITextFieldDelegate>

@property(nonatomic,strong)YFStudentRightDataModel *dataModel;
@property(nonatomic,strong)UITextField *searchBar;


@end

@implementation YFChooseRecoVC

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.title.length == 0)
    {
        self.title = @"查找推荐人";
    }
    
    [self creatSearBar];
    
    self.baseTableView.frame = CGRectMake(0, 76 + 37, MSW, MSH - 76 - 37);
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.searchBar becomeFirstResponder];
}

-(void)creatSearBar
{
    
    
    self.searchBar = [[UITextField alloc]initWithFrame:CGRectMake(13.5, 76, MSW - 27, 37)];
    
    self.searchBar.backgroundColor = UIColorFromRGB(0xf1f1f1);
    
    self.searchBar.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.searchBar.layer.borderWidth = OnePX;
    
    self.searchBar.placeholder = @"输入姓名、手机号查找";
    
    self.searchBar.font = AllFont(12);
    
    self.searchBar.layer.cornerRadius = 2;
    
    self.searchBar.layer.masksToBounds = YES;
    
    self.searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchBar.returnKeyType = UIReturnKeySearch;
    self.searchBar.delegate = self;
    
    [self.searchBar addTarget:self action:@selector(searchBarDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 36)];
    
    self.searchBar.leftView = leftView;
    
    self.searchBar.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(9, 12.5, 12, 12)];
    
    leftImg.image = [UIImage imageNamed:@"student_search"];
    
    [leftView addSubview:leftImg];
    
    [self.view addSubview:self.searchBar];
}

- (void)searchBarDidChanged:(UITextField *)textfield
{
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length == 0)
    {
        [YFAppService showAlertMessage:@"请输入姓名或者手机号"];
        return YES;
    }
    [self refreshTableListDataNoPull];
    return YES;
}


- (void)requestData
{
    weakTypesYF
    self.dataModel.searchStr = self.searchBar.text;
    self.dataModel.dataPage = self.dataPage;
    self.dataModel.isFilter = NO;
    [self.dataModel getResponseSearchDatashowLoadingOn:nil gym:self.gym successBlock:^{
        
        for (YFStudentFilterRePeoModel *model in weakS.dataModel.searchDataModel.listArray) {
            if (model.r_id.integerValue == self.recoId.integerValue && self.recoId)
            {
                model.isSelected = YES;
            }
        }
        
        [weakS requestSuccessArray:weakS.dataModel.searchDataModel.listArray];
        
        if (weakS.dataPage >= weakS.dataModel.searchDataModel.pages.integerValue)
        {
            weakS.baseTableView.mj_footer = nil;
        }
        
    } failBlock:^{
        [weakS failRequest:nil];
    }];
    
}

- (YFStudentRightDataModel *)dataModel
{
    if (!_dataModel)
    {
        _dataModel = [[YFStudentRightDataModel alloc] init];
    }
    return _dataModel;
}

-(void)emptyDataReminderAction
{
    
}


-(void)setSelectModel:(YFStudentFilterRePeoModel *)selectModel
{
    if (_selectModel && [_selectModel isEqual:selectModel] == NO) {
        _selectModel.isSelected = NO;
    }
    _selectModel = selectModel;
    [self.baseTableView reloadData];
    
    if (self.selectBlock) {
        self.selectBlock();
    }
}


@end
