//
//  ManageController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/11/10.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ManageController.h"

#import "ManageTopCell.h"

#import "ServicesInfo.h"

#import "GymListController.h"

#import "BrandListController.h"

#import "CourseListController.h"

#import "CourseArrangeController.h"

#import "MyStudentController.h"

#import "AllReportController.h"

#import "MyPlanController.h"

#import "GymDetailInfo.h"

#import "GymEditController.h"

#import "BrandListInfo.h"

#import "RootController.h"

#import "GuideGymSetController.h"

#import "GuideBrandSetController.h"

#import "BrandDetailController.h"

static NSString *headerIdentifier = @"Head";

static NSString *topIdentifier = @"Top";

static NSString *bottomIdentifier = @"Bottom";

@protocol ManageHeaderViewDelegate <NSObject>

-(void)editGym;

@end

@interface ManageHeaderView : UICollectionReusableView

{
    
    UIView *_gymDetailView;
    
    UILabel *_gymLabel;
    
    UILabel *_brandLabel;
    
    UIImageView *_iconView;
    
    UILabel *_textLabel;
    
}

@property(nonatomic,weak)id<ManageHeaderViewDelegate> delegate;

@property(nonatomic,assign)BOOL haveGymDetail;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *gymName;

@property(nonatomic,copy)NSString *brandName;

@property(nonatomic,copy)NSURL *iconURL;

@end

@implementation ManageHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(10), Height320(8), MSW-Width320(20), Height320(12))];
        
        _textLabel.textColor = UIColorFromRGB(0x666666);
        
        _textLabel.font = AllFont(10);
        
        [self addSubview:_textLabel];
        
    }
    
    return self;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _textLabel.text = _title;
    
}

-(void)setHaveGymDetail:(BOOL)haveGymDetail
{
    
    _haveGymDetail = haveGymDetail;
    
    if (_haveGymDetail) {
        
        if (!_gymDetailView) {
            
            _gymDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(64))];
            
            _gymDetailView.backgroundColor = UIColorFromRGB(0xffffff);
            
            _gymDetailView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
            
            _gymDetailView.layer.borderWidth = OnePX;
            
            [self addSubview:_gymDetailView];
            
            UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(0, _gymDetailView.height-OnePX, MSW, OnePX)];
            
            sep.backgroundColor = UIColorFromRGB(0xdddddd);
            
            [_gymDetailView addSubview:sep];
            
            _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(12), Height320(12), Width320(40), Height320(40))];
            
            _iconView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
            
            _iconView.layer.borderWidth = OnePX;
            
            _iconView.layer.cornerRadius = _iconView.width/2;
            
            _iconView.layer.masksToBounds = YES;
            
            _iconView.contentMode = UIViewContentModeScaleAspectFit;
            
            [_gymDetailView addSubview:_iconView];
            
            _gymLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconView.right+Width320(8), Height320(16), Width320(180), Height320(16))];
            
            _gymLabel.textColor = UIColorFromRGB(0x333333);
            
            _gymLabel.font = AllFont(14);
            
            [_gymDetailView addSubview:_gymLabel];
            
            _brandLabel = [[UILabel alloc]initWithFrame:CGRectMake(_gymLabel.left, _gymLabel.bottom+Height320(4), Width320(180), Height320(16))];
            
            _brandLabel.textColor = UIColorFromRGB(0x999999);
            
            _brandLabel.font = AllFont(12);
            
            [_gymDetailView addSubview:_brandLabel];
            
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(MSW-Width320(66), Height320(21), Width320(54), Height320(24))];
            
            button.layer.cornerRadius = 2;
            
            button.layer.borderWidth = OnePX;
            
            button.layer.borderColor = kMainColor.CGColor;;
            
            [button setTitle:@"编辑" forState:UIControlStateNormal];
            
            [button setTitleColor:kMainColor forState:UIControlStateNormal];
            
            button.titleLabel.font = AllFont(13);
            
            [_gymDetailView addSubview:button];
            
            [button addTarget:self.delegate action:@selector(editGym) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        _gymDetailView.hidden = NO;
        
        _textLabel.hidden = YES;
        
    }else{
        
        _gymDetailView.hidden = YES;
        
        _textLabel.hidden = NO;
        
        [_textLabel changeTop:Height320(8)];
        
    }
    
}

-(void)setGymName:(NSString *)gymName
{
    
    _gymName = gymName;
    
    _gymLabel.text = _gymName;
    
}

-(void)setBrandName:(NSString *)brandName
{
    
    _brandName = brandName;
    
    _brandLabel.text = _brandName;
    
}

-(void)setIconURL:(NSURL *)iconURL
{
    
    _iconURL = iconURL;
    
    [_iconView sd_setImageWithURL:_iconURL];
    
}

@end

@interface ManageController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ManageHeaderViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *titleArray;

@property(nonatomic,strong)ManageHeaderView *header;

@end

@implementation ManageController

+ (ManageController*)sharedSliderController
{
    static ManageController * sharedSVC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSVC = [[self alloc] init];
    });
    return sharedSVC;
}

- (instancetype)init
{
    
    self = [super init];
    
    if (self) {
        
        self.tabTitle = @"健身房";
        
        self.selectedImg = [UIImage imageNamed:@"manage_selected"];
        
        self.unselectImg = [UIImage imageNamed:@"manage_unselect"];
        
        self.titleArray = @[@{@"title":@"私教排期",@"image":@"manage_private"},@{@"title":@"团课排期",@"image":@"manage_group"},@{@"title":@"会员",@"image":@"manage_user"},@{@"title":@"课程报表",@"image":@"manage_course_report"},@{@"title":@"销售报表",@"image":@"manage_sale_report"}];
        
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

-(void)createData
{
    
    [self reloadData];
    
}


-(void)reloadData
{
    
    [[PermissionInfo sharedInfo]requestWithGym:AppGym result:^(BOOL success, NSString *error) {
        
    }];
    
    self.title = AppGym.name;
    
    [self.collectionView reloadData];
    
    if (AppGym) {
        
        GymDetailInfo *info = [[GymDetailInfo alloc]init];
        
        [info requestWithGym:AppGym result:^(BOOL success, NSString *error) {
            
            [self.collectionView.mj_header endRefreshing];
            
            self.title = AppGym.name;
            
            [self.collectionView reloadData];
            
        }];
        
    }
    
}

-(void)createUI
{
    
    self.leftTitle = @"切换健身房";
    
    self.title = AppGym.name;
    
    self.rightType = MONaviRightTypeMore;
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64-49) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    
    self.collectionView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.collectionView.dataSource = self;
    
    self.collectionView.delegate = self;
    
    if ([UIDevice currentDevice].systemVersion.floatValue>=10.0) {
        
        self.collectionView.prefetchingEnabled = NO;
        
    }
    
    [self.collectionView registerClass:[ManageTopCell class] forCellWithReuseIdentifier:topIdentifier];
    
    [self.collectionView registerClass:[ManageHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
    [self.view addSubview:self.collectionView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.collectionView.mj_header = header;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return (ceilf((float)[self.titleArray count]/3))*3;
    
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        
        ManageHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        
        self.header = header;
        
        header.haveGymDetail = YES;
        
        header.gymName = AppGym.name;
        
        header.brandName = AppGym.brand.name;
        
        header.iconURL = AppGym.imgUrl;
        
        header.delegate = self;
        
        return header;
        
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        
        footer.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(MSW/2-Width(67), Height(7), Width(134), Height(17))];
        
        label.text = @"更多健身房管理功能";
        
        label.textColor = UIColorFromRGB(0x999999);
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.font =AllFont(11);
        
        [footer addSubview:label];
        
        UIView *leftLine = [[UIView alloc]initWithFrame:CGRectMake(Width(15), Height(15), label.left-Width(15), OnePX)];
        
        leftLine.backgroundColor = UIColorFromRGB(0x999999);
        
        [footer addSubview:leftLine];
        
        UIView *rightLine = [[UIView alloc]initWithFrame:CGRectMake(label.right, leftLine.top, leftLine.width, OnePX)];
        
        rightLine.backgroundColor = UIColorFromRGB(0x999999);
        
        [footer addSubview:rightLine];
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, Height(30), MSW, Height(200))];
        
        img.image = [UIImage imageNamed:@"manage_back"];
        
        img.userInteractionEnabled = YES;
        
        [footer addSubview:img];
        
        UIButton *useButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW-Width(116), Height(145), Width(92), Height(32))];
        
        useButton.backgroundColor = kMainColor;
        
        useButton.layer.cornerRadius = Width(2);
        
        [useButton setTitle:@"立即使用" forState:UIControlStateNormal];
        
        [useButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
        useButton.titleLabel.font = AllFont(12);
        
        [img addSubview:useButton];
        
        [useButton addTarget:self action:@selector(useStaffApp) forControlEvents:UIControlEventTouchUpInside];
        
        return footer;
        
    }else
    {
        
        return nil;
        
    }
    
}

-(void)useStaffApp
{
    
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"qcstaff://"]]) {
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"qcstaff://"]];
        
    }else{
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/app/id1131440134"]];
        
    }
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(MSW/3, MSW/3);
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(MSW, Height320(64));
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    
    return CGSizeMake(MSW, Height(230));
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ManageTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:topIdentifier forIndexPath:indexPath];
    
    if (indexPath.row<self.titleArray.count) {
        
        NSDictionary *data = self.titleArray[indexPath.row];
        
        cell.title = data[@"title"];
        
        cell.image = [UIImage imageNamed:data[@"image"]];
        
    }else{
        
        cell.title = @"";
        
        cell.image = nil;
        
    }
    
    cell.haveTopLine = indexPath.row<3;
    
    cell.haveRightLine = indexPath.row%3<2;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
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
    
    return UIEdgeInsetsZero;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        if ([PermissionInfo sharedInfo].gym.permissions.privateArrangePermission.readState) {
            
            CourseArrangeController *svc = [[CourseArrangeController alloc]init];
            
            svc.courseType = CourseTypePrivate;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [self showNoPermissionAlert];
            
        }
        
    }else if (indexPath.row == 1){
        
        if ([PermissionInfo sharedInfo].gym.permissions.groupArrangePermission.readState) {
            
            CourseArrangeController *svc = [[CourseArrangeController alloc]init];
            
            svc.courseType = CourseTypeGroup;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [self showNoPermissionAlert];
            
        }
        
    }else if (indexPath.row == 2){
        
        if ([PermissionInfo sharedInfo].gym.permissions.userPermission.readState || [PermissionInfo sharedInfo].gym.permissions.personalUserPermission.readState) {
            
            MyStudentController *svc = [[MyStudentController alloc]init];
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [self showNoPermissionAlert];
            
        }
        
    }else if (indexPath.row == 3){
        
        if ([PermissionInfo sharedInfo].gym.permissions.courseReportPermission.readState ) {
            
            AllReportController *svc = [[AllReportController alloc]init];
            
            svc.type = ReportInfoTypeSchedule;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [self showNoPermissionAlert];
            
        }
        
    }else if (indexPath.row == 4){
        
        if ([PermissionInfo sharedInfo].gym.permissions.sellReportPermission.readState ||[PermissionInfo sharedInfo].gym.permissions.personalSellReportPermission.readState) {
            
            AllReportController *svc = [[AllReportController alloc]init];
            
            svc.type = ReportInfoTypeSell;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [self showNoPermissionAlert];
            
        }
        
    }
    
}

-(void)naviLeftClick
{
    
    GymListController *svc = [[GymListController alloc]init];
    
    [self presentViewController:svc animated:YES completion:^{
        
    }];
    
}

-(void)editGym
{
    
    PermissionInfo *info = [[PermissionInfo alloc]init];
    
    [info requestStaffPermissionWithGym:AppGym result:^(BOOL success, NSString *error) {
        
        if (info.permissions.studioPermission.editState) {
            
            GymEditController *svc = [[GymEditController alloc]init];
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [self showNoPermissionAlert];
            
        }
        
    }];
    
}

-(void)naviRightClick
{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:[NSString stringWithFormat:@"退出%@·%@",AppGym.brand.name,AppGym.name], nil];
    
    [actionSheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"确定退出%@·%@",AppGym.brand.name,AppGym.name] message:@"退出后将无法恢复，需由该健身房工作人员重新添加。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        alert.tag = 103;
        
        [alert show];
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 103){
        
        if (buttonIndex == 1) {
            
            [self quitGym];
            
        }
        
    }
    
}

-(void)quitGym
{
    
    GymDetailInfo *info = [[GymDetailInfo alloc]init];
    
    [info quitGymResult:^(BOOL success, NSString *error) {
        
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
        
        [self.view addSubview:hud];
        
        hud.mode = MBProgressHUDModeText;
        
        if (success) {
            
            hud.label.text = @"退出成功";
            
            [hud showAnimated:YES];
            
            [hud hideAnimated:YES afterDelay:1.5];
            
            [[ServicesInfo shareInfo]requestSuccess:^{
                
                if ([ServicesInfo shareInfo].services.count >0) {
                    
                    NSInteger lastGymId = [[NSUserDefaults standardUserDefaults]integerForKey:@"lastGymId"];
                    
                    Gym *gym;
                    
                    if (lastGymId) {
                        
                        for (Gym *tempGym in [ServicesInfo shareInfo].services) {
                            
                            if (tempGym.gymId == lastGymId) {
                                
                                gym = tempGym;
                                
                            }
                            
                        }
                        
                    }
                    
                    if (gym) {
                        
                        AppGym = gym;
                        
                    }else{
                        
                        AppGym = [[ServicesInfo shareInfo].services firstObject];
                        
                    }
                    
                    MOAppDelegate.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[RootController sharedSliderController]];
                    
                    [[RootController sharedSliderController]reloadData];
                    
                }else{
                    
                    BrandListInfo *brandInfo = [[BrandListInfo alloc]init];
                    
                    [brandInfo requestResult:^(BOOL success, NSString *error) {
                        
                        if (success) {
                            
                            if (!MOAppDelegate.guide) {
                                
                                MOAppDelegate.guide = [[Guide alloc]init];
                                
                            }
                            
                            if (brandInfo.brands.count) {
                                
                                BrandListController *vc = [[BrandListController alloc]init];
                                
                                vc.isGuide = YES;
                                
                                MOAppDelegate.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:vc];
                                
                            }else{
                                
                                GuideBrandSetController *vc = [[GuideBrandSetController alloc]init];
                                
                                MOAppDelegate.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:vc];
                                
                            }
                            
                        }else{
                            
                            MOAppDelegate.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[RootController sharedSliderController]];
                            
                            [[RootController sharedSliderController]reloadData];
                            
                        }
                        
                    }];
                    
                }
                
            } Failure:^{
                
                AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                
                appdelegate.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[RootController sharedSliderController]];
                
            }];
            
        }else{
            
            hud.label.text = error;
            
            [hud showAnimated:YES];
            
            [hud hideAnimated:YES afterDelay:1.5];
            
        }
        
    }];
    
}

-(void)pushWithBrand:(Brand *)brand
{
    
    BrandDetailController *svc = [[BrandDetailController alloc]init];
    
    svc.brand = brand;
    
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)addGym
{
    
    BrandListController *svc = [[BrandListController alloc]init];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

@end
