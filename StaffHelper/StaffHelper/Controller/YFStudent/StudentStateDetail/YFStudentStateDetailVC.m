//
//  YFStudentStateDetailVC.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentStateDetailVC.h"

#import "GTWSelectOperationView.h"
#import "Masonry.h"

#import "YFStudentStateDataModel.h"
#import "YFConditionPopView.h"

#import "YFSearchResultStudentStateVC.h"
#import "YFEmptyView.h"

#import "YFTBSectionsDataSource.h"


#import "YFTBSectionsTitleModel.h"

#import "YFTBSectionsLineEdgeDelegate.h"

#import "YFFolloSubUpCModel.h"

#import "YFGrayCellModel.h"

@interface YFStudentStateDetailVC ()<UITextFieldDelegate,GTWSelectOperationViewDelegate>

@property(nonatomic,strong)YFTBSectionsTitleModel *secionomodel1;
@property(nonatomic,strong)YFTBSectionsTitleModel *secionomodel2;

@property (nonatomic,strong) GTWSelectOperationView *operationView;

@property(nonatomic, strong)YFFolloSubUpCModel *subUpCModel;

@property(nonatomic,strong)YFStudentStateDataModel *dataModel;

@property(nonatomic, strong)NSMutableArray *popViewsArray;

@property(nonatomic, strong)YFConditionPopView *showPopView;

// 搜索 VC
@property(nonatomic, strong)YFSearchResultStudentStateVC *searchResultVC;

@property(nonatomic, strong)UIView *tableFootView;
@property(nonatomic, strong)UILabel *tableFootLabel;

@property(nonatomic, strong)UIView *tableFootViewTwo;
@property(nonatomic, strong)UILabel *tableFootLabelTwo;

// 如果是 刷新 两部分数据， 不 设置 basetableview的 offset，只刷新 列表数据，需要设置 offset
@property(nonatomic, assign)BOOL isRefreshTwoData;


@end

@implementation YFStudentStateDetailVC
{
    YFEmptyView *_emptyViewYF;
}
-(instancetype)init
{
    self = [super init];
    if (self)
    {
     _isCanSearch = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableListDataNoPull) name:kPostModifyOrAddStudentIdtifierYF object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableListDataNoPull) name:kPostAddNewSellerIdtifierYF object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableListDataNoPull) name:kPostAddNewMemberIdtifierYF object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableListDataNoPull) name:kPostAddNewFollowingIdtifierYF object:nil];

    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.isCanSearch  && !self.isTransPersent)
    {
        self.rightType = MONaviRightTypeSearch;
    }
    self.canGetMore = NO;
    
    [self operationView];
    
    for (Class popClass in self.classsArray)
    {
        YFConditionPopView *popView = [[popClass alloc] initWithFrame:self.baseTableView.frame superView:self.view];
        popView.title = self.title;
        weakTypesYF
        
        [popView setSelectBlock:^(NSString *value, NSDictionary *param) {
            
            [weakS.fiterOtherModelCaYF getParamWithDic:[weakS getParamWithExtraParam]];

            [weakS selectParam:nil param:nil];
            if (weakS.isTransPersent)
            {
                [weakS refreshTableListDataNoPull];
            }else
            {
            [weakS onlyRefreshStudentData];
            }
        }];
        __weak typeof(popView)weakPop = popView;

        [popView setCancelBlock:^(id model) {
            NSInteger index = [weakS.popViewsArray indexOfObject:weakPop];
            
            UIButton *button = [weakS.operationView buttonWithIndex:index];
            button.selected = NO;
        }];

        
        popView.gym = self.gym;
        [self.popViewsArray addObject:popView];
    }
    [self setRefreshHeadViewYF];
    [self.baseDataArray addObject:self.secionomodel1];
    [self.baseDataArray addObject:self.secionomodel2];
    // 刷新初始化数据
    
    [self.fiterOtherModelCaYF getParamWithDic:[self getParamWithExtraParam]];
    [self selectParam:nil param:nil];

    
    [self refreshTableListDataNoPull];
}


- (NSDictionary *)getParamWithExtraParam
{
    NSMutableDictionary *allParam = [NSMutableDictionary dictionary];
    
    for (NSUInteger i = 0; i < self.popViewsArray.count; i ++)
    {
        YFConditionPopView *popView = self.popViewsArray[i];
        if (popView.conditionsParam.count) {
            if (popView.isValidParam)
            {
                [allParam setValuesForKeysWithDictionary:popView.conditionsParam];
            }
            
        }
    }
    return allParam;
}

- (void)selectParam:(NSString *)value param:(NSDictionary *)param
{
    [self.showPopView hide];
    
    NSMutableDictionary *allParam = [NSMutableDictionary dictionary];
    
    for (NSUInteger i = 0; i < self.popViewsArray.count; i ++)
    {
        YFConditionPopView *popView = self.popViewsArray[i];
        if (popView.param.count) {
            if (popView.isValidParam)
            {
            [allParam setValuesForKeysWithDictionary:popView.param];
            }
            [self.operationView setSelectButtonWithIndex:i];
        }
        else
        {
            [self.operationView setUnSelectButtonWithIndex:i];
        }
        if ([popView isEqual:self.showPopView])
        {
            [self.operationView setSelectButtonTitleWithIndex:i suitFrametitle:self.showPopView.value maxWidth:(MSW / self.buttonTitlesArray.count - 10)];
        }
    }
    
    for (YFConditionPopView *popView in self.popViewsArray) {
        [popView afterSetAllConditionsParam:allParam];
    }
    
    [self.operationView setUnselectButtonFY];
    self.dataModel.allConditionParam = allParam;
    
}

- (void)onlyRefreshStudentData
{
    if (self.canNoPullRefresh == NO)
    {
        return;
    }
    self.canNoPullRefresh = NO;
    self.isReFreshing = YES;
    [self showLoadingViewWithMessage:@"加载中"];
    
    [self clearAllRemindView];
    
    self.lastRequestPage = self.dataPage;
    
    self.dataPage = self.firstPage;
    
    [self requestStudnetSData];

}

-(void)requestData
{
    
    if (self.isTransPersent)
    {
        self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        weakTypesYF
        [self.dataModel getResponseTransPersentsDatashowLoadingOn:nil gym:self.gym successBlock:^{
            [weakS requestSuccessArray:weakS.dataModel.showDataArray toDataArray:weakS.secionomodel1.dataArray];
            
            [weakS.secionomodel2 setSectionTitle:[NSString stringWithFormat:@"%@至%@注册的会员",weakS.dataModel.tranSperModel.start,weakS.dataModel.tranSperModel.end]];
            
            [weakS requestSuccessArray:weakS.dataModel.showStudentDataForTransArray toDataArray:weakS.secionomodel2.dataArray];
            
            if (weakS.dataModel.dataMOdel.pages.integerValue <= weakS.dataPage)
            {
                weakS.baseTableView.mj_footer = nil;
            }

        } failBlock:^{
            [weakS failRequest:nil];
        }];
        return;
    }
    self.isRefreshTwoData = YES;
    [self requestStaticData];
    [self requestStudnetSData];
}

-  (void)requestStaticData
{
    weakTypesYF
    self.dataModel.allConditionParamForStatic = self.subUpCModel.allConditionParam;
    [self.dataModel getResponseDataStaticshowLoadingOn:nil gym:self.gym successBlock:^{
        
        if (weakS.subUpCModel)// opeationView 代理只能设置一次
        {
            weakS.subUpCModel.staticsModel = weakS.dataModel.subUpCModel.staticsModel;
        }else
        {
        weakS.subUpCModel = weakS.dataModel.subUpCModel;
        }
        
        [weakS.secionomodel1.dataArray removeAllObjects];
        
        [weakS.subUpCModel setRefreshStaticBlock:^{
            [weakS requestStaticData];
        }];
        
        [weakS.secionomodel1.dataArray addObject:weakS.subUpCModel];
        [weakS.secionomodel1.dataArray addObject:[YFGrayCellModel defaultWithCellHeght:16]];
        [weakS.baseTableView reloadData];
        [weakS emptyView];
    } failBlock:^{
        [weakS failRequest:nil];
    }];

}

- (void)requestStudnetSData
{
    weakTypesYF
    self.dataModel.page = self.dataPage;
    
    [self.fiterOtherModelCaYF paramWithSingleDictionary:self.dataModel.allConditionParam];
    
    [self.dataModel getResponseDatashowLoadingOn:nil gym:self.gym successBlock:^{
        
        [weakS requestSuccessArray:weakS.dataModel.showDataArray toDataArray:weakS.secionomodel2.dataArray];
        [weakS setTableFootviewLabelNum:weakS.dataModel.allMemNum.integerValue];
        
        CGFloat cellHeith;
        
        if (weakS.status.integerValue > 0)
        {
            cellHeith  = 148;
        }else
        {
            cellHeith  = 188;
        }
        
        CGFloat sectionHeight = weakS.secionomodel2.dataArray.count * cellHeith + weakS.operationView.height - 16;
        
        CGFloat shouldHeight = MSH - 64 - weakS.operationView.height;
        
        if (sectionHeight < shouldHeight)
        {
            weakS.baseTableView.mj_insetB = shouldHeight - sectionHeight;
        }
        else
        {
            weakS.baseTableView.mj_insetB = 0;
        }
        if (weakS.isRefreshTwoData == NO)
        {
        [weakS.baseTableView setContentOffset:CGPointMake(0, weakS.subUpCModel.cellHeight + 16) animated:NO];
        }
        
        if (weakS.dataModel.dataMOdel.pages.integerValue <= weakS.dataPage)
        {
            weakS.baseTableView.mj_footer = nil;
        }
        weakS.isRefreshTwoData = NO;
    } failBlock:^{
        [weakS failRequest:nil];
        weakS.isRefreshTwoData = NO;
    }];

}


#pragma mark -- Action Event
- (void)naviRightClick
{
    self.searchResultVC.dataArrayFromFilterData = self.secionomodel2.dataArray;
    
    [self.searchResultVC showSearchView];

}

- (void)naviLeftClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (GTWSelectOperationView *)operationView
{
    if (!_operationView)
    {
//        _operationView = [[GTWSelectOperationView alloc]initWithDataSourceFY:self.buttonTitlesArray sepImage:@"fadeline" delegate:self font:[UIFont systemFontOfSize:IPhone4_5_6_6PYF(13, 13, 14, 14)]];
        
        _operationView = [[GTWSelectOperationView alloc]initWithDataSourceFY:self.buttonTitlesArray sepImageArray:self.nomalUpImageArray downImageArray:self.nomalDownImageArray delegate:self font:[UIFont systemFontOfSize:IPhone4_5_6_6PYF(13, 13, 14, 14)]];

        _operationView.upSeleImageArray = self.selectUpImageArray;
//        _operationView.downSeleImageArray = self.selectDownImageArray;
        _operationView.backgroundColor = [UIColor whiteColor];
        
        _operationView.delegate = self;

        _operationView.frame = CGRectMake(0, 0, self.view.width, GTWSelectOperationViewHeight);

    }
    return _operationView;
}

#pragma mark -- Getter

- (NSMutableArray *)nomalDownImageArray
{
    if (!_nomalDownImageArray)
    {
        _nomalDownImageArray = [NSMutableArray arrayWithObjects:@"buttonUnSelectedDown",@"buttonUnSelectedDown",@"buttonUnSelectedDown",@"buttonUnSelectedDown", nil];
    }
    return _nomalDownImageArray;
}

- (NSMutableArray *)nomalUpImageArray
{
    if (!_nomalUpImageArray)
    {
        _nomalUpImageArray = [NSMutableArray arrayWithObjects:@"buttonUnSelectedUp",@"buttonUnSelectedUp",@"buttonUnSelectedUp",@"buttonUnSelectedUp", nil];
    }
    return _nomalUpImageArray;
}

- (NSMutableArray *)selectDownImageArray
{
    if (!_selectDownImageArray)
    {
        _selectDownImageArray = [NSMutableArray arrayWithObjects:@"buttonSelectedDown",@"buttonSelectedDown",@"buttonSelectedDown",@"buttonSelectedDown", nil];
    }
    return _selectDownImageArray;
}

- (NSMutableArray *)selectUpImageArray
{
    if (!_selectUpImageArray)
    {
        _selectUpImageArray = [NSMutableArray arrayWithObjects:@"buttonSelectedUp",@"buttonSelectedUp",@"buttonSelectedUp",@"buttonSelectedUp", nil];
    }
    return _selectUpImageArray;
}



-(YFStudentStateDataModel *)dataModel
{
    if (!_dataModel)
    {
        _dataModel = [[YFStudentStateDataModel alloc] init];
    }
    _dataModel.status = self.status;
    return _dataModel;
}

- (NSMutableArray *)popViewsArray
{
    if (!_popViewsArray)
    {
      _popViewsArray = [[NSMutableArray alloc] init];
    }
    return _popViewsArray;
}

- (void)setShowPopView:(YFConditionPopView *)showPopView
{
    if (_showPopView && [showPopView isEqual:_showPopView] == NO) {
        [_showPopView hideAnimate:NO];
    }
    _showPopView = showPopView;
}

-(void)setBaseDataArray:(NSMutableArray *)baseDataArray
{
    [super setBaseDataArray:baseDataArray];
    
    if (self.baseDataArray.count == 0)
    {
        [self.baseTableView addSubview:self.emptyView];
    }else
    {
        [self.emptyView removeFromSuperview];
    }
    
}



- (YFSearchResultStudentStateVC *)searchResultVC
{
    if (!_searchResultVC)
    {
        _searchResultVC = [[YFSearchResultStudentStateVC alloc] init];
        
        _searchResultVC.gym = self.gym;
        
        [self addChildViewController:_searchResultVC];
        
        _searchResultVC.view.frame = self.view.bounds;
        [self.view addSubview:_searchResultVC.view];
        [_searchResultVC hideSearchView];
        _searchResultVC.parentVCYF = self;
        
        _searchResultVC.status =self.status;
    }
    return _searchResultVC;
}


-(UIView *)tableFootViewTwo
{
    if (!_tableFootViewTwo)
    {
        _tableFootViewTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MSW, 44)];
        
        _tableFootViewTwo.backgroundColor = YFGrayViewColor;
        CGFloat labelWidth = 70;
        _tableFootLabelTwo = [[UILabel alloc] initWithFrame:CGRectMake((_tableFootViewTwo.width - labelWidth) / 2.0, 0, labelWidth, 44)];
        _tableFootLabelTwo.backgroundColor = [UIColor clearColor];
        _tableFootLabelTwo.textColor = RGB_YF(153, 153, 153);
        _tableFootLabelTwo.font = FontSizeFY(12.0);
        _tableFootLabelTwo.textAlignment = NSTextAlignmentCenter;
        [_tableFootViewTwo addSubview:_tableFootLabelTwo];
        
                CGFloat lineViewWidth = 0.25 * _tableFootViewTwo.width;;
                CGFloat lineViewxx1 = _tableFootLabelTwo.left - lineViewWidth - 10;
                CGFloat lineViewxx2 = _tableFootLabelTwo.right + 10;
        
                UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(lineViewxx1, 44 / 2.0, lineViewWidth, 0.5)];
                lineView1.backgroundColor = YFLineViewColor;
                [_tableFootViewTwo addSubview:lineView1];
        
                UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(lineViewxx2, lineView1.top, lineViewWidth, 0.5)];
                lineView2.backgroundColor = YFLineViewColor;
                [_tableFootViewTwo addSubview:lineView2];
        
    }
    return _tableFootViewTwo;
}

-(UIView *)tableFootView
{
    if (!_tableFootView)
    {
        _tableFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MSW, 44)];
//        _tableFootView.backgroundColor = YFGrayViewColor;
        _tableFootView.backgroundColor = [UIColor whiteColor];
        CGFloat labelWidth = 200;
        _tableFootLabel = [[UILabel alloc] initWithFrame:CGRectMake((_tableFootView.width - labelWidth) / 2.0, 0, labelWidth, 44)];
        _tableFootLabel.backgroundColor = [UIColor whiteColor];
        _tableFootLabel.textColor = RGB_YF(153, 153, 153);
        _tableFootLabel.font = FontSizeFY(12.0);
        _tableFootLabel.textAlignment = NSTextAlignmentCenter;
        [_tableFootView addSubview:_tableFootLabel];
        
//        CGFloat lineViewWidth = 0.25 * _tableFootView.width;;
//        CGFloat lineViewxx1 = _tableFootLabel.left - lineViewWidth - 10;
//        CGFloat lineViewxx2 = _tableFootLabel.right + 10;
//        
//        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(lineViewxx1, _tableFootView.height / 2.0, lineViewWidth, 0.5)];
//        lineView1.backgroundColor = YFLineViewColor;
//        [_tableFootView addSubview:lineView1];
//        
//        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(lineViewxx2, _tableFootView.center.y, lineViewWidth, 0.5)];
//        lineView2.backgroundColor = YFLineViewColor;
//        [_tableFootView addSubview:lineView2];
        
    }
    return _tableFootView;
}

- (void)setTableFootviewLabelNum:(NSInteger )count
{
    if (count > 0) {
        self.tableFootViewTwo.hidden = NO;
        _tableFootLabelTwo.text = [NSString stringWithFormat:@"%@名会员",@(count)];
        [self.baseTableView setTableFooterView:self.tableFootViewTwo];
        
        self.baseTableView.backgroundColor = self.tableFootViewTwo.backgroundColor;
    }else
    {
        NSString *str = [NSString stringWithFormat:@"今日暂无%@",_emptyStr];
        if (_emptyStr.length == 0)
        {
            str = @"0位会员";
        }

        self.tableFootView.hidden = NO;
        _tableFootLabel.text = str;

        [self.baseTableView setTableFooterView:self.tableFootView];
        self.baseTableView.backgroundColor = self.tableFootView.backgroundColor;
    }
}


-(void)emptyDataReminderAction
{
    if (self.isTransPersent) {
        return;
    }
    if ([self.operationView checkIsHaveSelect])
    {
     [self.baseTableView addSubview:self.emptyView];
    }else
    {
     [self.emptyView removeFromSuperview];
    }
}


- (UIView *)emptyView
{
    if (!_emptyViewYF)
    {
        _emptyViewYF = [[YFEmptyView alloc] initWithFrame:CGRectMake(0, 0, self.baseTableView.width, self.baseTableView.height)];
        
        CGFloat emptyImageWidht = Width320(80);
        
        CGFloat emptyImageYY = Width320(83);
        
        CGFloat emptyImageXX = (_emptyViewYF.width - emptyImageWidht )/ 2.0;
        
        _emptyViewYF.emptyImg.frame = CGRectMake(emptyImageXX, emptyImageYY, emptyImageWidht, emptyImageWidht);
        
        _emptyViewYF.backgroundColor = [UIColor whiteColor];
        
        _emptyViewYF.emptyImg.image = [UIImage imageNamed:@"filterStudentEmpty"];
        
        _emptyViewYF.emptyLabel.text = @"筛选结果为空";
        
        _emptyViewYF.emptyLabel.textColor = YFCellTitleColor;
        
        _emptyViewYF.emptyLabel.font = AllFont(14);

        
        _emptyViewYF.emptyLabel.frame = CGRectMake(_emptyViewYF.emptyLabel.mj_x, _emptyViewYF.emptyImg.bottom + Height320(3.5), _emptyViewYF.emptyLabel.width, _emptyViewYF.emptyLabel.height);
        
         _emptyViewYF.addbutton.hidden = YES;
        
        
        UILabel *emptyMessageLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, _emptyViewYF.emptyLabel.bottom - Height320(4), MSW-40, Height320(13))];
        
        emptyMessageLabel.numberOfLines = 0;
        
        emptyMessageLabel.textColor = RGB_YF(153, 153, 153);
        
        emptyMessageLabel.font = AllFont(12);
        
        emptyMessageLabel.textAlignment = NSTextAlignmentCenter;
        
        emptyMessageLabel.text = @"没有找到符合条件的会员";
        
        [_emptyViewYF addSubview:emptyMessageLabel];
        
    }
    
    if (!self.isTransPersent)
    {
        CGFloat yyPop = self.subUpCModel.cellHeight + 16 + self.operationView.height;

        _emptyViewYF.frame = CGRectMake(0, yyPop, self.baseTableView.width, self.baseTableView.height - yyPop);
    }
    
    
    return _emptyViewYF;
}






#pragma mark Delegate
- (void)operationViewDidSelectedIndex:(NSInteger)index selectedState:(BOOL)selectedState button:(UIButton *)button
{
    if (self.popViewsArray.count > index) {
        self.showPopView = self.popViewsArray[index];
        
        if (self.isTransPersent == NO)
        {
            [self.baseTableView setContentOffset:CGPointMake(0, self.subUpCModel.cellHeight + 16) animated:YES];
        }
    }
    else
    {
        if (self.clickWithIndex)
        {
            self.clickWithIndex(index);
        }
        self.showPopView = nil;
    }
    if (self.showPopView.isCanShow == NO)
    {
        [self.operationView setUnselectButtonFY];
    }
    
    
//    CGFloat yyPop = self.subUpCModel.cellHeight + 16;
    
//    if (self.isTransPersent)
//    {
//        yyPop -= 16;
//    }
//    
//    if (self.secionomodel1.dataArray.count == 0)
//    {
//        yyPop = 0;
//    }
//    
//    if (self.baseTableView.contentOffset.y >= yyPop) {
//        
//        yyPop =  self.operationView.height;
//    }
//    else
//    {
//        yyPop = yyPop + self.operationView.height - self.baseTableView.contentOffset.y;
//    }
   

    CGFloat yyPop = self.operationView.height;
    
    self.showPopView.originFrame = CGRectMake(0, yyPop, self.view.width, MSH - yyPop - 64);


    [self.showPopView showOrHide];
}

- (void)refreshTableListDataForFilter
{
    NSDictionary *dicParam = [self.fiterOtherModelCaYF paramExtionDicSingleChooseYF];
    
    for (NSUInteger i = 0; i < self.popViewsArray.count; i ++)
    {
        YFConditionPopView *popView = self.popViewsArray[i];
        
        [popView afterSetRightVCAllConditionsParam:dicParam];
        
        if (popView.param.count) {
            
            [self.operationView setSelectButtonWithIndex:i];
        }
        else
        {
            [self.operationView setUnSelectButtonWithIndex:i];
        }
    
        [self.operationView setSelectButtonTitleWithIndex:i suitFrametitle:popView.value maxWidth:(MSW / self.buttonTitlesArray.count - 10)];
    }
    
    [self selectParam:nil param:nil];// 重新初始化 条件 并且刷新
    
    [self onlyRefreshStudentData];
}


- (YFTBSectionsTitleModel *)secionomodel1
{
    if (!_secionomodel1)
    {
        YFTBSectionsTitleModel *secmodel  = [[YFTBSectionsTitleModel alloc] init];
        
        if (self.isTransPersent) {
            [secmodel setGrayViewHeight:self.operationView.height];
            
            secmodel.subViewOfHeaderView = self.operationView;
            
            secmodel.isAlwaysShowHeadView = YES;
        }
        _secionomodel1 = secmodel;
    }
    return _secionomodel1;
}

- (YFTBSectionsTitleModel *)secionomodel2
{
    if (!_secionomodel2)
    {
        YFTBSectionsTitleModel *secmodel =  [[YFTBSectionsTitleModel alloc] init];
        
        if (self.isTransPersent)
        {
            secmodel.xxOffset = XFrom5To6YF(12);
            secmodel.textColor = RGB(153, 153, 153);
            secmodel.font = FontSizeFY(XFrom5To6YF(12));
            [secmodel setGrayViewHeight:XFrom5To6YF(30)];
            [secmodel setSectionTitle:@"最近7天注册的会员"];

        }else
        {
            [secmodel setGrayViewHeight:self.operationView.height];
            
            secmodel.subViewOfHeaderView = self.operationView;
            
            secmodel.isAlwaysShowHeadView = YES;
        }
       

        _secionomodel2 = secmodel;
    }
    return _secionomodel2;
}


#pragma mark  代理Model 的设置
-(YFTBBaseDatasource *)dataSourceTBYF
{
    weakTypesYF
    return [YFTBSectionsDataSource tableDelegeteWithArray:^NSMutableArray *{
        return weakS.baseDataArray;
    }  currentVC:self];
}

-(YFTBSectionsDelegate *)delegateTBYF
{
    weakTypesYF
    return [YFTBSectionsLineEdgeDelegate tableDelegeteWithArray:^NSMutableArray *{
        return weakS.baseDataArray;
        
    } currentVC:self];
}


@end
