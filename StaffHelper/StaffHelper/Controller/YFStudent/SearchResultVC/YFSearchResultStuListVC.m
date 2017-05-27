//
//  YFSearchResultStuListVC.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFSearchResultStuListVC.h"
#import "YFSearchStuListDataModel.h"

@interface YFSearchResultStuListVC ()

@property(nonatomic, strong)YFSearchStuListDataModel *dataModel;

@end

@implementation YFSearchResultStuListVC
{
    NSString *_searchStr;
}


-(instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableListData) name:kPostModifyOrAddStudentIdtifierYF object:nil];
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
}

-(void)refreshTableListData
{
    NSString *str = _searchStr;
    _searchStr = @"";
    [self searchStrChangeYF:str];
}

- (void)searchStrChangeYF:(NSString *)str
{
    if ([_searchStr isEqualToString:str] == YES)
    {
        
        return;
    }
    [self requestSearchWithStrYF:str];
}

-(void)requestSearchWithStrYF:(NSString *)str
{
    _searchStr = str;
    if (_searchStr.length == 0)
    {
//        [self showHint:@"请输入搜索关键字"];
//        self.baseDataArray = [NSMutableArray array];
//        [self.baseTableView reloadData];
//        self.dataModel.searchStr = @"";
//        [self setTableFootviewLabelNum:0];
    }else
    {
        weakTypesYF
        self.dataModel.searchStr = _searchStr;
        [self.dataModel getResponseDatashowLoadingOn:nil gym:self.gym successBlock:^{
            
            weakS.baseDataArray = weakS.dataModel.allSearchDataArray;
            [weakS.baseTableView reloadData];
            [weakS setTableFootviewLabelNum:weakS.dataModel.allMemNum.integerValue];
            
        } failBlock:^{
            
        }];
    }

}

- (YFSearchStuListDataModel *)dataModel
{
    if (!_dataModel) {
        _dataModel = [[YFSearchStuListDataModel alloc] init];
    }
    return _dataModel;
}

@end
