//
//  YFSmsListVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSmsListVC.h"

#import "YFSmsListCModel.h"

#import "YFSmsListViewModel.h"

#import "YFEmptyView.h"

@interface YFSmsListVC ()<UITextFieldDelegate>

@property(nonatomic, strong)UITextField *searchBar;

@property(nonatomic, strong)UIView *tHeadView;

@property(nonatomic, strong)YFSmsListViewModel *viewModel;

@property(nonatomic, strong)UIView *tableFootView;
@property(nonatomic, strong)UILabel *tableFootLabel;

@end

@implementation YFSmsListVC
{
    YFEmptyView *_emptyViewYF;
}


// 新短信发送成功
- (void)sendNewSmsSuccess
{
    [self showSuccessSendHint];
    [self refreshTableListDataNoPull];
}

- (void)showSuccessSendHint
{
    UIImageView *succeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 36)];
    [succeImageView setImage:[UIImage imageNamed:@"SendSmsSuccess"]];
    
    [self showHint:@"发送成功" customView:succeImageView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.numberOfEachPage = 30;
    
    [self refreshTableListDataNoPull];
    [self initView];

}


- (void)requestData
{
    self.viewModel.status = self.status;
    self.viewModel.page = self.dataPage;
    self.viewModel.searhStr = self.searchBar.text;
    weakTypesYF
    [self.viewModel getResponseDatashowLoadingOn:nil gym:self.gym successBlock:^{
        [weakS requestSuccessArray:weakS.viewModel.dataArray];
        [weakS tableFootView];
    } failBlock:^{
        [weakS failRequest:nil];
    }];
    
//    NSMutableArray *dataArray = [NSMutableArray array];
//    NSDictionary *dic = @{@"title":@"Kent、方志恒、林雪婷、段光英等30名会员",
//                          @"content":@"亲爱的会员您好，2017春节将至，中美引力阳光上东店春节休息时间为2017-01-24至2017-02-05. 休息期间将",
//                          @"status":@"1"
//                          };
//    NSDictionary *subDic = @{@"title":@"(未填写收件人)",
//                             @"content":@"(未填写短信内容)",
//                             @"status":@"0"
//                             };
//    for (NSInteger i = 0; i < 10; i ++)
//    {
//        YFSmsListCModel *model1 =  [YFSmsListCModel defaultWithYYModelDic:dic];
//        [dataArray addObject:model1];
//        YFSmsListCModel *model2 =  [YFSmsListCModel defaultWithYYModelDic:subDic];
//        [dataArray addObject:model2];
//    }
//    [self requestSuccessArray:dataArray];
}

- (void)initView
{
    [self setRefreshHeadViewYF];
    
    [self.navi removeFromSuperview];
    
    self.baseTableView.frame = CGRectMake(0, 0, MSW, MSH  - 108);
    [self.baseTableView setTableFooterView:self.tableFootView];
    self.baseTableView.backgroundColor = YFGrayViewColor;
    [self.tHeadView addSubview:self.searchBar];
    
    [self.baseTableView setTableHeaderView:self.tHeadView];
}
- (void)searchBarDidChanged:(UITextField *)textfield
{
    //清空
    if (textfield.text.length == 0 && self.viewModel.searhStr.length != 0)
    {
        self.searchStr = @"";

        [self refreshTableListDataNoLoading];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField.text.length > 0)
    {
        DebugLogParamYF(@"搜索--：%@",textField.text);
        
        
    }
    
    if ([self.searchBar.text isEqualToString:self.viewModel.searhStr] == NO)
    {
        self.searchStr = textField.text;
        [self refreshTableListDataNoPull];
    }
    return YES;
}

- (UITextField *)searchBar
{
    if (_searchBar == nil) {
        
        _searchBar = [[UITextField alloc]initWithFrame:CGRectMake(12, 12, MSW - 24, 36)];
        
        _searchBar.backgroundColor = UIColorFromRGB(0xf1f1f1);
        
        _searchBar.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        _searchBar.layer.borderWidth = OnePX;
        
        _searchBar.placeholder = @"搜索短信内容/收件人";
        
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
        
        _tHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MSW, 60)];
        _tHeadView.backgroundColor = RGB_YF(244, 244, 244);
        _tHeadView.layer.borderColor = YFGrayViewColor.CGColor;
        _tHeadView.layer.borderWidth = 1.0;
    }
    return _tHeadView;
}

- (YFSmsListViewModel *)viewModel
{
    if (_viewModel == nil)
    {
        _viewModel = [YFSmsListViewModel dataModel];
    }
    return _viewModel;
}


-(void)emptyDataReminderAction
{
    if (self.emptyView)
    {
        
        [self.baseTableView addSubview:self.emptyView];
        
        [self.baseTableView bringSubviewToFront:self.emptyView];
    }
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
        
        
        _emptyViewYF.emptyLabel.textColor = YFCellTitleColor;
        
        _emptyViewYF.emptyLabel.font = FontSizeFY(15.0);
        
        _emptyViewYF.emptyLabel.frame = CGRectMake(_emptyViewYF.emptyLabel.mj_x, _emptyViewYF.emptyImg.bottom + Height320(3.5), _emptyViewYF.emptyLabel.width, _emptyViewYF.emptyLabel.height);
        
        _emptyViewYF.addbutton.hidden = YES;
        
        
        UILabel *emptyMessageLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, _emptyViewYF.emptyLabel.bottom - Height320(4), MSW-40, Height320(13))];
        
        emptyMessageLabel.numberOfLines = 0;
        
        emptyMessageLabel.textColor = RGB_YF(136, 136, 136);
        
        emptyMessageLabel.font = FontSizeFY(13.0);
        
        emptyMessageLabel.textAlignment = NSTextAlignmentCenter;
        
        emptyMessageLabel.text = @"点击右下方按钮新建短信";
        
        [_emptyViewYF addSubview:emptyMessageLabel];
        
    }
    if (self.searchStr)
    {
        _emptyViewYF.emptyLabel.text = @"无搜索结果";
    }
    else
    {
        _emptyViewYF.emptyLabel.text = @"暂无短信记录";
    }
    

    
    //        _emptyViewYF.emptyImg.hidden = NO;
    //
    //
    //        [_emptyViewYF.emptyLabel changeTop:_emptyViewYF.emptyImg.bottom+Height320(19.5)];
    //
    //        [_emptyViewYF.addbutton changeTop:_emptyViewYF.emptyLabel.bottom+Height320(19.5)];
    
    return _emptyViewYF;
}


-(UIView *)tableFootView
{
    if (!_tableFootView)
    {
        _tableFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MSW, 44)];
        _tableFootView.backgroundColor = YFGrayViewColor;
        CGFloat labelWidth = 70;
        _tableFootLabel = [[UILabel alloc] initWithFrame:CGRectMake((_tableFootView.width - labelWidth) / 2.0, 0, labelWidth, 44)];
        
        _tableFootLabel.backgroundColor = YFGrayViewColor;
        _tableFootLabel.textColor = RGB_YF(153, 153, 153);
        _tableFootLabel.font = FontSizeFY(12.0);
        _tableFootLabel.textAlignment = NSTextAlignmentCenter;
        [_tableFootView addSubview:_tableFootLabel];
        
        CGFloat lineViewWidth = 0.25 * _tableFootView.width;;
        CGFloat lineViewxx1 = _tableFootLabel.left - lineViewWidth - 10;
        CGFloat lineViewxx2 = _tableFootLabel.right + 10;
        
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(lineViewxx1, _tableFootView.height / 2.0, lineViewWidth, 0.5)];
        lineView1.backgroundColor = YFLineViewColor;
        [_tableFootView addSubview:lineView1];
        
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(lineViewxx2, _tableFootView.center.y, lineViewWidth, 0.5)];
        lineView2.backgroundColor = YFLineViewColor;
        [_tableFootView addSubview:lineView2];
        
    }
    
    
    [self setTableFootviewLabelNum:self.viewModel.arrayModel.total_count.integerValue];
    
    return _tableFootView;
}

- (void)setTableFootviewLabelNum:(NSInteger )count
{
    if (count > 0) {
        _tableFootLabel.text = [NSString stringWithFormat:@"共%@条短信",@(count)];
        _tableFootView.hidden = NO;
    }else
    {
        _tableFootView.hidden = YES;
    }
}

@end
