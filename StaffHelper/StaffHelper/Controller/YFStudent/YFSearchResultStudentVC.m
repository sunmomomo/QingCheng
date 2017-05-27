//
//  YFSearchResultStudentVC.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFSearchResultStudentVC.h"
#import "YFEmptyView.h"

@interface YFSearchResultStudentVC ()<UITextFieldDelegate>

@property(nonatomic, strong)UIView *searchView;
@property(nonatomic, strong)UITextField *searchBar;

@end

@implementation YFSearchResultStudentVC
{
    YFEmptyView *_emptyViewYF;
}

@synthesize searStrDes = _searStrDes;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.searchView];
    [self.searchView addSubview:self.searchBar];
    
     [self.view bringSubviewToFront:self.searchView];
    
    [self settingSearchBar];
    [self.baseTableView addSubview:self.emptyView];

}
- (void)naviRightClick
{
    [self.view bringSubviewToFront:self.searchView];
}

- (void)hideSearchView
{
    self.view.hidden = YES;
}

- (void)showSearchView
{
    self.view.hidden = NO;
    self.searchView.hidden = NO;
    [self.searchBar becomeFirstResponder];
    [self.view.superview bringSubviewToFront:self.view];
    [self.view bringSubviewToFront:self.searchView];
}


- (void)settingSearchBar
{
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, self.searchBar.height)];
    
    UIImageView *searchImg = [[UIImageView alloc]initWithFrame:CGRectMake(16.8, 10.3, 15.5, 15.5)];
    
    searchImg.image = [UIImage imageNamed:@"search"];
    
    [leftView addSubview:searchImg];
    
    self.searchBar.leftView = leftView;
    
    self.searchBar.leftViewMode = UITextFieldViewModeAlways;
    
    self.searchBar.delegate = self;
    
    self.searchBar.placeholder = @"搜索会员";
    
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    clearButton.frame = CGRectMake(self.searchBar.right-Width320(24), 0, Width320(24), self.searchBar.height);
    
    self.searchBar.rightView = clearButton;
    
    UIImageView *clearImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(3), 0, Width320(12.4), Height320(12.4))];
    
    clearImg.image = [UIImage imageNamed:@"clear"];
    
    clearImg.center = CGPointMake(clearImg.center.x, clearButton.height/2);
    
    [clearButton addSubview:clearImg];
    
    [clearButton addTarget:self action:@selector(clear:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    
    cancel.frame = CGRectMake(self.searchBar.right, 20, MSW-self.searchBar.right, 44);
    
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    
    [cancel setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    cancel.backgroundColor = [UIColor clearColor];
    
    [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.searchView addSubview:cancel];
}


#pragma mark -- Getter
- (UIView *)searchView
{
    if (_searchView == nil)
    {
        _searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, 64)];
        
        _searchView.backgroundColor = UIColorFromRGB(0x4e4e4e);
        
    }
    return _searchView;
}

- (UITextField *)searchBar
{
    if (_searchBar == nil)
    {
        _searchBar = [[UITextField alloc]initWithFrame:CGRectMake(Width320(7.5), 23.1, Width320(257), 35.7)];
        
        
        _searchBar.returnKeyType = UIReturnKeySearch;
        
        _searchBar.layer.cornerRadius = 2;
        
        _searchBar.layer.masksToBounds = YES;
        
        _searchBar.backgroundColor = UIColorFromRGB(0xfafafa);
        
        _searchBar.font = AllFont(14);
        [_searchBar addTarget:self action:@selector(textFieldDidChangedYF:) forControlEvents:UIControlEventEditingChanged];

        
    }
    return _searchBar;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.view.hidden == NO)
    {
        [self showSearchView];
    }
}


- (void)naviLeftClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clear:(UIButton*)btn
{
//    self.searchBar.text = @"";
    
    [self.searchBar resignFirstResponder];
    
    [self textFieldDidChangedYF:self.searchBar];
}
- (void)cancel:(UIButton*)btn
{
    [self.searchBar resignFirstResponder];
    
    
    self.searchBar.text = @"";
    
    [self textFieldDidChangedYF:self.searchBar];
    
    [self hideSearchView];
}

- (void)textFieldDidChangedYF:(UITextField *)textField
{
    NSString *changeSearStr = textField.text;
    
    [self searchStrChangeYF:changeSearStr];
}

-(void)searchStrChangeYF:(NSString *)str
{
    
}

-(void)requestSearchWithStrYF:(NSString *)str
{
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length == 0) {
        [self showHint:@"请输入搜索关键字"];
        return YES;
    }
//    [textField resignFirstResponder];
    [self requestSearchWithStrYF:textField.text];
    return YES;
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
    
        self.baseTableView.backgroundColor = _tableFootView.backgroundColor;
    }
    
    return _tableFootView;
}

- (void)setTableFootviewLabelNum:(NSInteger )count
{
    
//    搜索全部会员，无搜索结果
    if (count > 0) {
        self.tableFootView.hidden = NO;
        _tableFootLabel.text = [NSString stringWithFormat:@"%@名会员",@(count)];
        [self.baseTableView setTableFooterView:self.tableFootView];
        [self.emptyView removeFromSuperview];

    }else
    {
        _emptyViewYF.emptyLabel.text = @"无搜索结果";
        [self.baseTableView addSubview:self.emptyView];
        self.tableFootView.hidden = YES;
        [self.baseTableView setTableFooterView:[[UIView alloc] init]];
    }
}

- (NSString *)searStrDes
{
    if (!_searStrDes)
    {
        _searStrDes = @"搜索全部会员";
    }
    return _searStrDes;
}

- (UIView *)emptyView
{
    if (!_emptyViewYF)
    {
        _emptyViewYF = [[YFEmptyView alloc] initWithFrame:CGRectMake(0, 0, self.baseTableView.width, self.baseTableView.height)];
        
        _emptyViewYF.emptyImg.hidden = NO;
        
        _emptyViewYF.addbutton.hidden = YES;
        
        [_emptyViewYF.emptyLabel changeTop:_emptyViewYF.emptyImg.bottom+Height320(19.5)];
        
        [_emptyViewYF.addbutton changeTop:_emptyViewYF.emptyLabel.bottom+Height320(19.5)];
        
        _emptyViewYF.emptyLabel.text = self.searStrDes;
        
        _emptyViewYF.emptyImg.image = [UIImage imageNamed:@"SearchResult"];
        
        _emptyViewYF.emptyImg.frame = CGRectMake((_emptyViewYF.width - Width320(20)) / 2.0, Height320(80), Width320(20), Height320(20));
        
        [_emptyViewYF.emptyLabel changeTop:_emptyViewYF.emptyImg.bottom];
        _emptyViewYF.backgroundColor = [UIColor whiteColor];
    }
    return _emptyViewYF;
}

- (void)setSearStrDes:(NSString *)searStrDes
{
    _searStrDes = searStrDes;
    
    _emptyViewYF.emptyLabel.text = self.searStrDes;

    
}




@end
