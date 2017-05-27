//
//  YFCardKindVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/8.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFCardKindVC.h"

#import "YFCardTypeModel.h"

#import "YFCardDataModel.h"

#import "YFTBSectionLineEdgeDelegate.h"

#define YFDonwnButtonSHeight XFrom5YF(40)


@interface YFCardKindVC ()

@property(nonatomic, strong)NSMutableArray *firstDataArray;

@property(nonatomic, strong)YFTBBaseDatasource *firstDataSourceTB;
@property(nonatomic, strong)YFTBBaseDelegate *firstDelegateTB;

@property(nonatomic, strong)YFCardDataModel *dataModel;


@end

@implementation YFCardKindVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        DebugLogYF(@"88888888888&&&&&&&");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.canGetMore = NO;
    [self.navi removeFromSuperview];
   
    [self setTwoTableViewYF];
    
    [self refreshTableListDataNoPull];

}

- (void)requestData
{
    weakTypesYF
    self.dataModel.isNotSuffient = self.isNotSuffient;
    
    [self.dataModel getResponseDatashowLoadingOn:self.view gym:self.gym successBlock:^{
        weakS.baseDataArray = weakS.dataModel.dataArray[0];
        YFCardCModel *model0 = weakS.baseDataArray.firstObject;
        weakS.cardModel = model0;
        
        weakS.firstDataArray = nil;
        YFCardTypeModel *model1 = [weakS modelWithName:@"全部类型" type:nil];
        weakS.cardTypeModel = model1;
        [weakS.firstDataArray addObject:model1];
        if (weakS.dataModel.prepaidMoArray.count)
        {
        NSLog(@"------:%@",@(weakS.dataModel.prepaidMoArray.count));

        [weakS.firstDataArray addObject:[weakS modelWithName:@"储值类型" type:@"1"]];
        }
        if (weakS.dataModel.countArray.count) {
        [weakS.firstDataArray addObject:[weakS modelWithName:@"次卡类型" type:@"2"]];
        }
        if (weakS.dataModel.timeMoArray.count) {
        [weakS.firstDataArray addObject:[weakS modelWithName:@"期限类型" type:@"3"]];
        }
        
        [weakS.firstTableView reloadData];
        [weakS.baseTableView reloadData];
        
        for (NSArray *array in weakS.dataModel.dataArray) {
            NSLog(@"***********______:%@",@(array.count));
        }
    } failBlock:^{
        [weakS failRequest:nil];
    }];
}

- (void)setTwoTableViewYF
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Width320(100), MSH - 64.0f) style:UITableViewStylePlain];
    tableView.backgroundColor = RGB_YF(244, 244, 244);
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        tableView.separatorInset = UIEdgeInsetsZero;
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        tableView.layoutMargins = UIEdgeInsetsZero;
    }
    
    tableView.tableFooterView = [[UIView alloc] init];
    
    weakTypesYF
    
    self.firstDelegateTB =  [YFTBBaseDelegate tableDelegeteWithArray:^NSMutableArray *{
        return weakS.firstDataArray;
        
    } currentVC:self];
    
    self.firstDataSourceTB = [YFTBBaseDatasource tableDelegeteWithArray:^NSMutableArray *{
        return weakS.firstDataArray;
    } currentVC:self];
    
    
    tableView.delegate = self.firstDelegateTB;
    
    tableView.dataSource = self.firstDataSourceTB;
    
    self.firstTableView = tableView;
    self.firstTableView.separatorColor = YFLineViewColor;
    self.refreshScrollView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:tableView];
}


- (NSMutableArray *)firstDataArray
{
    if (!_firstDataArray) {
        _firstDataArray = [NSMutableArray array];
    }
    return _firstDataArray;
}


- (YFCardTypeModel *)modelWithName:(NSString *)name type:(NSString *)type
{
    YFCardTypeModel *model1 = [YFCardTypeModel defaultWithDic:nil];
    model1.name = name;
    return model1;
}

- (YFCardDataModel *)dataModel
{
    if (!_dataModel) {
        _dataModel = [[YFCardDataModel alloc] init];
    }
    
    return _dataModel;
}

-(void)setCardModel:(YFCardCModel *)cardModel
{
    _cardModel.isSelected = NO;
    cardModel.isSelected = YES;
    _cardModel = cardModel;
    [self.baseTableView reloadData];
}
- (void)setCardTypeModel:(YFCardTypeModel *)cardTypeModel
{
    _cardTypeModel.isSelected = NO;
    cardTypeModel.isSelected = YES;
    _cardTypeModel = cardTypeModel;
    [self.firstTableView reloadData];
    
    NSInteger index = [self.firstDataArray indexOfObject:cardTypeModel];
    
    if ([self.firstDataArray containsObject:cardTypeModel])
    {
        self.baseDataArray = self.dataModel.dataArray[index];
    }
    
    for (NSArray *array in self.dataModel.dataArray) {
        NSLog(@"***********______:%@",@(array.count));
    }
    
    NSLog(@"");
    [self.baseTableView reloadData];
}

-(void)showFailViewOnSuperView:(UIView *)superView
{
    [super showFailViewOnSuperView:superView];
    [self.view addSubview:self.failViewYF];
}

-(YFTBBaseDelegate *)delegateTBYF
{
    weakTypesYF
    return [YFTBSectionLineEdgeDelegate tableDelegeteWithArray:^NSMutableArray *{
        return weakS.baseDataArray;
        
    } currentVC:self];
}

- (void)reloadNetDataYF
{
    [self refreshTableListDataNoPull];
}
//


@end
