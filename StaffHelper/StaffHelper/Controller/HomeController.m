//
//  HomeController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/15.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "HomeController.h"

#import "HomeBrandCell.h"

#import "HomeCell.h"

#import "ProgrammeController.h"

#import "RootController.h"

#import "WebViewController.h"

#import "ReportController.h"

#import "CardKindListController.h"

#import "CardListController.h"

#import "MOCycleView.h"

#import "GuideCreateBrandController.h"

#import "ChangeBrandController.h"

#import "GymListController.h"

#import "AllReportController.h"

#import "LoginController.h"

#import "CourseListBrandController.h"

#import "MessageController.h"

#import "FunctionHintController.h"

#import "GymListInfo.h"

#import "ServicesInfo.h"

#import "YFAppConfig.h"

#import "YFHomeBrandGymCell.h"

#import "GymDetailController.h"

#import "YFAddNewGymCVCell.h"

#import "BrandDetailController.h"
#import "YFModuleManager.h"

#import "BrandCreateController.h"
#import "YFHomeLineChartView.h"
#import "YFHomeLineChartDataModel.h"

#import "ChatHeader.h"

static NSString *identifier = @"Cell";

static NSString *topIdentifier = @"Top";
static NSString *brandGymIdentifier = @"YFHomeBrandGymCell";
static NSString *addNewGymCVCell = @"YFAddNewGymCVCell.h";


static NSString *headerIdentifier = @"Head";


@interface HomeHeaderView : UICollectionReusableView

{
    
    UILabel *_textLabel;
    
}

@property(nonatomic,copy)NSString *title;



@end

@implementation HomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(10), Height320(8), MSW-Width320(20), Height320(12))];
        
        _textLabel.textColor = UIColorFromRGB(0x666666);
        
        _textLabel.font = AllFont(10);
        
        [self addSubview:_textLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, -0.5, frame.size.width, OnePX)];
        lineView.backgroundColor = YFLineViewColor;
        [self addSubview:lineView];
        
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height, frame.size.width, OnePX)];
        lineView2.backgroundColor = YFLineViewColor;
        [self addSubview:lineView2];
    }
    return self;
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _textLabel.text = _title;
    
}

@end

@interface HomeController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource,YFHomeLineChartViewDelegate>

@property(nonatomic,strong)YFHomeLineChartView *lineChartsView;

@property(nonatomic,strong)NSArray *titleArray;

@property(nonatomic,strong)UICollectionView *collectionView;
// 该品牌下的场馆 数组
@property(nonatomic,strong)NSMutableArray *brandListArray;

@property(nonatomic,strong)UIView *brandChooseView;

@property(nonatomic,strong)UITableView *brandTabelView;

@property(nonatomic, strong)YFHomeLineChartDataModel *homeHeaderDataModel;

@property(nonatomic,strong)UILabel *brandLabel;

@end

@implementation HomeController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.tabTitle = @"健身房";
        
        self.unselectImg = [UIImage imageNamed:@"gym_unselect"];
        
        self.selectedImg = [UIImage imageNamed:@"gym_selected"];
        
        self.leftType = MONaviLeftTypeNO;
        
        self.titleArray = @[@{@"连锁运营":@{@"title":@[@"会员通卡",@"课程共享",@"营销活动"],@"image":@[@"func_card_kind",@"func_course_type",@"func_marketing_activity"],@"module":@[@"",@"",@"activity/setting"]}},@{@"场馆":@{}}];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:kModifyGymDetailIdtifierYF object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:kAddNewGymIdtifierYF object:nil];
        
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+(HomeController *)sharedController
{
    
    static HomeController *homeVC;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        homeVC = [[self alloc]init];
        
    });
    
    return homeVC;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    self.collectionView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    // 该品牌下的场馆只要 请求数据，就清空之前的数据
    _brandListArray = nil;
    [self.collectionView reloadData];
    
    self.brandInfo = [[BrandListInfo alloc]init];
    
    self.homeInfo = [[HomeInfo alloc]init];
    
    weakTypesYF
    [self.brandInfo requestResult:^(BOOL success, NSString *error) {
        
        [weakS.brandTabelView reloadData];
        
        CGFloat tableHeight = weakS.brandInfo.brands.count*Height320(66)+Height320(40);
        
        [weakS.brandTabelView changeHeight:tableHeight>Height320(400)?Height320(400):tableHeight];
        
        if (success) {
            
            self.titleType = MONaviTitleTypeButtonDownAndUp;
            
            Brand *brand = [weakS checkBrand];
            
            [weakS creatListWithBrandCurrnetBrand:brand];
            
            [[PermissionInfo sharedInfo]requestWithBrand:brand result:^(BOOL success, NSString *error) {
                
                [self.homeInfo requestSuccess:^(NSInteger total) {
                    
                    weakS.homeHeaderDataModel.dataArray = [weakS.homeInfo.stats mutableCopy];
                    
                    [weakS.lineChartsView bindDataArray:weakS.homeHeaderDataModel.dataArray];
                    
                    [RootController sharedSliderController].haveNew = self.homeInfo.haveNew;
                    
                    [self.collectionView.mj_header endRefreshing];
                    
                    if (!total) {
                        
                        AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                        
                        appDelegate.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[GuideCreateBrandController alloc]init]];
                        
                    }else
                    {
                        
                        [self.collectionView reloadData];
                        
                    }
                    
                } failure:^(NSInteger errorCode){
                    
                    [self.collectionView.mj_header endRefreshing];
                    
                    if (errorCode == SESSIONERROR) {
                        
                        [[[UIAlertView alloc]initWithTitle:@"登录失效，请重新登录" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                        
                    }
                    
                }];
                
            }];
            
        }else
        {
            
            [self.collectionView.mj_header endRefreshing];
            
        }
        
    }];
    
}

-(void)reloadData
{
    
    // 该品牌下的场馆只要 请求数据，就清空之前的数据
    _brandListArray = nil;
    [self.collectionView reloadData];
    
    BrandListInfo *info = [[BrandListInfo alloc]init];
    weakTypesYF
    [info requestResult:^(BOOL success, NSString *error) {
        
        self.brandInfo = info;
        
        [weakS.brandTabelView reloadData];
        
        CGFloat tableHeight = weakS.brandInfo.brands.count*Height320(66)+Height320(40);
        
        [weakS.brandTabelView changeHeight:tableHeight>Height320(400)?Height320(400):tableHeight];
        
        if (success) {
            
            self.titleType = MONaviTitleTypeButtonDownAndUp;
            
            Brand *brand = [weakS checkBrand];
            
            [weakS creatListWithBrandCurrnetBrand:brand];
            
            [[PermissionInfo sharedInfo]requestWithBrand:brand result:^(BOOL success, NSString *error) {
                
                [self.homeInfo requestSuccess:^(NSInteger total) {
                    
                    weakS.homeHeaderDataModel.dataArray = [weakS.homeInfo.stats mutableCopy];
                    
                    [weakS.lineChartsView bindDataArray:weakS.homeHeaderDataModel.dataArray];
                    
                    [RootController sharedSliderController].haveNew = self.homeInfo.haveNew;
                    
                    [self.collectionView.mj_header endRefreshing];
                    
                    if (!total) {
                        
                        AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                        
                        appDelegate.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[GuideCreateBrandController alloc]init]];
                        
                    }else
                    {
                        
                        [self.collectionView reloadData];
                        
                    }
                    
                } failure:^(NSInteger errorCode){
                    
                    [self.collectionView.mj_header endRefreshing];
                    
                    if (errorCode == SESSIONERROR) {
                        
                        [[[UIAlertView alloc]initWithTitle:@"登录失效，请重新登录" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                        
                    }
                    
                }];
                
            }];
            
        }else
        {
            
            [self.collectionView.mj_header endRefreshing];
            
        }
        
    }];
    
}

// 检查品牌
- (Brand *)checkBrand
{
    AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    Brand *brand = appdelegate.brand;
    
    if (!brand && self.brandInfo.brands.count) {
        
        NSInteger lastBrandId = [[NSUserDefaults standardUserDefaults]integerForKey:@"last_brand_id"];
        
        if (lastBrandId) {
            
            for (Brand *infoBrand in self.brandInfo.brands) {
                
                if (infoBrand.brandId == lastBrandId) {
                    
                    appdelegate.brand = infoBrand;
                    
                }
                
            }
            
        }
        
        if (!appdelegate.brand) {
            // 找到 第一个 有场馆的品牌
            for (Brand *tempBrand in self.brandInfo.brands)
            {
                if (tempBrand.gymCount > 0)
                {
                    appdelegate.brand = tempBrand;
                    
                    break;
                }
            }
            // 都没有场馆 第一个品牌
            if (!appdelegate.brand)
            {
                Brand *tempBrand = [self.brandInfo.brands firstObject];
                
                appdelegate.brand = tempBrand;
            }
        }
        
        brand = appdelegate.brand;
    }
    
    self.title = appdelegate.brand.name;
    
    return brand;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"sessionId"];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"phone"];
    
    [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"staffId"];
    
    [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"pushVersion"];
    
    [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"course"];
    
    [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"userSig"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    [[TIMManager sharedInstance]logout:^{
        
    } fail:^(int code, NSString *msg) {
        
    }];
    
    [ServicesInfo shareInfo].services = [NSArray array];
    
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    
    MOAppDelegate.course = [[Course alloc]initNewCourse];
    
    [MOAppDelegate saveCourse];
    
    AppBrand = nil;
    
    AppGym = nil;
    
    LoginController *vc = [[LoginController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    [[RootController sharedSliderController]reloadData];
    
}

-(void)createUI
{
    self.leftTitle = @"品牌管理";
    self.leftColor = [UIColor whiteColor];
    self.title = self.brandInfo.brands.count?((Brand*)[self.brandInfo.brands firstObject]).name:@"连锁管理";
    
    self.titleType = MONaviTitleTypeButtonDownAndUp;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-49-64) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    
    self.collectionView.dataSource = self;
    
    self.collectionView.delegate = self;
    
    self.collectionView.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [self.collectionView registerClass:[HomeCell class] forCellWithReuseIdentifier:identifier];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:topIdentifier];
    
    [self.collectionView registerClass:[YFHomeBrandGymCell class] forCellWithReuseIdentifier:brandGymIdentifier];
    
    [self.collectionView registerClass:[YFAddNewGymCVCell class] forCellWithReuseIdentifier:addNewGymCVCell];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    [self.collectionView registerClass:[HomeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
    [self.view addSubview:self.collectionView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.collectionView.mj_header = header;
    
    [self createBrandView];
    
    self.brandLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(10), Height320(8), MSW-Width320(20), Height320(12))];
    
    self.brandLabel.text = @"连锁运营功能";
    
    self.brandLabel.textColor = UIColorFromRGB(0x666666);
    
    self.brandLabel.font = AllFont(10);
    
}

-(void)createBrandView
{
    
    self.brandChooseView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.brandChooseView.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.4];
    
    self.brandChooseView.layer.masksToBounds = YES;
    
    [self.view addSubview:self.brandChooseView];
    
    self.brandChooseView.hidden = YES;
    
    UIView *tapView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.brandChooseView.width, self.brandChooseView.height)];
    
    [self.brandChooseView addSubview:tapView];
    
    [tapView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClick)]];
    
    CGFloat tableHeight = self.brandInfo.brands.count*Height320(66)+Height320(40);
    
    self.brandTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MSW, tableHeight>MSW-64?MSW-64:tableHeight)];
    
    self.brandTabelView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.brandTabelView.separatorInset = UIEdgeInsetsMake(0, Width320(64), 0, 0);
    
    self.brandTabelView.dataSource = self;
    
    self.brandTabelView.delegate = self;
    
    [self.brandTabelView registerClass:[HomeBrandCell class] forCellReuseIdentifier:@"brand"];
    
    [self.brandChooseView addSubview:self.brandTabelView];
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40))];
    
    addButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(Width320(64), 0, MSW-Width320(64), OnePX)];
    
    topLine.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [addButton addSubview:topLine];
    
    UIImageView *addImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(122), Height320(12), Width320(16), Height320(16))];
    
    addImg.image = [UIImage imageNamed:@"seller_add"];
    
    [addButton addSubview:addImg];
    
    UILabel *addLabel = [[UILabel alloc]initWithFrame:CGRectMake(addImg.right+Width320(8), 0, Width320(120), Height320(40))];
    
    addLabel.text = @"创建品牌";
    
    addLabel.textColor = kMainColor;
    
    addLabel.font = AllFont(14);
    
    [addButton addSubview:addLabel];
    
    self.brandTabelView.tableFooterView = addButton;
    
    [addButton addTarget:self action:@selector(addBrand) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)reloadBrandData
{
    
    [self.brandInfo requestResult:^(BOOL success, NSString *error) {
        
        CGFloat tableHeight = self.brandInfo.brands.count*Height320(66)+Height320(40);
        
        [self.brandTabelView changeHeight:tableHeight>Height320(400)?Height320(400):tableHeight];
        
        [self.brandTabelView reloadData];
        
    }];
    
}

-(void)addBrand
{
    
    [self titleClick];
    
    BrandCreateController *svc = [[BrandCreateController alloc]init];
    
    __weak typeof(self)weakS = self;
    
    svc.addFinish = ^{
        
        [weakS reloadBrandData];
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.brandInfo.brands.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(64);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeBrandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"brand"];
    
    Brand *brand = self.brandInfo.brands[indexPath.row];
    
    cell.imgURL = brand.imgURL;
    
    cell.title = brand.name;
    
    cell.subtitle = [NSString stringWithFormat:@"品牌ID：%@  创建人：%@",brand.cname.length?brand.cname:@"",brand.owner.name.length?brand.owner.name:@""];
    
    cell.choosed = brand.brandId == AppBrand.brandId;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Brand *brand = self.brandInfo.brands[indexPath.row];
    
    AppBrand = brand;
    
    [[NSUserDefaults standardUserDefaults]setInteger:brand.brandId forKey:@"last_brand_id"];
    
    [self.brandTabelView reloadData];
    
    self.title = brand.name;
    
    [self titleClick];
    
    [self reloadData];
    
}

-(void)showBrandView
{
    
    [RootController sharedSliderController].tabbarShadeView.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.4];
    
    [RootController sharedSliderController].tabbarShadeView.hidden = NO;
    
    self.brandChooseView.hidden = NO;
    
    [self.view bringSubviewToFront:self.brandChooseView];
    
    [self.brandTabelView changeTop:-self.brandTabelView.height];
    
    [UIView animateWithDuration:0.3f animations:^{
        
        [self.brandTabelView changeTop:0];
        
    }];
    
}

-(void)closeBrandView
{
    
    [UIView animateWithDuration:0.3f animations:^{
        
        [self.brandTabelView changeTop:-self.brandTabelView.height];
        
    } completion:^(BOOL finished) {
        
        self.brandChooseView.hidden = YES;
        
        [RootController sharedSliderController].tabbarShadeView.hidden = YES;
        
        self.brandTabelView.contentOffset = CGPointMake(0, 0);
        
    }];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return [self.titleArray count];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (section == 0)
    {
        
        return (ceilf((float)[[self.titleArray[section] valueForKey:[[self.titleArray[section] allKeys]firstObject]][@"title"] count]/3))*3;
        
    }else  if (section == 1)
    {
        return self.brandListArray.count == 0 ? 1:self.brandListArray.count;
    }
    return 0;
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader] && indexPath.section == 0) {
        
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        
        [header removeAllView];
        
        header.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        [header addSubview:self.lineChartsView];
        
        UIView *labelView = [[UIView alloc]initWithFrame:CGRectMake(0, self.lineChartsView.bottom, MSW, header.height-self.lineChartsView.bottom)];
        
        labelView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        labelView.layer.borderWidth = OnePX;
        
        labelView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        [header addSubview:labelView];
        
        [labelView addSubview:self.brandLabel];
        
        return header;
        
    }else if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        
        HomeHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        
        header.title = [[self.titleArray[indexPath.section] allKeys]firstObject];
        
        return header;
        
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter] && indexPath.section==self.titleArray.count-1){
        
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        
        footer.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        return footer;
        
    }else
    {
        
        return nil;
        
    }
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        
        CGFloat scale = (float)[UIScreen mainScreen].nativeScale;
        
        float minWidth = (MSW*scale/3-2)/scale;
        
        float maxWidth = (MSW*scale/3)/scale;
        
        if (indexPath.row%3 == 1) {
            
            return CGSizeMake(IPhone4_5_6_6P(106.0f, 106.0f, minWidth, minWidth), Height320(106));
            
        }else{
            
            return CGSizeMake(IPhone4_5_6_6P(106.5f, 106.5f, maxWidth, maxWidth), Height320(106));
            
        }
        
    }else
    {
        
        return CGSizeMake(MSW, Height320(82));
    }
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        NSInteger height = Height320(240);
        
        return CGSizeMake(MSW, height);
        
    }else
    {
        return CGSizeMake(MSW, Height320(26));
        
    }
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if(section == self.titleArray.count-1){
        
        return  self.brandListArray.count == 0?CGSizeZero : CGSizeMake(MSW, Height320(20));
        
    }else{
        
        return CGSizeZero;
        
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 0)
    {
        
        HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        if (indexPath.row<[[self.titleArray[indexPath.section] valueForKey:[[self.titleArray[indexPath.section] allKeys]firstObject]][@"title"] count]) {
            
            cell.title = [self.titleArray[indexPath.section] valueForKey:[[self.titleArray[indexPath.section] allKeys]firstObject]][@"title"][indexPath.row];
            
            cell.image = [UIImage imageNamed:[self.titleArray[indexPath.section] valueForKey:[[self.titleArray[indexPath.section] allKeys]firstObject]][@"image"][indexPath.row]];
        }else
        {
            cell.title = @"";
            cell.image = nil;
        }
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        
        return cell;
        
    }else
    {
        
        if (self.brandListArray.count > indexPath.row)
        {
            YFHomeBrandGymCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:brandGymIdentifier forIndexPath:indexPath];
            
            Gym *gym = self.brandListArray[indexPath.row];
            
            cell.title = [NSString stringWithFormat:@"%@",gym.name];
            
            cell.imageUrl = gym.imgUrl;
            
            cell.subtitle = [NSString stringWithFormat:@"联系方式：%@",gym.contact.length?gym.contact:@""];
            
            cell.position = [NSString stringWithFormat:@"我的职位：%@",gym.position.length?gym.position:@""];
            
            cell.pro = gym.pro;
            
            return cell;
            
        }else{
            
            YFAddNewGymCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:addNewGymCVCell forIndexPath:indexPath];
            
            AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            
            cell.brand =appdelegate.brand;
            cell.weakVC = self;
            
            cell.noGym = !self.brandListArray.count;
            
            return cell;
            
        }
        
    }
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 1/[UIScreen mainScreen].scale;
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 1/[UIScreen mainScreen].scale;
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(1/[UIScreen mainScreen].scale,0, 1/[UIScreen mainScreen].scale, 0);
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row>=[[self.titleArray[indexPath.section] valueForKey:[[self.titleArray[indexPath.section] allKeys]firstObject]][@"title"] count]) {
            
            return;
            
        }
        
        NSString *cellIdentifier = [self.titleArray[indexPath.section] valueForKey:[[self.titleArray[indexPath.section] allKeys]firstObject]][@"title"][indexPath.row];
        
        if ([cellIdentifier isEqualToString:@"会员通卡"]){
            
            if ([PermissionInfo sharedInfo].brandPermissions.cardKindPermission.readState) {
                
                CardKindListController *svc = [[CardKindListController alloc]init];
                
                [self.navigationController pushViewController:svc animated:YES];
                
            }else{
                
                [self showNoPermissionAlert];
                
            }
            
        }else if ([cellIdentifier isEqualToString:@"课程共享"]){
            
            if ([PermissionInfo sharedInfo].brandPermissions.groupPermission.readState || [PermissionInfo sharedInfo].brandPermissions.privatePermission.readState) {
                
                CourseListBrandController *svc = [[CourseListBrandController alloc]init];
                
                [self.navigationController pushViewController:svc animated:YES];
                
            }else{
                
                [self showNoPermissionAlert];
                
            }
            
        }else{
            
            if ([cellIdentifier isEqualToString:@"营销活动"]) {
                
                NSString *module = [self.titleArray[indexPath.section] valueForKey:[[self.titleArray[indexPath.section] allKeys]firstObject]][@"module"][indexPath.row];
                
                if ([PermissionInfo sharedInfo].permissions.activitySettingPermission.readState) {
                    
                    FunctionHintController *svc = [[FunctionHintController alloc]init];
                    
                    svc.module = module;
                    
                    [self.navigationController pushViewController:svc animated:YES];
                    
                }else{
                    
                    [self showNoPermissionAlert];
                    
                }
                
            }
            
        }
        
    }else
    {
        
        if (self.brandListArray.count <= indexPath.row)
        {
            return;
        }
        
        GymDetailController *svc = [[GymDetailController alloc]init];
        
        Gym *gym = self.brandListArray[indexPath.row];
        
        svc.gym = gym;
        
        ((AppDelegate*)[UIApplication sharedApplication].delegate).gym = gym;
        
        PermissionInfo *permissionInfo = [PermissionInfo sharedInfo];
        
        [permissionInfo requestWithGym:AppGym result:^(BOOL success, NSString *error) {
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }];
        
    }
    
}

-(void)naviTitleClick
{
    
    if (self.brandChooseView.hidden) {
        
        [self showBrandView];
        
    }else{
        
        [self closeBrandView];
        
    }
    
}

-(void)naviRightClick
{
    
    MessageController *svc = [[MessageController alloc]init];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

- (void)naviLeftClick
{
    AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    Brand *brand = appdelegate.brand;
    
    if (brand.havePower) {
        
        BrandDetailController *svc = [[BrandDetailController alloc]init];
        
        svc.brand = [brand copy];
        
        svc.brandCount = self.brandInfo.brands.count;

        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        [[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"仅品牌创建人%@可编辑",brand.owner.name.length?brand.owner.name:@""] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    }
}

- (void)creatListWithBrandCurrnetBrand:(Brand *)brand
{
    // 清空
    _brandListArray = [NSMutableArray array];
    [self.collectionView reloadData];
    
    ServicesInfo *gymInfo = [[ServicesInfo alloc] init];
    
    
    __weak typeof(gymInfo)weakInfo = gymInfo;
    
    weakTypesYF
    [gymInfo requestSuccess:^{
        // 清空之前的
        weakS.brandListArray = [NSMutableArray array];
        for (Gym *gym in weakInfo.services) {
            
            if (gym.brand.brandId == brand.brandId)
            {
                [weakS.brandListArray addObject:gym];
            }
        }
        [weakS.collectionView reloadData];
        [[ServicesInfo shareInfo] setServices:weakInfo.services];
        
    } Failure:^{
        [[ServicesInfo shareInfo] setServices:nil];
    }];
    
    //    [info requestWithBrand:brand result:^(BOOL success, NSString *error) {
    //
    //        if (success) {
    //            weakS.brandListModel= info;
    //            [self.collectionView reloadData];
    //        }
    //    }];
    
}

-(void)chartViewDidClickIndex:(NSInteger)index
{
    
    if (index == 0) {
        
        if ([PermissionInfo sharedInfo].permissions.sellReportPermission.readState ||[PermissionInfo sharedInfo].permissions.personalSellReportPermission.readState) {
            
            AllReportController *svc = [[AllReportController alloc]init];
            
            svc.type = ReportInfoTypeSell;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [self showNoPermissionAlert];
            
        }
        
    }else if (index == 1){
        
        if ([PermissionInfo sharedInfo].permissions.courseReportPermission.readState) {
            
            AllReportController *svc = [[AllReportController alloc]init];
            
            svc.type = ReportInfoTypeSchedule;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [self showNoPermissionAlert];
            
        }
        
    }else if (index == 2){
        
        if ([PermissionInfo sharedInfo].permissions.checkinReportPermission.readState) {
            
            AllReportController *svc = [[AllReportController alloc]init];
            
            svc.type = ReportInfoTypeCheckin;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [self showNoPermissionAlert];
            
        }
        
    }
    
}

#pragma mark Getter
- (YFHomeLineChartView *)lineChartsView
{
    if (!_lineChartsView) {
        _lineChartsView = [[YFHomeLineChartView alloc] initWithFrame:CGRectMake(0, 0, self.collectionView.width, YFHomeHeaderLineChartHeight)];
        
        _lineChartsView.delegate = self;
        
    }
    return _lineChartsView;
}
- (YFHomeLineChartDataModel *)homeHeaderDataModel
{
    if (!_homeHeaderDataModel) {
        _homeHeaderDataModel = [[YFHomeLineChartDataModel alloc] init];
    }
    return _homeHeaderDataModel;
}

@end
