//
//  CardListController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardListController.h"

#import "MOTableView.h"

#import "CardDetailController.h"

#import "CardCell.h"

#import "CardListInfo.h"

#import "CardCreateChooseKindController.h"

#import "FilterButton.h"

#import "CardFilterController.h"

#import "ChangeGymController.h"

#import "CardCreateChooseGymController.h"

#import "CardKindListGymController.h"

#import "MOMenuView.h"

#import "GTWSelectOperationView.h"

#import "Masonry.h"

#import "YFCardBasePopView.h"

#import "YFAppConfig.h"

#import "YFModuleManager.h"

#import "YFCardConditionPopView.h"

#import "YFAutomicRemindVC.h"

#import "YFAppService.h"

#import "YFCardKindPopView.h"

#define YFNoSufientHeightTipLabel XFrom5To6YF(33)

#define YFNoSufientHeightTipLabelOverGap 3


static NSString *identifier = @"Cell";

@interface CardListController ()<MOTableViewDatasource,UITableViewDelegate,UITextFieldDelegate,GTWSelectOperationViewDelegate,MOMenuDelegate>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)CardListInfo *info;

@property(nonatomic,strong)UIView *searchView;

@property(nonatomic,strong)UITextField *searchBar;

@property(nonatomic,assign)BOOL isFiltered;

@property(nonatomic,strong)FilterButton *filterButton;

@property(nonatomic,assign)CardState filterState;

@property(nonatomic,strong)CardKind *filterCardKind;

@property(nonatomic,strong)UIScrollView *emptyView;

@property (nonatomic,strong) GTWSelectOperationView *operationView;

@property(nonatomic, strong)NSMutableArray *popViewsArray;

@property(nonatomic, strong)YFConditionPopView *showPopView;

@property(nonatomic, strong)UIView *tableHeaderViewYF;

@property(nonatomic, strong)UILabel *pointLabel;

@property(nonatomic, strong)UILabel *sumCarLabel;

// 余额不足 时，该View 高不固定
@property(nonatomic, strong)UIView *nosuffientView;

@property(nonatomic, strong)YFCardConditionPopView *cardConditonView;

@property(nonatomic, strong)CardListInfo *cardCountInfo;

@property(nonatomic, strong)UIView *grayView;

@property(nonatomic, strong)YFCardKindPopView *cardKindPopView;

@end

@implementation CardListController
{
    NSDictionary *_condtionParam;
    UILabel *_conditionLabel;
    UIView *_conditionLineView;
    UIView *_conditionButton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:kPostUpdateCardValidTimeSuccessYF object:nil];
    }
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    weakTypesYF
    
    [self.cardCountInfo getCardConutshowLoadingOn:nil gym:self.gym successBlock:^{
        if (weakS.cardCountInfo.suffinetCardCount.integerValue >= 0 && weakS.cardCountInfo.suffinetCardCount)
        {
            weakS.pointLabel.text = [NSString stringWithFormat:@"%@张",weakS.cardCountInfo.suffinetCardCount];
        }else
        {
            weakS.pointLabel.text = @"";
        }
        //        [weakS.tableView setTableHeaderView:<#(UIView * _Nullable)#>];
        
    } failBlock:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)createData
{
    
    weakTypesYF
    if (self.isNotSuffient)
    {
        [self.cardCountInfo getGetSuffientSettingStudentshowLoadingOn:nil gym:self.gym successBlock:^{
            
            [weakS setTableHeadViewToTableView];
            
            [weakS cardNotSufficientFunds];
            
            [weakS.cardConditonView setCardListSetting:weakS.cardCountInfo];
            
        } failBlock:^{
            
        }];
        
    }
    
    CardListInfo *info = [[CardListInfo alloc]init];
    
    info.isNotSuffient = self.isNotSuffient;
    
    __weak typeof(CardListInfo *)weakInfo = info;
    
    info.requestFinish = ^(BOOL success,NSString *error){
        
        weakS.info = weakInfo;
        
        weakS.tableView.mj_footer.hidden = !weakS.info.cards.count;
        
        if (success && [error isEqualToString:@"无更多数据"]) {
            
            [weakS.tableView.mj_footer endRefreshingWithNoMoreData];
            
        }else{
            
            [weakS.tableView.mj_footer endRefreshing];
            
        }
        
        [weakS.tableView.mj_header endRefreshing];
        
        weakS.tableView.dataSuccess = success;
        
        [weakS.tableView reloadData];
        
        [weakS setSumCarLabelValue];
    };
    
    [info requestDataWithGym:self.gym contionParam:_condtionParam andState:self.filterState andSearch:self.searchBar.text];
    
}

-(void)reloadData
{
    
    weakTypesYF
    if (self.isNotSuffient)
    {
        [self.cardCountInfo getGetSuffientSettingStudentshowLoadingOn:nil gym:self.gym successBlock:^{
            
            [weakS setTableHeadViewToTableView];
            
            [weakS cardNotSufficientFunds];
            
            [weakS.cardConditonView setCardListSetting:weakS.cardCountInfo];
            
        } failBlock:^{
            
        }];
        
    }
    
    
    [self.tableView.mj_footer resetNoMoreData];
    
    CardListInfo *info = [[CardListInfo alloc]init];
    
    info.isNotSuffient = self.isNotSuffient;
    
    __weak typeof(CardListInfo *)weakInfo = info;
    
    info.requestFinish = ^(BOOL success,NSString *error){
        
        weakS.info = weakInfo;
        
        weakS.tableView.mj_footer.hidden = !weakS.info.cards.count;
        
        if (success && [error isEqualToString:@"无更多数据"]) {
            
            [weakS.tableView.mj_footer endRefreshingWithNoMoreData];
            
        }else{
            
            [weakS.tableView.mj_footer endRefreshing];
            
        }
        
        [weakS.tableView.mj_header endRefreshing];
        
        weakS.tableView.dataSuccess = success;
        
        [weakS.tableView reloadData];
        [weakS setSumCarLabelValue];
        
    };
    
    [info requestDataWithGym:self.gym contionParam:_condtionParam andState:self.filterState andSearch:self.searchBar.text];
    
    [self.cardCountInfo getCardConutshowLoadingOn:nil gym:self.gym successBlock:^{
        if (weakS.cardCountInfo.suffinetCardCount.integerValue >= 0 && weakS.cardCountInfo.suffinetCardCount)
        {
            weakS.pointLabel.text = [NSString stringWithFormat:@"%@张",weakS.cardCountInfo.suffinetCardCount];
        }else
        {
            weakS.pointLabel.text = @"";
        }
        //        [weakS.tableView setTableHeaderView:<#(UIView * _Nullable)#>];
        
    } failBlock:^{
        
    }];
}

-(void)update
{
    
    weakTypesYF
    self.info.requestFinish = ^(BOOL success,NSString *error){
        
        weakS.tableView.mj_footer.hidden = !weakS.info.cards.count;
        
        if (success && [error isEqualToString:@"无更多数据"]) {
            
            [weakS.tableView.mj_footer endRefreshingWithNoMoreData];
            
        }else{
            
            [weakS.tableView.mj_footer endRefreshing];
            
        }
        
        [weakS.tableView.mj_header endRefreshing];
        
        weakS.tableView.dataSuccess = success;
        
        [weakS.tableView reloadData];
        
        [weakS setSumCarLabelValue];
    };
    
    [self.info update];
    
}

-(void)createUI
{
    
    if (self.isNotSuffient)
    {
        // 余额不足 页面
        self.title = @"余额不足";
        
        self.rightTitle = @"自动提醒";
        self.rightColor = [UIColor whiteColor];
    }else
    {
        // 会员卡 页面
        self.rightType = MONaviRightTypeMore;
        
        self.rightSubType = MONaviRightSubTypeSearch;
        
        
        self.title = @"会员卡";
        
        self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        self.searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, 64)];
        
        self.searchView.backgroundColor = UIColorFromRGB(0x4e4e4e);
        
        [self.view addSubview:self.searchView];
        
        self.searchView.hidden = YES;
        
        self.searchBar = [[UITextField alloc]initWithFrame:CGRectMake(Width320(7.5), 23.1, Width320(257), 35.7)];
        
        [self.searchView addSubview:self.searchBar];
        
        self.searchBar.returnKeyType = UIReturnKeySearch;
        
        self.searchBar.layer.cornerRadius = 2;
        
        self.searchBar.layer.masksToBounds = YES;
        
        self.searchBar.backgroundColor = UIColorFromRGB(0xfafafa);
        
        self.searchBar.font = AllFont(14);
        
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, self.searchBar.height)];
        
        UIImageView *searchImg = [[UIImageView alloc]initWithFrame:CGRectMake(16.8, 10.3, 15.5, 15.5)];
        
        searchImg.image = [UIImage imageNamed:@"search"];
        
        [leftView addSubview:searchImg];
        
        self.searchBar.leftView = leftView;
        
        self.searchBar.leftViewMode = UITextFieldViewModeAlways;
        
        self.searchBar.delegate = self;
        
        self.searchBar.placeholder = @"搜索会员卡";
        
        UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        clearButton.frame = CGRectMake(self.searchBar.right-Width320(24), 0, Width320(24), self.searchBar.height);
        
        self.searchBar.rightView = clearButton;
        
        UIImageView *clearImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(3), 0, Width320(12.4), Height320(12.4))];
        
        clearImg.image = [UIImage imageNamed:@"clear"];
        
        clearImg.center = CGPointMake(clearImg.center.x, clearButton.height/2);
        
        [clearButton addSubview:clearImg];
        
        [clearButton addTarget:self action:@selector(clear:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.searchBar addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
        
        UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        
        cancel.frame = CGRectMake(self.searchBar.right, 20, MSW-self.searchBar.right, 44);
        
        [cancel setTitle:@"取消" forState:UIControlStateNormal];
        
        [cancel setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
        cancel.backgroundColor = [UIColor clearColor];
        
        [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.searchView addSubview:cancel];
    }
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW,MSH-64) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(update)];
    
    [footer setTitle:@"无更多数据" forState:MJRefreshStateNoMoreData];
    
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    
    self.tableView.mj_footer = footer;
    
    [self.tableView registerClass:[CardCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];
    
    
    if (self.isNotSuffient == NO)
    {
        // 提前 设置 tableViewHeader,
        [self setTableHeadViewToTableView];
        
        [self cardNotSufficientFunds];
        
        UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW-Width320(64), MSH-Height320(75), Width320(48), Height320(48))];
        
        [addButton setImage:[UIImage imageNamed:@"card_list_add"] forState:UIControlStateNormal];
        
        addButton.layer.shadowOffset = CGSizeMake(0, Height320(2));
        
        addButton.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
        
        addButton.layer.shadowOpacity = 0.3;
        
        [self.view addSubview:addButton];
        
        [addButton addTarget:self action:@selector(cardAdd) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.info.cards.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(66);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CardCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (indexPath.row<self.info.cards.count) {
        
        Card *card = self.info.cards[indexPath.row];
        
        cell.cardBackColor = card.color;
        
        cell.cardState = card.state;
        
        cell.cardName = card.cardName;
        
        cell.cardNumber = card.cardId;
        
        cell.users = card.users;
        
        cell.cardType = card.cardKind.type;
        
        cell.remain = card.remain;
        
    }
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//
//    return Height320(40);
//
//}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//
//    return nil;
//    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40))];
//
//    header.backgroundColor = UIColorFromRGB(0xf4f4f4);
//
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), 0, Width320(200), Height320(40))];
//
//    label.textColor = UIColorFromRGB(0x999999);
//
//    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"会员卡总数：%ld",(long)self.info.totalCount]];
//
//    [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x333333) range:NSMakeRange(6, astr.length-6)];
//
//    label.attributedText = astr;
//
//    label.font = AllFont(14);
//
//    [header addSubview:label];
//
//    self.filterButton = [[FilterButton alloc]initWithFrame:CGRectMake(MSW-Width320(60), 0, Width320(60), Height320(40))];
//
//    self.filterButton.filtered = _isFiltered;
//
//    self.filterButton.image = [UIImage imageNamed:@"filter"];
//
//    self.filterButton.title = @"筛选";
//
//    [self.filterButton addTarget:self action:@selector(filter:) forControlEvents:UIControlEventTouchUpInside];
//
//    if (self.filterState != CardStateNo || self.filterCardKind) {
//
//        self.filterButton.filtered = YES;
//
//    }else
//    {
//
//        self.filterButton.filtered = NO;
//
//    }
//
//    [header addSubview:self.filterButton];
//
//    return header;
//
//}

-(void)filter:(UIButton*)button
{
    
    CardFilterController *svc = [[CardFilterController alloc]init];
    
    __weak typeof(self)weakS = self;
    
    svc.cardKind = self.filterCardKind;
    
    svc.state = self.filterState;
    
    svc.filtered = ^(CardKind *cardKind,CardState state){
        
        weakS.filterCardKind = cardKind;
        
        weakS.filterState = state;
        
        [weakS createData];
        
        if (weakS.filterState != CardStateNo || weakS.filterCardKind) {
            
            weakS.filterButton.filtered = YES;
            
        }else
        {
            
            weakS.filterButton.filtered = NO;
            
        }
        
    };
    
    [self presentViewController:svc animated:YES completion:^{
        
    }];
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CardDetailController *svc = [[CardDetailController alloc]init];
    
    svc.card = self.info.cards[indexPath.row];
    
    svc.gym = self.gym;
    
    __weak typeof(self)weakS = self;
    
    svc.editFinish = ^{
        
        [weakS createData];
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

-(void)cardAdd
{
    
    if (AppGym&&([PermissionInfo sharedInfo].permissions.cardPermission.addState ||[PermissionInfo sharedInfo].permissions.personalCardPermission.addState)) {
        
        CardCreateChooseKindController *svc = [[CardCreateChooseKindController alloc]init];
        
        svc.gym = AppGym;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else if(!AppGym&&([PermissionInfo sharedInfo].permissions.cardPermission.addState ||[PermissionInfo sharedInfo].permissions.personalCardPermission.addState)){
        
        NSArray *cardGyms = [[PermissionInfo sharedInfo]getHaveAddPermissionGymsWithPermission:[Permission cardPermission]];
        
        NSArray *personalCardGyms = [[PermissionInfo sharedInfo]getHaveAddPermissionGymsWithPermission:[Permission personalCardPermission]];
        
        NSMutableArray *gyms = [cardGyms mutableCopy];
        
        for (Gym *tempGym in personalCardGyms) {
            
            BOOL contains = NO;
            
            for (Gym *tempCardGym in gyms) {
                
                if (tempCardGym.shopId == tempGym.shopId) {
                    
                    contains = YES;
                    
                    break;
                    
                }
                
            }
            
            if (!contains) {
                
                [gyms addObject:tempGym];
                
            }
            
        }
        
        if (gyms.count>=1){
            
            CardCreateChooseGymController *svc = [[CardCreateChooseGymController alloc]init];
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else if (gyms.count==1){
            
            CardCreateChooseKindController *svc = [[CardCreateChooseKindController alloc]init];
            
            Gym *gym = [[[PermissionInfo sharedInfo]getHaveAddPermissionGymsWithPermission:[Permission cardPermission]]firstObject];
            
            svc.gym = gym;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [self showNoPermissionAlert];
            
        }
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(void)naviRightSubClick
{
    
    self.searchView.hidden = NO;
    
    [self.view bringSubviewToFront:self.searchView];
    
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    
    [self.searchBar resignFirstResponder];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    [self createData];
    
    return YES;
    
}

-(void)textFieldDidChanged:(UITextField *)textField
{
    
    if (textField.text.length) {
        
        self.searchBar.rightViewMode = UITextFieldViewModeAlways;
        
    }else
    {
        
        self.searchBar.rightViewMode = UITextFieldViewModeNever;
        
    }
    
}

-(void)clear:(UIButton*)btn
{
    
    self.searchBar.text = @"";
    
    [self createData];
    
    [self.searchBar resignFirstResponder];
    
}
-(void)cancel:(UIButton*)btn
{
    
    [self.searchBar resignFirstResponder];
    
    self.searchView.hidden = YES;
    
    self.searchBar.text = @"";
    
    [self createData];
    
}

-(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    self.emptyView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.tableView.tableHeaderView.height, MSW, MSH-64-Height320(40))];
    
    self.emptyView.backgroundColor = UIColorFromRGB(0xffffff);
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(createData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.emptyView.mj_header = header;
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(64), Height320(71), Width320(185), Height320(144))];
    
    emptyImg.image = [UIImage imageNamed:@"card_empty"];
    
    [self.emptyView addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, emptyImg.bottom+Height320(18), self.emptyView.width, Height320(16))];
    
    emptyLabel.textColor = UIColorFromRGB(0x999999);
    
    emptyLabel.font = STFont(14);
    
    emptyLabel.text = @"暂无会员卡";
    
    emptyLabel.numberOfLines = 1;
    
    emptyLabel.textAlignment  = NSTextAlignmentCenter;
    
    [self.emptyView addSubview:emptyLabel];
    
    return self.emptyView;
}

#pragma mark 会员卡余额不足

- (void)cardNotSufficientFunds
{
    
    CGFloat height = Width320(310);
    
    
    CGFloat yyPop = 64.0 + self.operationView.bottom;
    
    // 计算一个 合适的高度，
    if (MSH - 50 - yyPop < height)
    {
        height = MSH - 50 - yyPop;
    }
    
    for (Class popClass in self.classsArray)
    {
        
        YFCardBasePopView *popView = [[popClass alloc] initWithFrame:CGRectMake(0, 0, MSW, MSH) superView:self.view childrenFrame:CGRectMake(0, 0, MSW, height) sufient:self.isNotSuffient];
        popView.isNotSuffient = self.isNotSuffient;
        popView.title = self.title;
        popView.referenceView = self.operationView;
        weakTypesYF
        [popView setSelectBlock:^(NSString *value, NSDictionary *param) {
            [weakS selectParam:value param:param];
        }];
        __weak typeof(popView)weakPopView = popView;
        [popView setHideBlock:^{
            if ([weakS.popViewsArray containsObject:weakPopView]) {
                NSInteger index = [weakS.popViewsArray indexOfObject:weakPopView];
                UIButton *button  = [weakS.operationView buttonWithIndex:index];
                button.selected = NO;
            }
        }];
        
        if ([popView isKindOfClass:[YFCardKindPopView class]]) {
            self.cardKindPopView = (YFCardKindPopView *)popView;
        }
        
        popView.gym = self.gym;
        [self.popViewsArray addObject:popView];
    }
    
    [self operationView];
}

-(void)naviRightClick
{
    if (self.isNotSuffient)
    {
        YFAutomicRemindVC *autoVC = [[YFAutomicRemindVC alloc] init];
        autoVC.gym = self.gym;
        [self.navigationController pushViewController:autoVC animated:YES];
        return;
        
    }
    MOMenuView *sheet = [MOMenuView menuWithTitie:nil delegate:self destructiveButtonTitle:nil cancelButtonTitle:nil otherButtonTitles:@"会员卡种类",nil];
    
    sheet.textAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [sheet show];
    
}

-(void)actionSheet:(MOMenuView *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        CardKindListGymController *svc = [[CardKindListGymController alloc]init];
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
}


- (void)selectParam:(NSString *)value param:(NSDictionary *)param
{
    [self.showPopView hide];
    
    NSMutableDictionary *allParam = [NSMutableDictionary dictionary];
    
    for (NSUInteger i = 0; i < self.popViewsArray.count; i ++)
    {
        YFCardBasePopView *popView = self.popViewsArray[i];
        if (popView.param.count) {
            if (popView.isValidParam)
            {
                [allParam setValuesForKeysWithDictionary:popView.param];
            }
            [self.operationView setSelectButtonWithIndex:i];
        }else
        {
            [self.operationView setUnSelectButtonWithIndex:i];
        }
        if ([popView isEqual:self.showPopView])
        {
            [self.operationView setSelectButtonTitleWithIndex:i suitFrametitle:self.showPopView.value];
        }
        
        
        
    }
    
    for (YFConditionPopView *popView in self.popViewsArray) {
        [popView afterSetAllConditionsParam:allParam];
    }
    
    [self.operationView setUnselectButtonFY];
    _condtionParam = allParam;
    
    [self reloadData];
}

- (void)operationViewDidSelectedIndex:(NSInteger)index selectedState:(BOOL)selectedState button:(UIButton *)button
{
    if (self.popViewsArray.count > index) {
        self.showPopView = self.popViewsArray[index];
    }else
    {
        self.showPopView = nil;
    }
    if (self.showPopView.isCanShow == NO)
    {
        [self.operationView setUnselectButtonFY];
    }
    
    CGFloat yyPop ;
    
    if ([self.operationView.superview isEqual:self.view]) {
        
        yyPop = 64.0 + self.operationView.height;
    }else
    {
        yyPop = 64.0 + self.operationView.bottom - self.tableView.contentOffset.y;
    }
    
    
    self.showPopView.originFrame = CGRectMake(0, yyPop, self.view.width, self.showPopView.originFrame.size.height);
    
    [self.showPopView showOrHide];
}

- (void)setShowPopView:(YFConditionPopView *)showPopView
{
    if (_showPopView && [showPopView isEqual:_showPopView] == NO) {
        [_showPopView hideAnimate:NO];
    }
    _showPopView = showPopView;
}


#pragma mark Getter
- (GTWSelectOperationView *)operationView
{
    if (!_operationView)
    {
        _operationView = [[GTWSelectOperationView alloc]initWithDataSourceFY:self.buttonTitlesArray sepImage:@"fadeline" delegate:self font:[UIFont systemFontOfSize:IPhone4_5_6_6P(13, 13, 14, 14)]];
        _operationView.backgroundColor = [UIColor whiteColor];
        [self.tableHeaderViewYF addSubview:self.operationView];
        
        _operationView.delegate = self;
        CGFloat offsetTop = self.nosuffientView.height + 12;
        
        _operationView.frame = CGRectMake(0, offsetTop, self.tableHeaderViewYF.width, GTWSelectOperationViewHeight);
        
        //        [_operationView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(self.tableHeaderViewYF.mas_top).offset(offsetTop);
        //            make.left.equalTo(self.tableHeaderViewYF.mas_left);
        //            make.right.equalTo(self.tableHeaderViewYF.mas_right);
        //            make.height.equalTo(@(GTWSelectOperationViewHeight));
        //            make.width.equalTo(self.tableHeaderViewYF.width);
        //        }];
    }
    return _operationView;
}
- (NSMutableArray *)popViewsArray
{
    if (!_popViewsArray)
    {
        _popViewsArray = [[NSMutableArray alloc] init];
    }
    return _popViewsArray;
}

- (UIView *)tableHeaderViewYF
{
    if (!_tableHeaderViewYF) {
        
        _tableHeaderViewYF =[self tableTopHeadView];
        
        [_tableHeaderViewYF addSubview:self.operationView];
        
        UIView *lineView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableHeaderViewYF.width, OnePX)];
        lineView.backgroundColor = YFLineViewColor;
        [self.operationView addSubview:lineView];
        
    }
    return _tableHeaderViewYF;
}

- (UIView *)tableTopHeadView
{
    CGFloat height = self.isNotSuffient == YES ? XFrom5To6YF(60) :XFrom5To6YF(48);
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW,height  + 12 + GTWSelectOperationViewHeight + YFNoSufientHeightTipLabel)];
    
    header.backgroundColor = [UIColor whiteColor];
    
    if (self.isNotSuffient)
    {
        [self setNotSuffientSuperView:header];
    }else
    {
        [self setSuffientSuperView:header];
    }
    
    [header changeHeight:XFrom5To6YF(52) + self.nosuffientView.height + YFNoSufientHeightTipLabel];
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, self.nosuffientView.bottom, header.width, 18)];
    self.grayView = grayView;
    grayView.backgroundColor = YFGrayViewColor;
    
    [header addSubview:grayView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), header.bottom - YFNoSufientHeightTipLabel + 7, Width320(200), YFNoSufientHeightTipLabel)];
    
    label.textColor = UIColorFromRGB(0x999999);
    
    self.sumCarLabel = label;
    
    label.font = AllFont(14);
    
    label.backgroundColor = [UIColor clearColor];
    
    [self setSumCarLabelValue];
    
    [header addSubview:label];
    
    return header;
}

- (void)setSumCarLabelValue
{
    if (!self.info) {
        return;
    }
    //    if (self.isNotSuffient) {
    //        NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"余额不足会员卡总数：%ld",(long)self.info.totalCount]];
    //
    //        [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x333333) range:NSMakeRange(10, astr.length-10)];
    //
    //        self.sumCarLabel.attributedText = astr;
    //    }else
    //    {
    //       }
    
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"会员卡总数：%ld",(long)self.info.totalCount]];
    [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x333333) range:NSMakeRange(6, astr.length-6)];
    
    self.sumCarLabel.attributedText = astr;
    
}


- (void)setNotSuffientSuperView:(UIView *)topView
{
    UIView *nosuffientView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MSW, 0)];
    
    self.nosuffientView = nosuffientView;
    
    nosuffientView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    nosuffientView.layer.borderWidth = OnePX;
    
    [topView addSubview:nosuffientView];
    
    UILabel *desLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12.0), XFrom5To6YF(14), 200, XFrom5To6YF(12))];
    
    desLabel.text = @"显示符合以下条件的会员卡：";
    
    desLabel.textColor = RGB_YF(153, 153, 153);
    
    desLabel.font = FontSizeFY(XFrom5To6YF(11));
    
    [nosuffientView addSubview:desLabel];
    
    CGFloat maxWidth = MSW - 80;
    
    
    //    NSString *conditonLabelStr = @"储值卡<500元，次卡<5次，有效期<15天，次卡<5次 有效期<15天，次卡<5次，有效期<15天";
    
    NSString *conditonLabelStr = [NSString stringWithFormat:@"储值卡<%@元，次卡<%@次，有效期<%@天",self.cardCountInfo.balancePayModel.value,self.cardCountInfo.remandTimesModel.value,self.cardCountInfo.remindDaysModel.value];
    
    
    UIFont *conditonFont = FontSizeFY(XFrom5To6YF(12));
    
    CGSize size = YF_MULTILINE_TEXTSIZE(conditonLabelStr, conditonFont, CGSizeMake(maxWidth, 1000), 0);
    
    CGFloat height = size.height + 0.5;
    
    UILabel *conditionLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12.0), XFrom5To6YF(34), maxWidth, height)];
    
    _conditionLabel = conditionLabel;
    
    conditionLabel.numberOfLines = 0;
    
    conditionLabel.text = conditonLabelStr;
    
    conditionLabel.textColor = RGB_YF(51, 51, 51);
    
    conditionLabel.font = conditonFont;
    
    [nosuffientView addSubview:conditionLabel];
    
    [nosuffientView changeHeight:conditionLabel.bottom + 13];
    
    CGFloat lineYY = 14;
    
    CGFloat lineHeight = self.nosuffientView.height - lineYY * 2;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(MSW - 60, lineYY, OnePX, lineHeight)];
    
    lineView.backgroundColor = YFLineViewColor;
    _conditionLineView = lineView;
    [nosuffientView addSubview:lineView];
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(lineView.right, 0, MSW - lineView.right, nosuffientView.height)];
    
    button.titleLabel.font = FontSizeFY(XFrom5To6YF(12));
    
    button.titleLabel.numberOfLines = 0;
    
    [button setTitle:@"修改\n条件" forState:UIControlStateNormal];
    
    [button setTitleColor:YFSelectedButtonColor forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(modifyCoditonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _conditionButton = button;
    
    [nosuffientView addSubview:button];
    
}

- (void)modifyCoditonAction:(UIButton *)button
{
    
    // 请求成功后，才可以
    if (self.cardCountInfo.remindDaysModel)
    {
        [self.cardConditonView showOrHide];
    }
}

//
-(UIView *)setSuffientSuperView:(UIView *)topView
{
    UIButton *sellerView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, XFrom5To6YF(48))];
    self.nosuffientView = sellerView;
    
    sellerView.backgroundColor = UIColorFromRGB(0xffffff);
    
    sellerView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    sellerView.layer.borderWidth = OnePX;
    
    [topView addSubview:sellerView];
    
    UIImageView *sellerImg = [[UIImageView alloc]initWithFrame:CGRectMake(XFrom5To6YF(16), Height320(15), XFrom5To6YF(22), XFrom5To6YF(15))];
    
    sellerImg.center = CGPointMake(sellerImg.center.x, sellerView.height / 2.0);
    
    sellerImg.image = [UIImage imageNamed:@"warnningIm"];
    
    [sellerView addSubview:sellerImg];
    
    UILabel *sellerTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(XFrom5To6YF(46), 0, Width320(80), sellerView.height)];
    
    sellerTitleLabel.text = @"余额不足";
    
    sellerTitleLabel.textColor = UIColorFromRGB(0x333333);
    
    sellerTitleLabel.font = FontSizeFY(XFrom5To6YF(14));
    
    [sellerView addSubview:sellerTitleLabel];
    
    UILabel *sellersLabel = [[UILabel alloc]initWithFrame:CGRectMake(sellerTitleLabel.right, 0, MSW-Width320(29)-sellerTitleLabel.right, sellerView.height)];
    
    sellersLabel.textColor = UIColorFromRGB(0x999999);
    
    sellersLabel.font = FontSizeFY(XFrom5To6YF(12));
    
    sellersLabel.textAlignment = NSTextAlignmentRight;
    self.pointLabel = sellersLabel;
    
    [sellerView addSubview:sellersLabel];
    
    [sellerView addTarget:self action:@selector(noSufientPointAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *sellerArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23), sellerView.height/2-Height320(6), Width320(7), Height320(12))];
    
    sellerArrow.image = [UIImage imageNamed:@"gray_arrow"];
    
    [sellerView addSubview:sellerArrow];
    
    
    
    return sellerView;
}

- (void)noSufientPointAction:(UIButton *)button
{
    
    if ([PermissionInfo sharedInfo].permissions.cardbalancePermission.readState)
    {
        UIViewController *noSuffietnVC = [YFModuleManager cardListOfNotSuffientViewControllerGym:self.gym];
        
        [self.navigationController pushViewController:noSuffietnVC animated:YES];
    }else
    {
        [self showNoPermissionAlert];
    }
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIView *needToTopView = self.operationView;
    
    UIView *header = self.tableHeaderViewYF;
    
    UIView *superViewOfNeedToTopView = self.view;
    
    CGFloat offsetXX = header.height - needToTopView.height - YFNoSufientHeightTipLabel;
    
    if (offsetXX <= scrollView.contentOffset.y)
    {
        if ([needToTopView.superview isEqual:superViewOfNeedToTopView] == NO)
        {
            [needToTopView changeTop:64.0];
            [superViewOfNeedToTopView addSubview:needToTopView];
        }
    }else
    {
        if ([needToTopView.superview isEqual:header] == NO)
        {
            [needToTopView changeTop:header.height - needToTopView.height - YFNoSufientHeightTipLabel];
            [header addSubview:needToTopView];
        }
    }
}

- (YFCardConditionPopView *)cardConditonView
{
    if (!_cardConditonView)
    {
        _cardConditonView = [[YFCardConditionPopView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64.0) superView:self.view childrenFrame:CGRectZero];
        weakTypesYF
        [_cardConditonView setSelectBlock:^(NSString *str, NSDictionary *dic) {
            
            [weakS.cardCountInfo getPutSuffientSettingStudentshowLoadingOn:weakS.tableView gym:weakS.gym param:weakS.cardConditonView.param successBlock:^{
                [weakS.cardConditonView hide];
                
                [weakS afterSelectCardCondition];
                [weakS reloadData];
            } failBlock:^{
                [YFAppService showAlertMessage:@"修改失败" sureTitle:@"重新修改" sureBlock:^{
                    weakS.cardConditonView.selectBlock(str,dic);
                }];
            }];
            
            
            
        }];
    }
    [self.view bringSubviewToFront:_cardConditonView];
    return _cardConditonView;
}

- (void)afterSelectCardCondition
{
    
    for (UIView *view in self.popViewsArray) {
        [view removeFromSuperview];
    }
    [self.popViewsArray removeAllObjects];
    
    [self.operationView removeFromSuperview];
    self.operationView = nil;
    //    self.operationView
    
    [self cardNotSufficientFunds];
    
    _condtionParam = @{};
    
    //    [self.operationView setUnSelectButtonWithIndex:0];
    //    [self.operationView setSelectButtonTitleWithIndex:0 suitFrametitle:@"会员卡种类"];
    
    //    [self.cardKindPopView reloadConditionData];
    
    NSString *payStr = [self.cardConditonView.param objectForKey:@"pay"];
    NSString *countStr = [self.cardConditonView.param objectForKey:@"count"];
    NSString *timeStr = [self.cardConditonView.param objectForKey:@"time"];
    
    [self setCartSetting:payStr countStr:countStr timeStr:timeStr];
    
    
}

- (void)setCartSetting:(NSString *)payStr countStr:(NSString *)countStr timeStr:(NSString *)timeStr
{
    self.cardCountInfo.balancePayModel.value = payStr;
    self.cardCountInfo.remandTimesModel.value = countStr;
    self.cardCountInfo.remindDaysModel.value = timeStr;
    [self.cardConditonView setCardListSetting:self.cardCountInfo];
    
    // 计算 frame
    NSString *conditonLabelStr = [NSString stringWithFormat:@"储值卡<%@元，次卡<%@次，有效期<%@天",payStr,countStr,timeStr];
    
    UIFont *conditonFont = FontSizeFY(XFrom5To6YF(12));
    
    CGSize size = YF_MULTILINE_TEXTSIZE(conditonLabelStr, conditonFont, CGSizeMake(_conditionLabel.width, 1000), 0);
    
    CGFloat height = size.height + 0.5;
    
    _conditionLabel.frame = CGRectMake(Width320(12.0), XFrom5To6YF(34), _conditionLabel.width, height);
    _conditionLabel.text = conditonLabelStr;
    [self.nosuffientView changeHeight:_conditionLabel.bottom + 13];
    
    CGFloat lineHeight = self.nosuffientView.height - _conditionLineView.mj_y * 2;
    
    _conditionLineView.frame = CGRectMake(MSW - 60, _conditionLineView.mj_y, OnePX, lineHeight);
    
    _conditionButton.frame = CGRectMake(_conditionLineView.right, 0, MSW - _conditionLineView.right, self.nosuffientView.height);
    
    [self.tableHeaderViewYF changeHeight:XFrom5To6YF(52) + self.nosuffientView.height + YFNoSufientHeightTipLabel];
    
    self.grayView.frame = CGRectMake(0, self.nosuffientView.bottom, self.tableHeaderViewYF.width, 18);
    
    
    self.sumCarLabel.frame = CGRectMake(Width320(12), self.tableHeaderViewYF.bottom - YFNoSufientHeightTipLabel + 7, Width320(200), YFNoSufientHeightTipLabel);
    
    CGFloat offsetTop = self.nosuffientView.height + 12;
    
    _operationView.frame = CGRectMake(0, offsetTop, self.tableHeaderViewYF.width, GTWSelectOperationViewHeight);
    
    
    [self setTableHeadViewToTableView];
}

- (void)setTableHeadViewToTableView
{
    [self.tableView setTableHeaderView:self.tableHeaderViewYF];
    [self.tableView sendSubviewToBack:self.tableHeaderViewYF];
}

- (CardListInfo *)cardCountInfo
{
    if (_cardCountInfo == nil)
    {
        _cardCountInfo = [[CardListInfo alloc] init];
    }
    return _cardCountInfo;
}

@end
