//
//  YFStudentListVC.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/20.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentListVC.h"
#import "UIView+masonryExtesionYF.h"
#import "YFButton.h"
#import "YFStudentListModel.h"

#import "YFTBStudentTBDatasource.h"
#import "YFTBStudentTBDelegate.h"
#import "YFTBSectionsModel.h"
#import "YFTBSectionsTitleModel.h"
#import "YFStudentListDataModel.h"
#import "YFAppService.h"
#import "GymListInfo.h"
#import "YFEmptyView.h"
#import "StudentEditController.h"
#import "StudentChooseGymController.h"
#import "SellerListController.h"
#import "CoachDistributeListController.h"
#import "CoachChooseGymController.h"
#import "YFHttpService.h"

#import "GymProHintView.h"

// 跟进中
#import "YFStudentFollowingVC.h"
// 搜索页面
#import "YFSearchResultStuListVC.h"
#import "YFModuleManager.h"
#import "SellerChooseGymController.h"
#import "YFListCache.h"

#import "YFStudentOutVC.h"

#import "YFStudentStateDetailVC.h"

#import "YFConditionSellerPopView.h"

#import "YFConditionTimeNoTodayNOMaxCountPopView.h"

@interface YFStudentListVC ()<UITextFieldDelegate,GymTrySuccessAlertDelegate,GymProHintViewDelegate>

@property(nonatomic, strong)UIView *searchView;
@property(nonatomic, strong)UITextField *searchBar;
@property(nonatomic, strong)UIView *tableHeadView;
@property(nonatomic, strong)UIView *tableFootView;
@property(nonatomic, strong)UILabel *tableFootLabel;

@property(nonatomic, strong)NSMutableArray *tableHeadTitleArray;
@property(nonatomic, strong)UIView *conditionButtonViews;
@property(nonatomic, strong)YFButton *buttonOfLetterFilter;
@property(nonatomic, strong)YFButton *buttonOfNewRegisterFilter;
@property(nonatomic, strong)YFButton *buttonOfOtherFilter;

@property(nonatomic,strong)YFStudentListDataModel *dataModel;

@property(nonatomic,strong)NSArray *allLetterKeys;

@property(nonatomic,strong)YFFilterOtherModel *temFilterModel;

// 搜索 VC
@property(nonatomic, strong)YFSearchResultStuListVC *searchResultVC;

@property(nonatomic,strong)UITapGestureRecognizer *tempTap;

@property(nonatomic,strong)NSMutableArray *proLabels;

@end

@implementation YFStudentListVC
{
    YFEmptyView *_emptyViewYF;
    BOOL _isFirstTimeRequestData;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableListDataNoPull) name:kPostModifyOrAddStudentIdtifierYF object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableListDataNoPullNoCache) name:kPostAddNewMemberIdtifierYF object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableListDataNoPullNoCache) name:kPostDeleteMemberIdtifierYF object:nil];
        
        _isFirstTimeRequestData = YES;
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.rightVC = nil;
    self.conditionButtonViews = nil;
}

- (void)refreshTableListDataNoPullNoCache
{
    [YFListCache removeCacheOnDocumentStudentArrayFromKey:YFCacheKey];
    
    [self refreshTableListDataNoPull];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 没有加载
    self.canGetMore = NO;
    
    self.view.backgroundColor = YFGrayViewColor;
    
    self.rightType = MONaviRightTypeSearch;
    
    self.title = @"会员";
    
    [self.baseTableView setTableHeaderView:self.tableHeadView];
    
    self.baseTableView.tintColor = RGB_YF(111, 111, 111);
    
    //    [self.baseTableView setTableFooterView:self.tableFootView];
    
    self.baseTableView.allowsSelection = YES;
    self.baseTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
    
    [self refreshTableListDataNoPull];
    [self setRefreshHeadViewYF];
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW-Width320(74), MSH-Height320(75), Width320(48), Height320(48))];
    
    [addButton setImage:[UIImage imageNamed:@"user_list_add"] forState:UIControlStateNormal];
    
    addButton.layer.shadowOffset = CGSizeMake(0, Height320(2));
    
    addButton.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
    
    addButton.layer.shadowOpacity = 0.3;
    
    [self.view addSubview:addButton];
    
    [addButton addTarget:self action:@selector(addUser:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)requestData
{
    if (self.isReFreshing && _isFirstTimeRequestData == NO)
    {
        [self.rightVC refreshTableListDataNoPull];
    }
    _isFirstTimeRequestData = NO;
    [YFHttpService getUseNameComplete:^{
    }];
    weakTypesYF
    [self.dataModel getResponseDatashowLoadingOn:nil gym:self.gym filterModel:self.temFilterModel successBlock:^{
        weakS.allLetterKeys = weakS.dataModel.showLetterKeys;
        weakS.buttonOfLetterFilter.selected = YES;
        weakS.buttonOfNewRegisterFilter.selected = NO;
        
        if (weakS.dataModel.allMemNum > 0)
        {
            [weakS.baseTableView setTableFooterView:weakS.tableFootView];
        }else
        {
            [weakS.baseTableView setTableFooterView:[[UIView alloc] init]];
        }
        [weakS requestSuccessArray:weakS.dataModel.showLetterFilterdataArray];
        
        
        weakS.dataModel.isShowIngArray = weakS.baseDataArray;
        
        
    } failBlock:^{
        [weakS failRequest:nil];
    }];
    
    //    YFStudentListModel *listCellModel = [[YFStudentListModel alloc] initWithDictionary:nil];
    //
    //    NSMutableArray *array = [NSMutableArray array];
    //
    //    [array addObject:listCellModel];
    //    [array addObject:listCellModel];
    //    [array addObject:listCellModel];
    //    [array addObject:listCellModel];
    //    [array addObject:listCellModel];
    //    [array addObject:listCellModel];
    //    [array addObject:listCellModel];
    //
    //    YFTBSectionsTitleModel *model1 = [[YFTBSectionsTitleModel alloc] init];
    //    [model1 setStudentFilter];
    //    model1.dataArray = array;
    //
    //    YFTBSectionsTitleModel *model2 = [[YFTBSectionsTitleModel alloc] init];
    //    [model2 setStudentFilter];
    //    model2.dataArray = array;
    //
    //    YFTBSectionsTitleModel *model3 = [[YFTBSectionsTitleModel alloc] init];
    //    [model3 setStudentFilter];
    //    model3.dataArray = array;
    //
    //    YFTBSectionsTitleModel *model4 = [[YFTBSectionsTitleModel alloc] init];
    //    [model4 setStudentFilter];
    //    model4.dataArray = array;
    //
    //
    //    NSMutableArray *allSectionArray = [NSMutableArray array];
    //    [allSectionArray addObject:model1];
    //    [allSectionArray addObject:model2];
    //    [allSectionArray addObject:model3];
    //    [allSectionArray addObject:model4];
    //
    //
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [self requestSuccessArray:allSectionArray];
    //
    //    });
}

#pragma mark -- Action Event
- (void)addUser:(UIButton*)button
{
    
    [self addStudentAction:nil];
    
}
- (void)naviLeftClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)naviRightClick
{
    [self.searchResultVC showSearchView];
    //
}

- (void)clear:(UIButton*)btn
{
    self.searchBar.text = @"";
    
    [self.searchBar resignFirstResponder];
    
    [self textFieldDidChanged:self.searchBar];
}
- (void)cancel:(UIButton*)btn
{
    [self.searchBar resignFirstResponder];
    
    self.searchView.hidden = YES;
    
    self.searchBar.text = @"";
    
    [self textFieldDidChanged:self.searchBar];
    
    //    [self refreshTableListData];
}

-(void)setBaseDataArray:(NSMutableArray *)baseDataArray
{
    [super setBaseDataArray:baseDataArray];
    
    self.dataModel.isShowIngArray = self.baseDataArray;
    
    
    if (self.baseDataArray.count == 0)
    {
        if (self.failViewYF.superview && self.failViewYF.hidden == NO) {
            
        }else
        {
            [self.baseTableView addSubview:self.emptyView];
        }
    }else
    {
        [self.emptyView removeFromSuperview];
    }
    
}

-(void)textFieldDidChanged:(UITextField *)textField
{
    //    NSString *changeSearStr = textField.text;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [self textFieldDidChanged:textField];
    
    return YES;
    
}

// fileter 本地排序
- (void)letterFilterAction:(UIButton *)button
{
    self.buttonOfLetterFilter.selected = YES;
    self.buttonOfNewRegisterFilter.selected = NO;
    
    self.baseTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.baseDataArray = self.dataModel.showLetterFilterdataArray;
    [self.baseTableView reloadData];
    
    
    
}
- (void)NewRegisterAction:(UIButton *)button
{
    [self.dataModel setTimeArraySorted];
    self.baseDataArray = self.dataModel.showSortTimeArray;
    
    self.buttonOfLetterFilter.selected = NO;
    self.buttonOfNewRegisterFilter.selected = YES;
    
    
    [self.baseTableView reloadData];
    
    
}

- (void)OtherFilterAction:(UIButton *)button
{
    
    self.rightVC.filterModel = [self.dataModel.fiterOtherModel modelCopy];
    
    self.rightVC.allRecoDic = self.dataModel.fiterOtherModel.allRecoDic;
    self.rightVC.allOrigDic = self.dataModel.fiterOtherModel.allOrigDic;
    
    [self.sliderVC showRightViewController];
}

- (void)headerGesAction:(UITapGestureRecognizer *)ges
{
    UIView *view = [ges view];
    
    if (self.headerActionBlock)
    {
        self.headerActionBlock(view.tag);
        return;
    }
    
    if (view.tag > 6)
    {
        [YFAppService showAlertMessage:@"即将上线，敬请期待"];
        return;
    }
    
    if (!AppGym.pro) {
        
        GymProHintView *hintView = [GymProHintView defaultView];
        
        hintView.title = self.tableHeadTitleArray[view.tag-1];
        
        hintView.delegate = self;
        
        hintView.canTry = !AppGym.haveTried;
        
        [hintView showInView:self.view];
        
        self.tempTap = ges;
        
        return;
        
    }
    
    if (view.tag == 1)
    {
        Gym *gym = self.gym;
        
        if ([PermissionInfo sharedInfo].permissions.userPermission.editState) {
            
            if (self.gym)
            {
                SellerListController *svc = [[SellerListController alloc]init];
                
                svc.gym = gym;
                
                AppGym = gym;
                
                [self.navigationController pushViewController:svc animated:YES];
            }else
            {
                SellerChooseGymController *svc = [[SellerChooseGymController alloc]init];
                
                [self.navigationController pushViewController:svc animated:YES];
            }
        }else{
            
            [self showNoPermissionAlert];
            
        }
        
        
        //        if (gym.permissions.userPermission.editState) {
        //
        //
        //
        //        }
        
    }else if (view.tag == 3)
    {
        UIViewController *followVC = [YFModuleManager studentFollowingWithGym:self.gym];
        
        [self.navigationController pushViewController:followVC animated:YES];
    }
    else if (view.tag == 4)
    {
        DebugLogParamYF(@"会员转化");
        [self studentTransListVC];
    }
    else if (view.tag == 5)
    {
        DebugLogParamYF(@"会员出勤");
        
        YFStudentOutVC *outVC = [[YFStudentOutVC alloc] init];
        outVC.gym = self.gym;
        [self.navigationController pushViewController:outVC animated:YES];
    }else if (view.tag == 6)
    {
        UIViewController *groupSmsVC = [YFModuleManager groupSmsViewControllerGym:self.gym];
        
        [self.navigationController pushViewController:groupSmsVC animated:YES];
    }else if (view.tag == 2)
    {
        Gym *gym = self.gym;
        
        if ([PermissionInfo sharedInfo].permissions.userPermission.editState) {
            
            if (self.gym)
            {
                CoachDistributeListController *svc = [[CoachDistributeListController alloc]init];
                
                svc.gym = gym;
                
                AppGym = gym;
                
                [self.navigationController pushViewController:svc animated:YES];
            }else
            {
                CoachChooseGymController *svc = [[CoachChooseGymController alloc]init];
                
                [self.navigationController pushViewController:svc animated:YES];
            }
        }else{
            
            [self showNoPermissionAlert];
            
        }
        
    }
    DebugLogYF(@"%@",@(view.tag));
}

#pragma mark -- Getter
- (UIView *)searchView
{
    if (_searchView == nil)
    {
        _searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, 64)];
        
        _searchView.backgroundColor = UIColorFromRGB(0x4e4e4e);
        
        _searchView.hidden = YES;
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
        [_searchBar addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
        
    }
    return _searchBar;
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
    
    
    [self setTableFootviewLabelNum:self.dataModel.allMemNum.integerValue];
    
    return _tableFootView;
}

- (void)setTableFootviewLabelNum:(NSInteger )count
{
    if (count > 0) {
        _tableFootLabel.text = [NSString stringWithFormat:@"%@名会员",@(count)];
        _tableFootView.hidden = NO;
    }else
    {
        _tableFootView.hidden = YES;
    }
}


- (UIView *)tableHeadView
{
    if (_tableHeadView == nil)
    {
        CGFloat height = XFrom5YF(160);
        
        NSUInteger count = self.dataArray.count;
        if (count)
        {
            NSUInteger coloumn ;
            if (count % 4 == 0) {
                coloumn = count/ 4;
            }else
            {
                coloumn = count/ 4 + 1;
            }
            height = XFrom5YF(75 * coloumn + 10);
        }else
        {
            height = XFrom5YF(160);
        }
        
        _tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MSW, height + self.conditionButtonViews.height)];
        _tableHeadView.backgroundColor = YFMainBackColor;
        
        self.proLabels = [NSMutableArray array];
        
        if (self.dataArray.count)
        {
            for (NSUInteger i = 0; i < self.dataArray.count; i ++)
            {
                NSDictionary *dic = self.dataArray[i];
                UIView *headView = [self headItemViewWithIndex:i dic:dic];
                [_tableHeadView addSubview:headView];
            }
        }else
        {
            for (NSUInteger i = 0; i < self.tableHeadTitleArray.count; i ++)
            {
                UIView *headView = [self headItemViewWithIndex:i dic:nil];
                
                [_tableHeadView addSubview:headView];
            }
        }
        
        self.conditionButtonViews.frame = CGRectMake(0, _tableHeadView.bottom - self.conditionButtonViews.height, self.conditionButtonViews.width, self.conditionButtonViews.height);
        [_tableHeadView addSubview:self.conditionButtonViews];
    }
    return _tableHeadView;
}

-(NSMutableArray *)tableHeadTitleArray
{
    if (_tableHeadTitleArray == nil)
    {
        _tableHeadTitleArray = [NSMutableArray arrayWithObjects:@"销售分配",@"教练分配",@"会员跟进",@"会员转化",@"会员出勤",@"群发短信",@"生日提醒",@"VIP会员", nil];
    }
    return _tableHeadTitleArray;
}

- (UIView *)headItemViewWithIndex:(NSUInteger )index dic:(NSDictionary *)dic
{
    
    NSString *imageName = dic[@"imageName"];
    NSString *title = dic[@"title"];
    NSString *isCanEnble = dic[@"isCanEnble"];
    
    CGFloat width = MSW / 4.0;
    CGFloat height = XFrom5YF(73);
    CGFloat x = width * (index % 4);
    CGFloat y = height * (index / 4);
    
    UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    itemView.tag = index + 1;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerGesAction:)];
    itemView.userInteractionEnabled = YES;
    [itemView addGestureRecognizer:ges];
    CGFloat imageWidth = XFrom5YF(40.0);
    CGFloat imageHeight = imageWidth;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((width - imageWidth)/2.0, XFrom5YF(12.0), imageWidth, imageHeight)];
    
    imageView.userInteractionEnabled = NO;
    [itemView addSubview:imageView];
    
    if (!AppGym.pro) {
        
        UILabel *proLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right-Width320(12), imageView.top, Width320(20), Height320(12))];
        
        proLabel.backgroundColor = kMainColor;
        
        proLabel.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
        
        proLabel.layer.borderWidth = OnePX;
        
        proLabel.layer.cornerRadius = proLabel.height/2;
        
        proLabel.layer.masksToBounds = YES;
        
        proLabel.text = @"PRO";
        
        proLabel.textColor = UIColorFromRGB(0xffffff);
        
        proLabel.textAlignment = NSTextAlignmentCenter;
        
        proLabel.font = AllFont(7);
        
        [itemView addSubview:proLabel];
        
        [self.proLabels addObject:proLabel];
        
    }
    
    CGFloat labelWidth = XFrom5YF(58.0);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((width - labelWidth)/2.0, imageView.bottom + Height320(3.0), labelWidth, height - imageView.bottom)];
    label.backgroundColor = YFMainBackColor;
    label.userInteractionEnabled = NO;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = AllFont(13);
    label.textColor = RGB_YF(51, 51, 51);
    [itemView addSubview:label];
    
    if (imageName)
    {
        imageView.image = [UIImage imageNamed:imageName];
        [label setText:title];
        if (isCanEnble.integerValue == 0)
        {
            itemView.alpha = 0.5;
        }else
        {
            itemView.alpha = 1.0;
        }
    }else
    {
        if (index > 5) {
            itemView.alpha = 0.5;
        }
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"member_followHead%@",@(index + 1)]];
        
        if (self.tableHeadTitleArray.count > index) {
            [label setText:self.tableHeadTitleArray[index]];
        }
        
    }
    
    return itemView;
}

-(UIView *)conditionButtonViews
{
    if (_conditionButtonViews == nil)
    {
        _conditionButtonViews = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MSW, XFrom5YF(41))];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _conditionButtonViews.frame.size.width, 0.5)];
        lineView.backgroundColor = YFLineViewColor;
        [_conditionButtonViews addSubview:lineView];
        
        lineView = [[UIView alloc] init];
        lineView.backgroundColor = YFLineViewColor;
        [_conditionButtonViews addSubview:lineView];
        [lineView setBottomLine];
        _conditionButtonViews.backgroundColor = YFMainBackColor;
        
        CGFloat buttonWidth = MSW / 3.0;
        
        CGFloat labelWidth = XFrom5YF(53.0);
        CGFloat labelHeight = _conditionButtonViews.height;
        
        CGFloat imageWidth = XFrom5YF(10.0);
        CGFloat imageHeight = XFrom5YF(9.0);
        
        CGFloat labelx = (buttonWidth - labelWidth - imageWidth)/ 2.0;
        CGFloat labely = 0;
        
        CGFloat imagex = (buttonWidth - labelWidth - imageWidth)/ 2.0 + labelWidth;
        CGFloat imagey = (_conditionButtonViews.height - imageHeight)/ 2.0;
        
        NSArray *titleArray = @[@"字母排序",@"最新注册",@"筛选"];
        
        for (NSInteger i = 0; i < 3; i ++)
        {
            
            if (i == 2)
            {
                labelWidth = XFrom5YF(32.0);
                labelHeight = _conditionButtonViews.height;
                
                imageWidth = XFrom5YF(11.0);
                imageHeight = XFrom5YF(10.0);
                
                labelx = (buttonWidth - labelWidth - imageWidth)/ 2.0;
                labely = 0;
                
                imagex = (buttonWidth - labelWidth - imageWidth)/ 2.0 + labelWidth;
                imagey = (_conditionButtonViews.height - imageHeight)/ 2.0;
            }
            
            YFButton *button = [[YFButton alloc] initWithFrame:CGRectMake(buttonWidth * i, 0, buttonWidth, _conditionButtonViews.height) imageFrame:CGRectMake(imagex, imagey, imageWidth, imageHeight) titleFrame:CGRectMake(labelx, labely, labelWidth, labelHeight)];
            
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
            
            [button setTitleColor:RGB_YF(51, 51, 51) forState:UIControlStateNormal];
            [button setTitleColor:RGB_YF(24, 181, 83) forState:UIControlStateSelected];
            
            [button.titleLabel setFont:[UIFont systemFontOfSize:XFrom5YF(12.0)]];
            
            if (i < 2)
            {
                [button setImage:[UIImage imageNamed:@"Shape"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"ShapeGreen"] forState:UIControlStateSelected];
            }
            else
            {
                [button setImage:[UIImage imageNamed:@"TriangleFilter"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"TriangleFilterGreen"] forState:UIControlStateSelected];
            }
            if (i == 0)
            {
                self.buttonOfLetterFilter = button;
                [button addTarget:self action:@selector(letterFilterAction:) forControlEvents:UIControlEventTouchUpInside];
            }else if (i == 1)
            {
                self.buttonOfNewRegisterFilter = button;
                [button addTarget:self action:@selector(NewRegisterAction:) forControlEvents:UIControlEventTouchUpInside];
                
            }else if (i == 2)
            {
                self.buttonOfOtherFilter = button;
                [button addTarget:self action:@selector(OtherFilterAction:) forControlEvents:UIControlEventTouchUpInside];
                
            }
            
            [_conditionButtonViews addSubview:button];
        }
        
        CGFloat lineWidht = 0.5;
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(buttonWidth - lineWidht, XFrom5YF(12), 0.5, XFrom5YF(16.0))];
        lineView1.backgroundColor = YFLineViewColor;
        [_conditionButtonViews addSubview:lineView1];
        
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(buttonWidth * 2 - lineWidht, XFrom5YF(12), 0.5, XFrom5YF(16.0))];
        lineView2.backgroundColor = YFLineViewColor;
        [_conditionButtonViews addSubview:lineView2];
        
    }
    return _conditionButtonViews;
}

- (YFStudentListDataModel *)dataModel
{
    if (!_dataModel)
    {
        _dataModel = [[YFStudentListDataModel alloc] init];
    }
    return _dataModel;
}

-(void (^)())sureBlock
{
    if (!_sureBlock) {
        weakTypesYF
        [self setSureBlock:^{
            [weakS sureToFilterOtherAction];
        }];
    }
    return _sureBlock;
}

-(void)sureToFilterOtherAction
{
    // 请求成功 后 = self.dataModel.fiterOtherModel
    _temFilterModel = [self.rightVC.filterModel modelCopy];
    _temFilterModel.allOrigDic = [NSMutableDictionary dictionaryWithDictionary:[self.rightVC.filterModel allOrigDic]];
    _temFilterModel.allRecoDic = [NSMutableDictionary dictionaryWithDictionary:[self.rightVC.filterModel allRecoDic]];;
    
    
    [self.sliderVC closeSideBar];
    
    self.buttonOfOtherFilter.selected = !self.rightVC.filterModel.isEmptyYF;
    
    [self refreshTableListDataNoPull];
    
}

#pragma mark  代理Model 的设置
-(YFTBBaseDatasource *)dataSourceTBYF
{
    weakTypesYF
    //    return [YFTBStudentTBDatasource tableDelegeteWithArray:^NSMutableArray *{
    //        return weakS.baseDataArray;
    //    }  currentVC:self];
    
    
    return   [YFTBStudentTBDatasource tableDelegeteWithArray:^NSMutableArray *{
        return weakS.baseDataArray;
        
    } allKeyArray:^NSArray *{
        if (weakS.buttonOfLetterFilter.selected)
        {
            return weakS.dataModel.showLetterKeys;
        }else
        {
            return  @[];
        }
        
    } currentVC:self];
}

-(YFTBStudentTBDelegate *)delegateTBYF
{
    weakTypesYF
    YFTBStudentTBDelegate *delegaetYFTB = [YFTBStudentTBDelegate tableDelegeteWithArray:^NSMutableArray *{
        return weakS.baseDataArray;
        
    } currentVC:self];
    
    delegaetYFTB.header = self.tableHeadView;
    delegaetYFTB.needToTopView = self.conditionButtonViews;
    delegaetYFTB.superViewOfNeedToTopView = self.view;
    return delegaetYFTB;
}

-(void)showFailViewOnSuperView:(UIView *)superView
{
    [super showFailViewOnSuperView:superView];
    
    self.failViewYF.frame = CGRectMake(0, self.tableHeadView.height, self.baseTableView.width, self.baseTableView.height - self.tableHeadView.height);
}

- (UIView *)emptyView
{
    if (!_emptyViewYF)
    {
        _emptyViewYF = [[YFEmptyView alloc] initWithFrame:CGRectMake(0, self.tableHeadView.height, self.baseTableView.width, self.baseTableView.height - self.tableHeadView.height)];
        
        [_emptyViewYF.addbutton addTarget:self action:@selector(addStudentAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    if (self.searchBar.text.length) {
        
        _emptyViewYF.emptyLabel.text = @"没有找到相关会员\n你可以添加该会员";
        
        _emptyViewYF.emptyImg.hidden = YES;
        
        _emptyViewYF.addbutton.hidden = NO;
        
        [_emptyViewYF.emptyLabel changeTop:Height320(40)];
        
        [_emptyViewYF.addbutton changeTop:_emptyViewYF.emptyLabel.bottom+Height320(27)];
        
    }else
    {
        
        _emptyViewYF.emptyLabel.text = @"暂无会员";
        
        _emptyViewYF.emptyImg.hidden = NO;
        
        _emptyViewYF.addbutton.hidden = YES;
        
        [_emptyViewYF.emptyLabel changeTop:_emptyViewYF.emptyImg.bottom+Height320(19.5)];
        
        [_emptyViewYF.addbutton changeTop:_emptyViewYF.emptyLabel.bottom+Height320(19.5)];
        
    }
    
    
    return _emptyViewYF;
}

- (void)emptyDataReminderAction
{
    [self.baseTableView addSubview:self.emptyView];
}

- (void)addStudentAction:(UIButton *)button
{
    if (AppGym) {
        
        if ([PermissionInfo sharedInfo].permissions.userPermission.addState || [PermissionInfo sharedInfo].permissions.personalUserPermission.addState) {
            
            StudentEditController *svc = [[StudentEditController alloc]init];
            
            svc.isAdd = YES;
            
            svc.gym = self.gym;
            
            svc.gym.permissions = [PermissionInfo sharedInfo].gym.permissions;
            
            __weak typeof(self)weakS = self;
            
            svc.addFinish = ^{
                [weakS refreshTableListDataNoPull];
                [weakS.navigationController popToViewController:self.parentViewController animated:YES];
            };
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [self showNoPermissionAlert];
            
        }
        
    }else{
        
        if ([PermissionInfo sharedInfo].permissions.userPermission.addState || [PermissionInfo sharedInfo].permissions.personalUserPermission.addState) {
            
            NSArray *userGyms = [[PermissionInfo sharedInfo]getHaveAddPermissionGymsWithPermission:[Permission userPermission]];
            
            NSArray *personalUserGyms = [[PermissionInfo sharedInfo]getHaveAddPermissionGymsWithPermission:[Permission personalUserPermission]];
            
            NSMutableArray *gyms = [userGyms mutableCopy];
            
            for (Gym *tempGym in personalUserGyms) {
                
                BOOL contains = NO;
                
                for (Gym *tempUserGym in gyms) {
                    
                    if (tempUserGym.shopId == tempGym.shopId) {
                        
                        contains = YES;
                        
                        break;
                        
                    }
                    
                }
                
                if (!contains) {
                    
                    [gyms addObject:tempGym];
                    
                }
                
            }
            
            if (gyms.count == 1) {
                
                Gym *gym = [gyms firstObject];
                
                GymListInfo *info = [GymListInfo shareInfo];
                
                [info requestResult:^(BOOL success, NSString *error) {
                    
                    for (Gym *tempGym in info.gyms) {
                        
                        if (tempGym.gymId == gym.gymId ||(tempGym.shopId == gym.shopId && tempGym.brand.brandId == gym.brand.brandId)) {
                            
                            gym.name = tempGym.name;
                            
                            break;
                            
                        }
                        
                    }
                    
                    StudentEditController *svc = [[StudentEditController alloc]init];
                    
                    svc.isAdd = YES;
                    
                    svc.gym = gym;
                    
                    __weak typeof(self)weakS = self;
                    
                    svc.addFinish = ^{
                        
                        [weakS refreshTableListDataNoPull];
                        [weakS.navigationController popToViewController:self.parentViewController animated:YES];
                    };
                    
                    [[PermissionInfo sharedInfo]requestWithGym:gym result:^(BOOL success, NSString *error) {
                        
                        svc.gym.permissions = [PermissionInfo sharedInfo].gym.permissions;
                        
                        [self.navigationController pushViewController:svc animated:YES];
                        
                    }];
                    
                }];
                
            }else if (gyms.count) {
                
                StudentChooseGymController *svc = [[StudentChooseGymController alloc]init];
                
                [self.navigationController pushViewController:svc animated:YES];
                
            }
            
        }else{
            
            [self showNoPermissionAlert];
            
        }
        
    }
    
}

- (YFFilterOtherModel *)temFilterModel
{
    if (!_temFilterModel)
    {
        _temFilterModel = [[YFFilterOtherModel alloc] init];
    }
    return _temFilterModel;
}

- (YFSearchResultStuListVC *)searchResultVC
{
    if (!_searchResultVC)
    {
        _searchResultVC = [[YFSearchResultStuListVC alloc] init];
        
        _searchResultVC.gym = self.gym;
        
        [self addChildViewController:_searchResultVC];
        
        _searchResultVC.view.frame = self.view.bounds;
        [self.view addSubview:_searchResultVC.view];
        [_searchResultVC hideSearchView];
        _searchResultVC.parentVCYF = self;
    }
    return _searchResultVC;
}

-(void)trySuccessAlertStart
{
    
    [self headerGesAction:self.tempTap];
    
    self.tempTap = nil;
    
}
// 每次下拉 刷新页面，清除缓存，请求数据, 否则 在 网页端 添加的会员会请求不到
- (void)pullToRefreshTableView
{
    [YFListCache removeCacheOnDocumentStudentArrayFromKey:YFCacheKey];
    [super pullToRefreshTableView];
}

// 会员 转化
- (void)studentTransListVC
{
    NSString *sellerStr;
    
    if ([PermissionInfo sharedInfo].permissions.userPermission.readState == PermissionStateNone) {
        
        if ([YFHttpService sharedInstance].info.staff.name)
        {
            sellerStr =[YFHttpService sharedInstance].info.staff.name;
        }else
        {
            weakTypesYF
            [YFHttpService getUseNameComplete:^{
                [weakS studentTransListVC];
            }];
            return;
        }
        
    }
    
    
    YFStudentStateDetailVC *stateVC = [[YFStudentStateDetailVC alloc] init];
    
    stateVC.isTransPersent = YES;
    
    stateVC.title = @"会员转化";
    
    if (sellerStr.length == 0)
    {
        sellerStr = @"销售";
    }
    
    stateVC.buttonTitlesArray = @[sellerStr,@"最近7天"];
    
    stateVC.classsArray = @[[YFConditionSellerPopView class],[YFConditionTimeNoTodayNOMaxCountPopView class]];
    
    [self.navigationController pushViewController:stateVC animated:YES];
}

@end

