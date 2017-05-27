
//
//  GymDetailController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/3.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "GymDetailController.h"

#import "GymDetailInfo.h"

#import "HomeTopCell.h"

#import "FunctionCell.h"

#import "YFModuleManager.h"

#import "WebViewController.h"

#import "MOCycleView.h"

#import "BrandListController.h"

#import "RenewHintView.h"

#import "LoginController.h"

#import "CheckinController.h"

#import "MessageInfo.h"

#import "MessageController.h"

#import "CheckinHistoryController.h"

#import "RootController.h"

#import "RenewHistoryController.h"

#import "ServicesInfo.h"

#import "BrandListInfo.h"

#import "GuideCreateBrandController.h"

#import "GuideSetGymController.h"

#import "HomeController.h"

#import "MOActionSheet.h"

#import "GymProController.h"

#import "YFHttpService.h"
#import "YFAppConfig.h"

#import "GymProHintView.h"
#import "CardDetailController.h"

#import "GymTrySuccessAlert.h"

#import "GymHomePageController.h"

#import "AllFunctionInfo.h"

#import "YFHomeLineChartView.h"
#import "YFHomeLineChartDataModel.h"

#import "QingChengHandler.h"

#import "AllReportController.h"

#import "GymProInfo.h"

#import "ChatHeader.h"

#import "BrandDetailController.h"

#import "BrandDetailInfo.h"

#define kMinRemainDays 7

#define HelpURL @"http://cloud.qingchengfit.cn/mobile/urls/885f339caa124675a36a17a8ca4977d5/"

static NSString *topIdentifier = @"TopCell";

static NSString *identifier = @"Cell";

@protocol GymDetailDelegate <NSObject>

@optional

-(void)preview;

-(void)renew;

-(void)help;

@end

@interface GymDetailHeader : UIView

{
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UIImageView *_iconView;
    
    UILabel *_proLabel;
    
    UIButton *_renewButton;
    
}



@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *subtitle;

@property(nonatomic,copy)NSURL *iconURL;

@property(nonatomic,assign)id<GymDetailDelegate> delegate;

@property(nonatomic,assign)BOOL pro;

@end

@implementation GymDetailHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(12), Height320(12), Width320(40), Height320(40 ))];
        
        _iconView.backgroundColor = UIColorFromRGB(0xffffff);
        
        _iconView.layer.borderWidth = 2;
        
        _iconView.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
        
        _iconView.layer.cornerRadius = _iconView.width/2;
        
        _iconView.layer.masksToBounds = YES;
        
        [self addSubview:_iconView];
        
        self.backgroundColor = UIColorFromRGB(0x4E4E4E);
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconView.right+Width320(12), Height320(15), Width320(150), Height320(18))];
        
        _titleLabel.textColor = UIColorFromRGB(0xffffff);
        
        _titleLabel.font = AllFont(14);
        
        [self addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(2), Width320(150), Height320(15))];
        
        _subtitleLabel.textColor = UIColorFromRGB(0xffffff);
        
        _subtitleLabel.font = AllFont(12);
        
        [self addSubview:_subtitleLabel];
        
        _renewButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(245), Height320(20), Width320(60), Height320(27))];
        
        _renewButton.layer.cornerRadius = 2;
        
        _renewButton.layer.borderColor = kMainColor.CGColor;
        
        _renewButton.layer.borderWidth = 1;
        
        [_renewButton setTitle:@"续费" forState:UIControlStateNormal];
        
        [_renewButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
        _renewButton.titleLabel.font = AllFont(14);
        
        [self addSubview:_renewButton];
        
        [_renewButton addTarget:self.delegate action:@selector(renew) forControlEvents:UIControlEventTouchUpInside];
        
        _proLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.right+Width320(2), Height320(18), Width320(21), Height320(12))];
        
        _proLabel.layer.cornerRadius = _proLabel.height/2;
        
        _proLabel.layer.masksToBounds = YES;
        
        _proLabel.textAlignment = NSTextAlignmentCenter;
        
        _proLabel.textColor = UIColorFromRGB(0xffffff);
        
        _proLabel.font = AllFont(7);
        
        [self addSubview:_proLabel];
        
    }
    return self;
}

-(void)setPro:(BOOL)pro
{
    
    _pro = pro;
    
    _renewButton.backgroundColor = _pro?UIColorFromRGB(0x4E4E4E):kMainColor;
    
    [_renewButton setTitle:_pro?@"续费":@"升级" forState:UIControlStateNormal];
    
    [_renewButton setTitleColor:_pro?kMainColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    _proLabel.text = _pro?@"PRO":@"FREE";
    
    _proLabel.backgroundColor = _pro?kMainColor:UIColorFromRGB(0xD0D0D0);
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
    CGSize size = [_title boundingRectWithSize:CGSizeMake(Width320(150), Height320(18)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(14)} context:nil].size;
    
    [_titleLabel changeWidth:size.width];
    
    [_proLabel changeLeft:_titleLabel.right+Width320(2)];
    
}

-(void)setSubtitle:(NSString *)subtitle
{
    
    _subtitle = subtitle;
    
    _subtitleLabel.text = _subtitle;
    
}

-(void)setIconURL:(NSURL *)iconURL
{
    
    _iconURL = iconURL;
    
    [_iconView sd_setImageWithURL:_iconURL];
    
}

@end

@interface GymDetailFooter : UICollectionReusableView

@property(nonatomic,strong)UIButton *previewButton;

@property(nonatomic,assign)id<GymDetailDelegate>delegate;

@end

@implementation GymDetailFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        self.previewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.previewButton.frame = CGRectMake(MSW/2-Width320(60), Height320(16), Width320(120), Height320(27));
        
        self.previewButton.backgroundColor = UIColorFromRGB(0xfafafa);
        
        self.previewButton.layer.borderColor = kMainColor.CGColor;
        
        self.previewButton.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
        self.previewButton.layer.cornerRadius = Width320(2);
        
        [self.previewButton setTitle:@"会员端页面" forState:UIControlStateNormal];
        
        [self.previewButton setTitleColor:kMainColor forState:UIControlStateNormal];
        
        self.previewButton.titleLabel.font = AllFont(12);
        
        [self.previewButton addTarget:self.delegate action:@selector(preview) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.previewButton];
        
        UIButton *helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        helpButton.frame = CGRectMake(MSW/2-Width320(54), self.height-Height320(38),Width320(108), Height320(27));
        
        [helpButton addTarget:self.delegate action:@selector(help) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:helpButton];
        
        UIImageView *helpImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(18), Height320(7), Width320(13), Height320(13))];
        
        helpImg.image = [[UIImage imageNamed:@"hint_circle"]imageWithTintColor:UIColorFromRGB(0xbbbbbb)];
        
        [helpButton addSubview:helpImg];
        
        UILabel *helpLabel = [[UILabel alloc]initWithFrame:CGRectMake(helpImg.right+Width320(4), 0, helpButton.width-helpImg.right-Width320(4), helpButton.height)];
        
        helpLabel.text = @"如何使用？";
        
        helpLabel.textColor = UIColorFromRGB(0x888888);
        
        helpLabel.font = AllFont(12);
        
        [helpButton addSubview:helpLabel];
        
    }
    
    return self;
    
}

@end

@interface GymDetailController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,GymDetailDelegate,UIAlertViewDelegate,RenewHintViewDelegate,MOActionSheetDelegate,GymTrySuccessAlertDelegate,GymProHintViewDelegate,YFHomeLineChartViewDelegate>

@property(nonatomic,strong)UIView *firstView;

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,assign)BOOL haveNew;

@property(nonatomic,strong)NSArray *banners;

@property(nonatomic,strong)NSArray *stats;

@property(nonatomic,strong)GymDetailHeader *headerView;

@property(nonatomic,strong)RenewHintView *hintView;

@property(nonatomic,strong)NSMutableArray *funcs;

@property(nonatomic,strong)YFHomeLineChartView *lineChartsView;

@property(nonatomic, strong)YFHomeLineChartDataModel *homeHeaderDataModel;

@property(nonatomic,strong)Function *tryFunction;

@property(nonatomic,assign)BOOL hintShowed;


// 单场馆时 需要 请求得到 权限信息（havePower）
@property(nonatomic, strong)BrandDetailInfo *brandDetailInfo;

@end

@implementation GymDetailController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.tabTitle = @"健身房";
        
        self.unselectImg = [UIImage imageNamed:@"gym_unselect"];
        
        self.selectedImg = [UIImage imageNamed:@"gym_selected"];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:kModifyGymDetailIdtifierYF object:nil];

    }
    
    return self;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
}

-(void)createData
{
    [YFHttpService getUseNameComplete:^{
    }];
    
    if (!self.gym) {
        
        self.gym = AppGym;
        
    }else if(!AppGym){
        
        AppGym = self.gym;
    }
    
    [self reloadData];
    
    if (AppOneGym)
    {
        weakTypesYF
        
        BrandDetailInfo *detaiInfo = [BrandDetailInfo alloc];
        
        __weak typeof(detaiInfo)weakDetailInfo = detaiInfo;
        
        [detaiInfo requestWithBrand:AppGym.brand result:^(BOOL success, NSString *error, Brand *brand) {
            if (success) {
                
                AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;

                appdelegate.brand = brand;
                
                weakS.brandDetailInfo = weakDetailInfo;
            }
        }];

    }
}

-(void)reloadProSuccessData
{
    
    [self reloadData];
    
    if (self.tryFunction) {
        
        [self showTrySuccessAlert];
        
    }
    
}

-(void)reloadData
{
    
    if (self.gym) {
        
        AppGym = self.gym;
        
    }
    
    [self.collectionView reloadData];
    
    GymDetailInfo *info = [[GymDetailInfo alloc]init];
    
    [info requestWithGym:self.gym result:^(BOOL success, NSString *error,NSInteger errorCode) {
        
        self.gym = [AppGym copy];
       
        self.haveNew = info.haveNew;
        
        self.banners = [info.banners copy];
        
        self.stats = [info.stats copy];
        
        self.homeHeaderDataModel.dataArray = [self.stats mutableCopy];
        
        [self.lineChartsView bindDataArray:self.homeHeaderDataModel.dataArray];
        
        [RootController sharedSliderController].haveNew = self.haveNew;
        
        [self.collectionView.mj_header endRefreshing];
        
        if (!AppBrand) {
            
            AppBrand = AppGym.brand;
            
        }
        
        if (success) {
            
            self.title = self.gym.name;
            
            if (!self.hintShowed) {
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                
                dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
                
                dateFormatter.dateFormat = @"yyyy-MM-dd";
                
                NSInteger remainDays = [[dateFormatter dateFromString:self.gym.systemEnd] timeIntervalSinceDate:[dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]]]/86400;
                
                dateFormatter = nil;
                
                if (remainDays<kMinRemainDays && remainDays>=0) {
                    
                    self.hintShowed = YES;
                    
                    self.hintView.hidden = NO;
                    
                    [self.view bringSubviewToFront:self.hintView];
                    
                }else{
                    
                    self.hintView.hidden = YES;
                    
                }
                
                self.hintView.systemEnd = self.gym.systemEnd;
                
            }
            
            [self.collectionView reloadData];
            
            [self reloadDetailView];
            
            [[PermissionInfo sharedInfo]requestWithGym:self.gym result:^(BOOL success, NSString *error) {
                
                [self.collectionView reloadData];
                
            }];
            
        }else if (errorCode == SESSIONERROR){
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录失效，请重新登录" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            
            alert.tag = 102;
            
            [alert show];
            
        }
        
    }];
    
    AllFunctionInfo *funcInfo = [[AllFunctionInfo alloc]init];
    
    [funcInfo requestMyFunctionResult:^(BOOL success, NSString *error) {
        
        self.funcs = [funcInfo.myFunctions mutableCopy];
        
        Function *func = [[Function alloc]init];
        
        func.title = @"全部功能";
        
        func.key = @"all_func";
        
        func.imagePath = @"all_func";
        
        [self.funcs addObject:func];
        
        [self.collectionView reloadData];
        
        if (self.firstIn) {
            
            [self.collectionView performBatchUpdates:^{
                
            } completion:^(BOOL finished) {
                
                if (!self.firstView) {
                    
                    [self createFirstView];
                    
                }
                
                if (self.collectionView.contentSize.height>self.collectionView.height) {
                    
                    [self.collectionView setContentOffset:CGPointMake(0, self.collectionView.contentSize.height-self.collectionView.height) animated:YES];
                    
                }
                
                self.firstIn = NO;
                
                self.firstView.hidden = NO;
                
                [self.view bringSubviewToFront:self.firstView];
                
            }];
            
        }
        
    }];
    
}

-(void)reloadDetailView
{
    
    self.headerView.delegate = self;
    
    self.headerView.title = self.gym.name;
    
    self.headerView.subtitle = self.gym.admin.name.length?[NSString stringWithFormat:@"超级管理员：%@",self.gym.admin.name]:@"超级管理员：";
    
    self.headerView.iconURL = self.gym.imgUrl;
    
    self.headerView.pro = self.gym.pro;
    
}

-(void)createUI
{
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.title = self.gym.name;
    
    self.leftType = AppOneGym?MONaviLeftTypeTitle:MONaviLeftTypeBack;
    
    self.rightType =  MONaviRightTypeMore;
    
    self.titleType = MONaviTitleTypePull;
    
    if (AppOneGym) {
        
        self.leftTitle = @"添加场馆";
        
        self.leftColor = UIColorFromRGB(0xffffff);
        
    }
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, MSW, AppOneGym?MSH-64-49:MSH-64) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    
    self.collectionView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.collectionView.delegate = self;
    
    self.collectionView.dataSource = self;
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=10.0) {
        
        self.collectionView.prefetchingEnabled = NO;
        
    }
    
    [self.collectionView registerClass:[HomeTopCell class] forCellWithReuseIdentifier:topIdentifier];
    
    [self.collectionView registerClass:[FunctionCell class] forCellWithReuseIdentifier:identifier];
    
    [self.collectionView registerClass:[GymDetailHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cycleHeader"];
    
    [self.collectionView registerClass:[GymDetailFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"normalFooter"];
    
    [self.view addSubview:self.collectionView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.collectionView.mj_header = header;
    
    self.headerView = [[GymDetailHeader alloc]initWithFrame:CGRectMake(0, 64-Height320(67), MSW, Height320(67))];
    
    [self.view addSubview:self.headerView];
    
    self.hintView = [[RenewHintView alloc]initWithFrame:self.view.frame];
    
    self.hintView.delegate = self;
    
    [self.view addSubview:self.hintView];
    
    self.hintView.hidden = YES;
    
}

-(void)preview
{
    
    GymHomePageController *vc = [[GymHomePageController alloc]init];
    
    vc.url = self.gym.previewURL;
    
    AppGym.previewURL = self.gym.previewURL;
    
    AppGym.hintURL = self.gym.hintURL;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)createFirstView
{
    
    BOOL haveShow = [[NSUserDefaults standardUserDefaults]boolForKey:@"gym_hint_showed"];
    
    if (haveShow) {
        
        return;
        
    }
    
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"gym_hint_showed"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    self.firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, AppOneGym?MSH-49:MSH)];
    
    self.firstView.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.4];
    
    [self.view addSubview:self.firstView];
    
    UIButton *helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    NSInteger height = MIN(self.collectionView.height, self.collectionView.contentSize.height)+64;
    
    helpButton.frame = CGRectMake(MSW/2-Width320(54), height-Height320(38),Width320(108), Height320(27));
    
    helpButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    helpButton.layer.cornerRadius = 2;
    
    helpButton.layer.masksToBounds = YES;
    
    [helpButton addTarget:self action:@selector(help) forControlEvents:UIControlEventTouchUpInside];
    
    [self.firstView addSubview:helpButton];
    
    UIImageView *helpImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(18), Height320(7), Width320(13), Height320(13))];
    
    helpImg.image = [[UIImage imageNamed:@"hint_circle"]imageWithTintColor:kMainColor];
    
    [helpButton addSubview:helpImg];
    
    UILabel *helpLabel = [[UILabel alloc]initWithFrame:CGRectMake(helpImg.right+Width320(4), 0, helpButton.width-helpImg.right-Width320(4), helpButton.height)];
    
    helpLabel.text = @"如何使用？";
    
    helpLabel.textColor = kMainColor;
    
    helpLabel.font = AllFont(12);
    
    [helpButton addSubview:helpLabel];
    
    UIImageView *backView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW/2-Width320(135),helpButton.top-Height320(95)-Height320(8), Width320(270), Height320(95))];
    
    backView.image = [UIImage imageNamed:@"firstback"];
    
    [self.firstView addSubview:backView];
    
    [self.view bringSubviewToFront:self.firstView];
    
}

-(void)renewReturn
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)renew
{
    
    GymProController *svc = [[GymProController alloc]init];
    
    [self presentViewController:[[UINavigationController alloc]initWithRootViewController:svc] animated:YES completion:nil];
    
}

-(void)help
{
    
    if (self.firstView) {
        
        [self.firstView removeFromSuperview];
        
    }
    
    WebViewController *vc = [[WebViewController alloc]init];
    
    vc.url = [NSURL URLWithString:HelpURL];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)showRenewHistory
{
    
    RenewHistoryController *svc = [[RenewHistoryController alloc]init];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)renewConfirm
{
    
    GymProController *svc = [[GymProController alloc]init];
    
    [self presentViewController:[[UINavigationController alloc]initWithRootViewController:svc] animated:YES completion:nil];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 101) {
        
        [self reloadData];
        
    }else if(alertView.tag == 102){
        
        [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"staffId"];
        
        [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"sessionId"];
        
        [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"userSig"];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [self.navigationController popViewControllerAnimated:NO];
        
        [[TIMManager sharedInstance]logout:^{
            
        } fail:^(int code, NSString *msg) {
            
        }];
        
        [[RootController sharedSliderController]pushLogin];
        
        [[RootController sharedSliderController]reloadData];
        
    }else if (alertView.tag == 103){
        
        if (buttonIndex == 1) {
            
            [self quitGym];
            
        }
        
    }
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return (ceil((float)[self.funcs count]/4))*4;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    FunctionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if (indexPath.row<[self.funcs count]) {
        
        Function *func = self.funcs[indexPath.row];
        
        cell.title = func.title;
        
        cell.image = [UIImage imageNamed:func.imagePath];
        
        if (AppGym.pro) {
            
            cell.type = FunctionCellTypeFree;
            
        }else{
            
            cell.type = func.pro?FunctionCellTypePro:FunctionCellTypeFree;
            
        }
        
    }else
    {
        
        cell.title = nil;
        
        cell.image = nil;
        
        cell.type = FunctionCellTypeFree;
        
    }
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger width = MSW/4;
    
    return CGSizeMake(width, width);
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        return CGSizeMake(MSW, Height320(240));
        
    }else{
        
        return CGSizeZero;
        
    }
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    
    return CGSizeMake(MSW, Height320(90));
    
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cycleHeader" forIndexPath:indexPath];
        
        [header removeAllView];
        
        header.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        [header addSubview:self.lineChartsView];
        
        UIView *labelView = [[UIView alloc]initWithFrame:CGRectMake(0, self.lineChartsView.height, MSW, Height320(30))];
        
        labelView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        [header addSubview:labelView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(10), 0, MSW-Width320(20), Height320(30))];
        
        label.text = @"常用功能";
        
        label.textColor = UIColorFromRGB(0x666666);
        
        label.font = AllFont(10);
        
        [labelView addSubview:label];
        
        return header;
        
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        
        GymDetailFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        
        footer.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        footer.delegate = self;
        
        return footer;
        
    }else{
        
        return nil;
        
    }
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    NSInteger width = MSW/4;
    
    float gap = (MSW-width*4)/2;
    
    return UIEdgeInsetsMake(0, gap, 0, gap);
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row<[self.funcs count]) {
        
        Function *function = self.funcs[indexPath.row];
        
        if (function.pro && !AppGym.pro) {
            
            GymProHintView *hintView = [GymProHintView defaultView];
            
            hintView.title = function.title;
            
            hintView.delegate = self;
            
            hintView.canTry = !AppGym.haveTried;
            
            [hintView showInView:self.view];
            
            self.tryFunction = function;
            
        }else{
            
            UIViewController *vc = [QingChengHandler handlerOpenWithFunction:function];
            
            if (vc) {
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            
        }
        
    }
    
}

-(void)openWithFunction:(Function*)function
{
    
    UIViewController *vc = [QingChengHandler handlerOpenWithFunction:function];
    
    if (vc) {
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

-(void)naviLeftClick
{
    
    if (AppOneGym) {
        
        BrandListController *svc = [[BrandListController alloc]init];
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

-(void)naviRightClick
{
    
    if (AppOneGym)
    {
        MOActionSheet *sheet = [MOActionSheet actionSheetWithTitie:nil delegate:self destructiveButtonTitle:@"离职退出该场馆" cancelButtonTitle:@"取消" otherButtonTitles:@"品牌管理",nil];
        
        [sheet show];
    }else
    {
        MOActionSheet *sheet = [MOActionSheet actionSheetWithTitie:nil delegate:self destructiveButtonTitle:@"离职退出该场馆" cancelButtonTitle:@"取消" otherButtonTitles:nil];
        
        [sheet show];
    }
    
    
}

-(void)actionSheet:(MOActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (AppOneGym)
    {
        if (buttonIndex == 0) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"确定离职退出%@·%@",AppGym.brand.name,AppGym.name] message:@"离职退出后将无法恢复，需由该健身房工作人员重新添加。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            alert.tag = 103;
            
            [alert show];
            
        }
        else if (buttonIndex == 1)
        {
        
            AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            
            Brand *brand = appdelegate.brand;

            if (self.brandDetailInfo)
            {
                [self goToBrandDetailWithBrand:brand];
            }else
            {
                weakTypesYF
                [[BrandDetailInfo alloc] requestWithBrand:brand result:^(BOOL success, NSString *error, Brand *brand) {
                    if (success) {
                        
                        appdelegate.brand = brand;
                        
                        [weakS goToBrandDetailWithBrand:brand];
                    }
                }];
            }
        }
        return;
    }
    
    if (buttonIndex == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"确定离职退出%@·%@",AppGym.brand.name,AppGym.name] message:@"离职退出后将无法恢复，需由该健身房工作人员重新添加。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        alert.tag = 103;
        
        [alert show];
        
    }
}
    
- (void)goToBrandDetailWithBrand:(Brand *)brand
{
        if (brand.havePower) {
            
            BrandDetailController *svc = [[BrandDetailController alloc]init];
            
            svc.brand = [brand copy];
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            [[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"仅品牌创建人%@可编辑",brand.owner.name.length?brand.owner.name:@""] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        }
        
    }
-(void)quitGym
{
    
    GymDetailInfo *info = [[GymDetailInfo alloc]init];
    
    [info quitGymResult:^(BOOL success, NSString *error, NSInteger errorCode) {
        
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
        
        [self.view addSubview:hud];
        
        hud.mode = MBProgressHUDModeText;
        
        if (success) {
            
            hud.label.text = @"退出成功";
            AppGym = nil;
            AppBrand = nil;
            [hud showAnimated:YES];
            
            [hud hideAnimated:YES afterDelay:1.5];
            
            [[RootController sharedSliderController]createDataResult:^{
                
                MOAppDelegate.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[RootController sharedSliderController]];
        
            }];
            
        }else{
            
            hud.label.text = error;
            
            [hud showAnimated:YES];
            
            [hud hideAnimated:YES afterDelay:1.5];
            
        }
        
    }];
    
}

-(void)naviTitleClick
{
    
    [UIView animateWithDuration:0.4f animations:^{
        
        if (self.headerView.bottom <= 64) {
            
            [self.headerView changeTop:64];
            
        }else{
            
            [self.headerView changeTop:64-self.headerView.height];
            
        }
        
    }];
    
}

-(void)naviRightSubClick
{
    
    MessageController *svc = [[MessageController alloc]init];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)pushWithMessage:(Message *)message
{
    
    if ([message.url.absoluteString rangeOfString:@"/users/checkin/confirm/"].length||[message.url.absoluteString rangeOfString:@"/users/checkout/confirm/"].length) {
        
        CheckinController *svc = [[CheckinController alloc]init];
        
        svc.gym = self.gym;
        
        if ([message.url.absoluteString rangeOfString:@"/users/checkout/confirm/"].length){
            
            svc.shouldCheckout = YES;
            
        }
        
        if ([[((AppDelegate *)[UIApplication sharedApplication].delegate) getCurrentVC] isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController *naviVC = (UINavigationController*)[((AppDelegate *)[UIApplication sharedApplication].delegate) getCurrentVC];
            
            [naviVC pushViewController:svc animated:YES];
            
        }
        
    }else if ([message.url.absoluteString rangeOfString:@"/users/checkin/detail/"].length||[message.url.absoluteString rangeOfString:@"/users/checkout/details/"].length){
        
        CheckinHistoryController *svc = [[CheckinHistoryController alloc]init];
        
        if ([[((AppDelegate *)[UIApplication sharedApplication].delegate) getCurrentVC] isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController *naviVC = (UINavigationController*)[((AppDelegate *)[UIApplication sharedApplication].delegate) getCurrentVC];
            
            [naviVC pushViewController:svc animated:YES];
            
        }
        
    }else if (message.type == MessageTypeChangeSeller || message.type == MessageTypeChangeCoach)
    {
        
        // 记录message，等权限 请求成功，再去, 会员模块
        if ([PermissionInfo sharedInfo].gym.permissions.userPermission.readState || [PermissionInfo sharedInfo].gym.permissions.personalUserPermission.readState) {
            
            UIViewController *studentVC = [YFModuleManager memberFollowUpWithGym:self.gym dicArray:nil actionBlock:nil];
            
            [self.navigationController pushViewController:studentVC animated:YES];
        }else{
            [self showNoPermissionAlert];
        }
    }else if (message.type == MessageTypeWithoutSeller)
    {
        Seller *seller = [[Seller alloc] init];
        seller.type = SellerTypeNone;
        
        [self.navigationController pushViewController:[YFModuleManager belongSellerViewControllerWith:seller gym:self.gym] animated:YES];
    }else if (message.type == MessageTypeCardNoSufficient)
    {
        CardDetailController *svc = [[CardDetailController alloc]init];
        
        svc.card = [[Card alloc] init];
        
        svc.card.cardId = [message.cardId  integerValueYF];
        
        svc.gym = self.gym;
        
        [self.navigationController pushViewController:svc animated:YES];
    }
    
    AppMessage = nil;
}

-(void)dealloc
{
    
    if (!MOAppDelegate.gymBlock) {
        
        AppGym = nil;
        
    }else{
        
        MOAppDelegate.gymBlock = NO;
        
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    
}

-(void)showTrySuccessAlert
{
    
    GymTrySuccessAlert *alert = [GymTrySuccessAlert defaultAlert];
    
    alert.systemEnd = AppGym.systemEnd;
    
    alert.gymName = [AppGym.brand.name stringByAppendingString:AppGym.name];
    
    alert.delegate = self;
    
    [alert showInView:self.view];
    
}

-(void)trySuccessAlertStart
{
    
    UIViewController *vc = [QingChengHandler handlerOpenWithFunction:self.tryFunction];
    
    if (vc) {
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    self.tryFunction = nil;
    
    [self reloadData];
    
}

-(void)chartViewDidClickIndex:(NSInteger)index
{
    
    if (index == 0) {
        
        if ([PermissionInfo sharedInfo].gym.permissions.sellReportPermission.readState ||[PermissionInfo sharedInfo].gym.permissions.personalSellReportPermission.readState) {
            
            AllReportController *svc = [[AllReportController alloc]init];
            
            svc.type = ReportInfoTypeSell;
            
            svc.gym = AppGym;
            
            svc.isGym = YES;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [self showNoPermissionAlert];
            
        }
        
    }else if (index == 1){
        
        if ([PermissionInfo sharedInfo].gym.permissions.courseReportPermission.readState) {
            
            AllReportController *svc = [[AllReportController alloc]init];
            
            svc.type = ReportInfoTypeSchedule;
            
            svc.gym = AppGym;
            
            svc.isGym = YES;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [self showNoPermissionAlert];
            
        }
        
    }else if (index == 2){
        
        if ([PermissionInfo sharedInfo].gym.permissions.checkinReportPermission.readState) {
            
            AllReportController *svc = [[AllReportController alloc]init];
            
            svc.type = ReportInfoTypeCheckin;
            
            svc.gym = AppGym;
            
            svc.isGym = YES;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [self showNoPermissionAlert];
            
        }
        
    }else if (index == 3){
        
        if ([PermissionInfo sharedInfo].gym.permissions.userPermission.readState || [PermissionInfo sharedInfo].gym.permissions.personalUserPermission.readState) {
            
            UIViewController *studentVC = [YFModuleManager memberFollowUpWithGym:self.gym dicArray:nil actionBlock:nil];
            
            if (studentVC)
            {
                
                [self.navigationController pushViewController:studentVC animated:YES];
                
            }
            
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
