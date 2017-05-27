//
//  CheckinController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CheckinController.h"

#import "CheckinCell.h"

#import "CheckoutCell.h"

#import "ChooseView.h"

#import "CheckinInfo.h"

#import "CheckoutInfo.h"

#import "UIImage+Category.h"

#import "CheckinQRCodeController.h"

#import "CheckinHistoryController.h"

#import "CheckinSettingController.h"

#import "CheckinManualController.h"

#import "CheckoutManualController.h"

#import "ChestSearchController.h"

#import "SearchStudentCell.h"

#import "CheckinSettingInfo.h"

#import "StudentListInfo.h"

#import "CheckSuccessView.h"

#import "UpYun.h"

#import "CheckinPhotoHistoryInfo.h"

#import <AVFoundation/AVFoundation.h>

#import "PictureShowController.h"

#import "CheckinCardSettingController.h"

#import "CheckinWaySettingController.h"

#import "MOTableView.h"

static NSString *checkinIdentifier = @"Checkin";

static NSString *checkoutIdentifier = @"Checkout";

static NSString *studentIdentifier = @"Student";

@protocol CheckHeaderDelegate;

@interface CheckTabelHeaderView : UIView

{
    
    UILabel *_qrcodeLabel;
    
    UILabel *_manualLabel;
    
    UIButton *_undealButton;
    
}

@property(nonatomic,assign)CheckType type;

@property(nonatomic,assign)BOOL undealNew;

@property(nonatomic,weak)id<CheckHeaderDelegate> delegate;

@end

@protocol CheckHeaderDelegate <NSObject>

-(void)manualCheckWithHeader:(CheckTabelHeaderView*)headerView;

-(void)checkReloadWithHeader:(CheckTabelHeaderView*)headerView;

-(void)showQRCodeWithHeader:(CheckTabelHeaderView*)headerView;

@end

@implementation CheckTabelHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        UIButton *checkButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(10), Height320(10), Width320(145), Height320(36))];
        
        checkButton.backgroundColor = UIColorFromRGB(0xffffff);
        
        checkButton.layer.cornerRadius = Width320(4);
        
        [self addSubview:checkButton];
        
        UIImageView *checkImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(36), Height320(11), Width320(14), Height320(14))];
        
        checkImg.image = [UIImage imageNamed:@"checkin_scan"];
        
        [checkButton addSubview:checkImg];
        
        _manualLabel = [[UILabel alloc]initWithFrame:CGRectMake(checkImg.right+Width320(8), 0, Width320(80), Height320(36))];
        
        _manualLabel.textColor = UIColorFromRGB(0x666666);
        
        _manualLabel.font = AllFont(13);
        
        [checkButton addSubview:_manualLabel];
        
        UIButton *qrcodeButton = [[UIButton alloc]initWithFrame:CGRectMake(checkButton.right+Width320(10), Height320(10), Width320(145), Height320(36))];
        
        qrcodeButton.backgroundColor = UIColorFromRGB(0xffffff);
        
        qrcodeButton.layer.cornerRadius = Width320(4);
        
        [self addSubview:qrcodeButton];
        
        [qrcodeButton addTarget:self action:@selector(qrcodeClick) forControlEvents:UIControlEventAllEvents];
        
        UIImageView *qrcodeImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(29), Height320(11), Width320(14), Height320(14))];
        
        qrcodeImg.image = [UIImage imageNamed:@"checkin_qrcode"];
        
        [qrcodeButton addSubview:qrcodeImg];
        
        _qrcodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(qrcodeImg.right+Width320(8), 0, Width320(80), Height320(36))];
        
        _qrcodeLabel.textColor = UIColorFromRGB(0x666666);
        
        _qrcodeLabel.font = AllFont(13);
        
        [qrcodeButton addSubview:_qrcodeLabel];
        
        _undealButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW/2-Width320(85), Height320(53), Width320(170), Height320(36))];
        
        [_undealButton setTitleColor:UIColorFromRGB(0xF9944E) forState:UIControlStateNormal];
        
        _undealButton.titleLabel.font = AllFont(12);
        
        [self addSubview:_undealButton];
        
        [_undealButton addTarget:self action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
        
        [checkButton addTarget:self action:@selector(check:) forControlEvents:UIControlEventTouchUpInside];
    
    }
    
    return self;
    
}

-(void)reload
{
    
    [self.delegate checkReloadWithHeader:self];
    
}

-(void)check:(UIButton*)button
{
    
    [self.delegate manualCheckWithHeader:self];
    
}

-(void)qrcodeClick
{
    
    [self.delegate showQRCodeWithHeader:self];
    
}

-(void)setType:(CheckType)type
{
    
    _type = type;
    
    if (_type == CheckTypeCheckin) {
        
        _qrcodeLabel.text = @"签到二维码";
        
        _manualLabel.text = @"手动签到";
        
    }else{
        
        _qrcodeLabel.text = @"签出二维码";
        
        _manualLabel.text = @"手动签出";
        
    }
    
}


-(void)setUndealNew:(BOOL)undealNew
{
    
    _undealNew = undealNew;
    
    if (_undealNew) {
        
        _undealButton.hidden = NO;
        
        [_undealButton setTitle:_type == CheckTypeCheckin?@"有新未处理签到，点击查看":@"有新未处理签出，点击查看" forState:UIControlStateNormal];
        
        [self changeHeight:Height320(91)];
        
    }else{
        
        _undealButton.hidden = YES;
        
        [self changeHeight:Height320(56)];
        
    }
    
}

@end

@interface CheckHintView : UIView

{
    
    UILabel *_titleLabel;
    
}

@property(nonatomic,copy)NSString *title;

@end

@implementation CheckHintView

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
}

@end

@interface CheckinController ()<UITableViewDelegate,MOTableViewDatasource,ChooseViewDatasource,CheckHeaderDelegate,UITextFieldDelegate,CheckinCellDelegate,CheckoutCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)MOTableView *checkinTableView;

@property(nonatomic,strong)MOTableView *checkoutTableView;

@property(nonatomic,strong)ChooseView *chooseView;

@property(nonatomic,strong)CheckinInfo *checkinInfo;

@property(nonatomic,strong)CheckinInfo *checkoutInfo;

@property(nonatomic,strong)CheckinInfo *codeInfo;

@property(nonatomic,strong)NSArray *checkins;

@property(nonatomic,strong)NSArray *checkouts;

@property(nonatomic,strong)UIView *checkView;

@property(nonatomic,strong)MOTableView *searchTableView;

@property(nonatomic,strong)UILabel *checkLabel;

@property(nonatomic,strong)UITextField *searchBar;

@property(nonatomic,strong)CheckinSettingInfo *settingInfo;

@property(nonatomic,strong)StudentListInfo *stuInfo;

@property(nonatomic,strong)NSArray *stuArray;

@property(nonatomic,strong)CheckSuccessView *successView;

@property(nonatomic,assign)BOOL isCheckining;

@property(nonatomic,assign)BOOL isCheckouting;

@property(nonatomic,assign)BOOL isDealing;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,strong)Student *student;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)UIView *lockView;

@property(nonatomic,assign)BOOL openCheckin;

@end

@implementation CheckinController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadData
{
    
    CheckinSettingInfo *usedInfo = [[CheckinSettingInfo alloc]init];
    
    [usedInfo requestUsedResult:^(BOOL success, NSString *error) {
        
        CheckinSettingInfo *cardInfo = [[CheckinSettingInfo alloc]init];
        
        [cardInfo requestUsedResult:^(BOOL success, NSString *error) {
            
            BOOL used = NO;
            
            for (CardKind *cardKind in cardInfo.cardKinds) {
                
                if (cardKind.isUsed) {
                    
                    used = YES;
                    
                    break;
                    
                }
                
            }
            
            self.openCheckin = usedInfo.openCheckin && used;
            
            CheckinSettingInfo *settingInfo = [[CheckinSettingInfo alloc]init];
            
            [settingInfo requestSettingResult:^(BOOL success, NSString *error) {
                
                self.settingInfo.checkinId = settingInfo.checkinId;
                
                self.settingInfo.autoChest = settingInfo.autoChest;
                
                self.settingInfo.checkoutId = settingInfo.checkoutId;
                
                self.settingInfo.autoReturn = settingInfo.autoReturn;
                
                [self reloadCheckinData];
                
                [self reloadCheckoutData];
                
                if (!usedInfo.openCheckin) {
                    
                    [self createLockView];
                    
                }else{
                    
                    [self.lockView removeFromSuperview];
                    
                    self.rightImg = [UIImage imageNamed:@"check_setting"];
                    
                }
                
            }];
            
        }];
        
    }];
    
}

-(void)createData
{
    
    CheckinSettingInfo *usedInfo = [[CheckinSettingInfo alloc]init];
    
    [usedInfo requestUsedResult:^(BOOL success, NSString *error) {
        
        CheckinSettingInfo *cardInfo = [[CheckinSettingInfo alloc]init];
        
        [cardInfo requestCardKindsResult:^(BOOL success, NSString *error) {
            
            BOOL used = NO;
            
            for (CardKind *cardKind in cardInfo.cardKinds) {
                
                if (cardKind.isUsed) {
                    
                    used = YES;
                    
                    break;
                    
                }
                
            }
            
            self.openCheckin = usedInfo.openCheckin && used;
            
            if ([PermissionInfo sharedInfo].permissions.checkinPermission.addState) {
                
                self.checkinInfo = [[CheckinInfo alloc]init];
                
                self.checkoutInfo = [[CheckinInfo alloc]init];
                
                [self.searchTableView reloadData];
                
                self.settingInfo = [[CheckinSettingInfo alloc]init];
                
                CheckinSettingInfo *settingInfo = [[CheckinSettingInfo alloc]init];
                
                [settingInfo requestSettingResult:^(BOOL success, NSString *error) {
                    
                    self.settingInfo.checkinId = settingInfo.checkinId;
                    
                    self.settingInfo.autoChest = settingInfo.autoChest;
                    
                    self.settingInfo.checkoutId = settingInfo.checkoutId;
                    
                    self.settingInfo.autoReturn = settingInfo.autoReturn;
                    
                    [self reloadCheckinData];
                    
                    [self reloadCheckoutData];
                    
                    if (!self.openCheckin) {
                        
                        [self createLockView];
                        
                    }else{
                        
                        [self.lockView removeFromSuperview];
                        
                        self.rightImg = [UIImage imageNamed:@"check_setting"];
                        
                    }
                    
                }];
                
                self.stuInfo = [[StudentListInfo alloc]init];
                
                [self.stuInfo requestAllDataWithGym:self.gym success:^{
                    
                    self.searchTableView.dataSuccess = YES;
                    
                    if (self.searchBar.text.length) {
                        
                        NSMutableArray *array = [NSMutableArray array];
                        
                        for (Student *stu in self.stuInfo.students) {
                            
                            if ([stu.name rangeOfString:self.searchBar.text].length || [stu.phone rangeOfString:self.searchBar.text].length) {
                                
                                [array addObject:stu];
                                
                            }
                            
                        }
                        
                        self.stuArray = [array copy];
                        
                        [self.searchTableView reloadData];
                        
                    }
                    
                } Failure:^{
                    
                    self.searchTableView.dataSuccess = NO;
                    
                }];
                
                self.codeInfo = [[CheckinInfo alloc]init];
                
                [self.codeInfo requestQRCodeResult:^(BOOL success, NSString *error) {
                    
                }];
                
            }else if([PermissionInfo sharedInfo].permissions.checkinSettingPermssion.editState){
                
                self.checkinTableView.dataSuccess = YES;
                
                self.checkoutTableView.dataSuccess = YES;
                
                self.settingInfo = [[CheckinSettingInfo alloc]init];
                
                [self.settingInfo requestCardKindsResult:^(BOOL success, NSString *error) {
                    
                    if (success) {
                        
                        CheckinSettingInfo *settingInfo = [[CheckinSettingInfo alloc]init];
                        
                        [settingInfo requestSettingResult:^(BOOL success, NSString *error) {
                            
                            self.settingInfo.checkinId = settingInfo.checkinId;
                            
                            self.settingInfo.autoChest = settingInfo.autoChest;
                            
                            self.settingInfo.checkoutId = settingInfo.checkoutId;
                            
                            self.settingInfo.autoReturn = settingInfo.autoReturn;
                            
                            if (!self.openCheckin) {
                                
                                [self createLockView];
                                
                            }else{
                                
                                [self.lockView removeFromSuperview];
                                
                                self.rightImg = [UIImage imageNamed:@"check_setting"];
                                
                            }
                            
                        }];
                        
                    }
                    
                }];
                
            }
            
        }];
        
    }];
    
}

-(void)createLockView
{
    
    self.rightType = MONaviRightTypeNO;
    
    if (!self.lockView) {
        
        self.lockView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
        
        self.lockView.backgroundColor = UIColorFromRGB(0xffffff);
        
        UIImageView *lockImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(76), Height320(58), Width320(168), Height320(144))];
        
        lockImg.image = [UIImage imageNamed:@"checkin_empty"];
        
        [self.lockView addSubview:lockImg];
        
        UILabel *lockLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, lockImg.bottom+Height320(18), MSW, Height320(25))];
        
        lockLabel.text = @"请先开启入场签到功能";
        
        lockLabel.textColor = UIColorFromRGB(0x333333);
        
        lockLabel.font = AllFont(18);
        
        lockLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.lockView addSubview:lockLabel];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(MSW/2-Width320(126), lockLabel.bottom+Height320(52), Width320(252), Height320(40))];
        
        button.backgroundColor = kMainColor;
        
        [button setTitle:@"开启入场签到" forState:UIControlStateNormal];
        
        [button setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
        button.titleLabel.font = AllFont(16);
        
        [self.lockView addSubview:button];
        
        [button addTarget:self action:@selector(openCheckin:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    [self.view addSubview:self.lockView];
    
    [self.view bringSubviewToFront:self.lockView];
    
}

-(void)openCheckin:(UIButton*)button
{
    
    if ([PermissionInfo sharedInfo].permissions.checkinSettingPermssion.editState) {
        
        CheckinSettingInfo *cardInfo = [[CheckinSettingInfo alloc]init];
        
        [cardInfo requestCardKindsResult:^(BOOL success, NSString *error) {
            
            if (success) {
                
                BOOL used = NO;
                
                for (CardKind *kind in cardInfo.cardKinds) {
                    
                    if (kind.isUsed) {
                        
                        used = YES;
                        
                        break;
                        
                    }
                    
                }
                
                if (used) {
                    
                    CheckinSettingInfo *info = [[CheckinSettingInfo alloc]init];
                    
                    [info changeCheckinUsed:YES result:^(BOOL success, NSString *error) {
                        
                        if (success) {
                            
                            self.openCheckin = YES;
                            
                            [self.lockView removeFromSuperview];
                            
                            self.rightImg = [UIImage imageNamed:@"check_setting"];
                            
                            CheckinSettingController *svc = [[CheckinSettingController alloc]init];
                            
                            [self.navigationController pushViewController:svc animated:YES];
                            
                        }else{
                            
                            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
                            
                            [self.view addSubview:hud];
                            
                            hud.mode = MBProgressHUDModeText;
                            
                            hud.label.text = error;
                            
                            [hud showAnimated:YES];
                            
                            [hud hideAnimated:YES afterDelay:1.5];
                            
                        }
                        
                    }];
                    
                }else{
                    
                    CheckinSettingController *svc = [[CheckinSettingController alloc]init];
                    
                    [self.navigationController pushViewController:svc animated:NO];
                    
                    CheckinWaySettingController *wayVC = [[CheckinWaySettingController alloc]init];
                    
                    wayVC.setting = YES;
                    
                    wayVC.info = [cardInfo copy];
                    
                    [self.navigationController pushViewController:wayVC animated:!AppGym.pro];
                    
                    if (AppGym.pro) {
                        
                        CheckinCardSettingController *cardVC = [[CheckinCardSettingController alloc]init];
                        
                        cardVC.info = wayVC.info;
                        
                        [self.navigationController pushViewController:cardVC animated:YES];
                        
                    }
                    
                }
                
            }else{
                
                MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
                
                [self.view addSubview:hud];
                
                hud.mode = MBProgressHUDModeText;
                
                hud.label.text = error;
                
                [hud showAnimated:YES];
                
                [hud hideAnimated:YES afterDelay:1.5];
                
            }
            
        }];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(void)reloadCheckinData
{
    
    __weak typeof(self)weakS = self;
    
    CheckinInfo *info = [[CheckinInfo alloc]init];
    
    [info requestCheckinDataWithCheckin:nil result:^(BOOL success, NSString *error) {
        
        weakS.checkinTableView.dataSuccess = success;
        
        if (success) {
            
            weakS.checkinInfo = info;
            
            weakS.checkinInfo.checkinNew = NO;
            
            weakS.checkins = weakS.checkinInfo.checkins;
            
            Checkin *checkin = [weakS.checkins firstObject];
            
            weakS.checkinInfo.lastCheckin = checkin;
            
            weakS.checkinTableView.tableFooterView.hidden = !weakS.checkins.count;
            
            [weakS.checkinTableView reloadData];
            
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakS getCheckinData];
            
        });
        
    }];
    
}

-(void)reloadCheckoutData
{
    
    __weak typeof(self)weakS = self;
    
    CheckinInfo *info = [[CheckinInfo alloc]init];
    
    [info requestCheckoutDataWithCheckout:nil result:^(BOOL success, NSString *error) {
        
        weakS.checkoutTableView.dataSuccess = success;
        
        if (success) {
            
            weakS.checkoutInfo = info;
            
            weakS.checkoutInfo.checkoutNew = NO;
            
            weakS.checkouts = weakS.checkoutInfo.checkouts;
            
            Checkout *checkout = [weakS.checkouts firstObject];
            
            weakS.checkoutInfo.lastCheckout = checkout;
            
            weakS.checkoutTableView.tableFooterView.hidden = !weakS.checkouts.count;
            
            [weakS.checkoutTableView reloadData];
            
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakS getCheckoutData];
            
        });
        
    }];
    
}

-(void)getCheckinData
{
    
    UINavigationController *nv = nil;
    
    UIViewController *currentVc = [((AppDelegate*)[UIApplication sharedApplication].delegate) getCurrentVC];
    
    if ([currentVc isKindOfClass:[UINavigationController class]]) {
        
        nv = (UINavigationController*)currentVc;
        
    }
    
    if (![nv.visibleViewController isKindOfClass:[CheckinController class]]||!self.openCheckin || self.isCheckining) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self getCheckinData];
            
        });
        
        return;
        
    }
    
    self.isCheckining = YES;
    
    __weak typeof(self)weakS = self;
    
    CheckinInfo *checkinInfo = [[CheckinInfo alloc]init];
    
    checkinInfo.lastCheckin = self.checkinInfo.lastCheckin;
    
    [checkinInfo requestCheckinDataWithCheckin:self.checkinInfo.lastCheckin result:^(BOOL success, NSString *error) {
        
        if (weakS) {
            
            weakS.isCheckining = NO;
            
            if (success) {
                
                weakS.checkinInfo.checkinNew = checkinInfo.checkinNew;
                
                [weakS.checkinTableView reloadData];
                
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [weakS getCheckinData];
                
            });
            
        }
        
    }];
    
}

-(void)getCheckoutData
{
    
    UINavigationController *nv = nil;
    
    UIViewController *currentVc = [((AppDelegate*)[UIApplication sharedApplication].delegate) getCurrentVC];
    
    if ([currentVc isKindOfClass:[UINavigationController class]]) {
        
        nv = (UINavigationController*)currentVc;
        
    }
    
    if (![nv.visibleViewController isKindOfClass:[CheckinController class]]||!self.openCheckin || self.isCheckouting) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self getCheckoutData];
            
        });
        
        return;
        
    }
    
    self.isCheckouting = YES;
    
    __weak typeof(self)weakS = self;
    
    CheckinInfo *checkoutInfo = [[CheckinInfo alloc]init];
    
    checkoutInfo.lastCheckout = self.checkoutInfo.lastCheckout;
    
    [checkoutInfo requestCheckoutDataWithCheckout:self.checkoutInfo.lastCheckout result:^(BOOL success, NSString *error) {
        
        if (weakS) {
            
            weakS.isCheckouting = NO;
            
            if (success) {
                
                weakS.checkoutInfo.checkoutNew = checkoutInfo.checkoutNew;
                
                [weakS.checkoutTableView reloadData];
                
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [weakS getCheckoutData];
                
            });
            
        }
        
    }];
    
}

-(void)checkReloadWithHeader:(CheckTabelHeaderView *)headerView
{
    
    if (headerView.type == CheckTypeCheckin) {
        
        self.checkinInfo.checkinNew = NO;
        
        [self reloadCheckinData];
        
    }else{
        
        self.checkoutInfo.checkoutNew = NO;
        
        [self reloadCheckoutData];
        
    }
    
}

-(void)createUI
{
    
    self.title = AppGym.name;
    
    self.rightImg = [UIImage imageNamed:@"check_setting"];
    
    self.chooseView = [[ChooseView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.chooseView.rowHeight = Height320(40);
    
    self.chooseView.rowGap = Width320(55);
    
    self.chooseView.rowWidth = Width320(86);
    
    self.chooseView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.chooseView.datasource = self;
    
    if (self.shouldCheckout) {
        
        [self.chooseView selectNum:2];
        
    }
    
    [self.view addSubview:self.chooseView];
    
    self.checkView = [[UIView alloc]initWithFrame:CGRectMake(MSW, self.chooseView.rowHeight+64, MSW, MSH-self.chooseView.rowHeight-64)];
    
    self.checkView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:self.checkView];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(56))];
    
    topView.backgroundColor = UIColorFromRGB(0xf1f1f1);
    
    [self.checkView addSubview:topView];
    
    self.searchBar = [[UITextField alloc]initWithFrame:CGRectMake(Width320(10), Height320(10), Width320(258), Height320(36))];
    
    self.searchBar.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.searchBar.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.searchBar.layer.borderWidth = OnePX;
    
    self.searchBar.placeholder = @"会员姓名/手机号";
    
    self.searchBar.font = AllFont(12);
    
    self.searchBar.layer.cornerRadius = 2;
    
    self.searchBar.layer.masksToBounds = YES;
    
    self.searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.searchBar.delegate = self;
    
    [self.searchBar addTarget:self action:@selector(searchBarDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width320(30), Height320(36))];
    
    self.searchBar.leftView = leftView;
    
    self.searchBar.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(8), Height320(12), Width320(14), Height320(13))];
    
    leftImg.image = [UIImage imageNamed:@"check_search_left_image"];
    
    [leftView addSubview:leftImg];
    
    [topView addSubview:self.searchBar];
    
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(self.searchBar.right, 0, MSW-self.searchBar.right, Height320(56))];
    
    cancelButton.backgroundColor = [UIColor clearColor];
    
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    
    [cancelButton setTitleColor:UIColorFromRGB(0x0DB14B) forState:UIControlStateNormal];
    
    cancelButton.titleLabel.font = AllFont(14);
    
    [topView addSubview:cancelButton];
    
    [cancelButton addTarget:self action:@selector(hideSearchView) forControlEvents:UIControlEventTouchUpInside];
    
    self.searchTableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, topView.bottom, MSW, self.chooseView.height-self.chooseView.rowHeight-topView.bottom) style:UITableViewStylePlain];
    
    self.searchTableView.dataSource = self;
    
    self.searchTableView.delegate = self;
    
    [self.searchTableView registerClass:[SearchStudentCell class] forCellReuseIdentifier:studentIdentifier];
    
    self.searchTableView.separatorInset = UIEdgeInsetsMake(0, Width320(68), 0, 0);
    
    self.searchTableView.tableFooterView = [UIView new];
    
    [self.checkView addSubview:self.searchTableView];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(void)searchBarDidChanged:(UITextField*)searchBar
{
    
    if (searchBar.text.length) {
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (Student *stu in self.stuInfo.students) {
            
            if ([[stu.name lowercaseString] rangeOfString:[searchBar.text lowercaseString]].length || [stu.phone rangeOfString:searchBar.text].length) {
                
                [array addObject:stu];
                
            }
            
        }
        
        self.stuArray = [array copy];
        
    }else{
        
        self.stuArray = [NSArray array];
        
    }
    
    [self.searchTableView reloadData];
    
}

-(UIView *)viewForButtonAtRow:(NSInteger)row
{
    
    if (row == 0) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width320(86), Height320(40))];
        
        UIImageView *checkinImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(20), Height320(14), Width320(12), Height320(12))];
        
        checkinImg.image = [UIImage imageNamed:@"checkin_button"];
        
        [view addSubview:checkinImg];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(checkinImg.right+Width320(6), Height320(12), Width320(50), Height320(16))];
        
        label.font = AllFont(14);
        
        label.autoSizeText = @"签到";
        
        [view addSubview:label];
        
        return view;
        
    }else{
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width320(86), Height320(50))];
        
        UIImageView *checkinImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(20), Height320(14), Width320(12), Height320(12))];
        
        checkinImg.image = [UIImage imageNamed:@"checkout_button"];
        
        [view addSubview:checkinImg];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(checkinImg.right+Width320(6), Height320(12), Width320(50), Height320(16))];
        
        label.font = AllFont(14);
        
        label.autoSizeText = @"签出";
        
        [view addSubview:label];
        
        return view;
        
    }
    
}

-(NSInteger)numberOfRowInChooseView
{
    
    return 2;
    
}

-(void)chooseButtonClick:(NSInteger)index
{
    
    [self hideSearchView];
    
}

-(UIScrollView *)viewForRow:(NSInteger)row
{
    
    if ([PermissionInfo sharedInfo].permissions.checkinPermission.addState) {
        
        if (row == 0) {
            
            self.checkinTableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 0, MSW, self.chooseView.height-self.chooseView.rowHeight)];
            
            self.checkinTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
            
            self.checkinTableView.tag = 101;
            
            self.checkinTableView.dataSource = self;
            
            self.checkinTableView.delegate = self;
            
            self.checkinTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            [self.checkinTableView registerClass:[CheckinCell class] forCellReuseIdentifier:checkinIdentifier];
            
            self.checkinTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(55))];
            
            UIButton *historyButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW/2-Width320(64), 0, Width320(130), Height320(28))];
            
            historyButton.layer.borderColor = UIColorFromRGB(0xbbbbbb).CGColor;
            
            historyButton.layer.borderWidth = 1/[UIScreen mainScreen].scale;
            
            [historyButton setTitle:@"查看3小时内签到记录" forState:UIControlStateNormal];
            
            [historyButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
            
            historyButton.titleLabel.font = AllFont(12);
            
            [self.checkinTableView.tableFooterView addSubview:historyButton];
            
            [historyButton addTarget:self action:@selector(history:) forControlEvents:UIControlEventTouchUpInside];
            
            self.checkinTableView.tableFooterView.hidden = YES;
            
            return self.checkinTableView;
            
        }else{
            
            self.checkoutTableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 0, MSW, self.chooseView.height-self.chooseView.rowHeight)];
            
            self.checkoutTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
            
            self.checkoutTableView.tag = 102;
            
            self.checkoutTableView.dataSource = self;
            
            self.checkoutTableView.delegate = self;
            
            self.checkoutTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            [self.checkoutTableView registerClass:[CheckoutCell class] forCellReuseIdentifier:checkoutIdentifier];
            
            self.checkoutTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(55))];
            
            UIButton *historyButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW/2-Width320(64), 0, Width320(130), Height320(28))];
            
            historyButton.layer.borderColor = UIColorFromRGB(0xbbbbbb).CGColor;
            
            historyButton.layer.borderWidth = 1/[UIScreen mainScreen].scale;
            
            [historyButton setTitle:@"查看3小时内签到记录" forState:UIControlStateNormal];
            
            [historyButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
            
            historyButton.titleLabel.font = AllFont(12);
            
            [self.checkoutTableView.tableFooterView addSubview:historyButton];
            
            [historyButton addTarget:self action:@selector(history:) forControlEvents:UIControlEventTouchUpInside];
            
            self.checkoutTableView.tableFooterView.hidden = YES;
            
            return self.checkoutTableView;
            
        }
        
    }else{
        
        UIScrollView *noPremissionView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, self.chooseView.height-self.chooseView.rowHeight)];
        
        noPremissionView.backgroundColor = UIColorFromRGB(0xffffff);
        
        UIImageView *noPremissionImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(76), Height320(117), Width320(168), Height320(132))];
        
        noPremissionImg.image = [UIImage imageNamed:@"no_premission"];
        
        [noPremissionView addSubview:noPremissionImg];
        
        UILabel *noPremissionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, noPremissionImg.bottom+Height320(18), MSW, Height320(18))];
        
        noPremissionLabel.text = @"抱歉，您无权限查看该模块";
        
        noPremissionLabel.textAlignment = NSTextAlignmentCenter;
        
        noPremissionLabel.textColor = UIColorFromRGB(0x999999);
        
        noPremissionLabel.font = AllFont(14);
        
        [noPremissionView addSubview:noPremissionLabel];
        
        if ([PermissionInfo sharedInfo].permissions.checkinPermission.readState) {
            
            UIButton *historyButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW/2-Width320(64), noPremissionView.height-Height320(62), Width320(130), Height320(28))];
            
            historyButton.layer.borderColor = UIColorFromRGB(0xbbbbbb).CGColor;
            
            historyButton.layer.borderWidth = 1/[UIScreen mainScreen].scale;
            
            [historyButton setTitle:@"查看3小时内签到记录" forState:UIControlStateNormal];
            
            [historyButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
            
            historyButton.titleLabel.font = AllFont(12);
            
            [noPremissionView addSubview:historyButton];
            
            [historyButton addTarget:self action:@selector(history:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        return noPremissionView;
        
    }
    
}

-(void)history:(UIButton*)button
{
 
    if ([PermissionInfo sharedInfo].permissions.checkinPermission.readState) {
        
        CheckinHistoryController *svc = [[CheckinHistoryController alloc]init];
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (tableView.tag == 101) {
        
        if (self.checkinInfo.checkinNew) {
            
            return Height320(91);
            
        }else{
            
            return Height320(56);
            
        }
        
    }else if (tableView.tag == 102)
    {
        
        if (self.checkoutInfo.checkoutNew) {
            
            return Height320(91);
            
        }else{
            
            return Height320(56);
            
        }
        
    }else{
        
        return 0;
        
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (tableView.tag == 101) {
        
        CheckTabelHeaderView *header = [[CheckTabelHeaderView alloc]initWithFrame:CGRectMake(0, 0, MSW, self.checkinInfo.checkinNew?Height320(91):Height320(56))];
        
        header.type = CheckTypeCheckin;
        
        header.undealNew = self.checkinInfo.checkinNew;
        
        header.delegate = self;
        
        return header;
        
    }else if (tableView.tag == 102)
    {
        
        CheckTabelHeaderView *header = [[CheckTabelHeaderView alloc]initWithFrame:CGRectMake(0, 0, MSW, self.checkoutInfo.checkoutNew?Height320(91):Height320(56))];
        
        header.type = CheckTypeCheckout;
        
        header.undealNew = self.checkoutInfo.checkoutNew;
        
        header.delegate = self;
        
        return header;
        
    }else{
        
        return nil;
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView.tag == 101) {
        
        return self.checkins.count;
        
    }else if(tableView.tag == 102){
        
        return self.checkouts.count;
        
    }else{
        
        return self.stuArray.count;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 101) {
        
        Checkin *checkin = self.checkins[indexPath.row];
        
        NSString *str = [NSString stringWithFormat:@"会员卡：%@",checkin.card.cardKind.cardKindName];
        
        NSString *remain = @"";
        
        switch (checkin.card.cardKind.type) {
                
            case CardKindTypePrepaid:
                
                remain = [NSString stringWithFormat:@"余额：%.0f元",checkin.card.remain];
                
                break;
                
            case CardKindTypeCount:
                
                remain = [NSString stringWithFormat:@"余额：%.0f次",checkin.card.remain];
                
                break;
                
            case CardKindTypeTime:
                
                remain = [NSString stringWithFormat:@"有效期：%@-%@",[checkin.card.start substringToIndex:10],[checkin.card.end substringToIndex:10]];
                
                break;
                
            default:
                break;
        }
        
        NSString *cardString = [NSString stringWithFormat:@"%@（%@）",str,remain];
        
        CGSize cardSize = [cardString boundingRectWithSize:CGSizeMake(MSW-Width320(82), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
        
        CGFloat height = checkin.card.cardKind.type == CardKindTypeTime?0:Height320(20);
        
        if (self.settingInfo.autoChest) {
            
            return checkin.courseBatches.count?Height320(207)+checkin.courseBatches.count*Height320(40)+cardSize.height+height:Height320(178)+cardSize.height+height;
            
        }else{
            
            return checkin.courseBatches.count?Height320(167)+checkin.courseBatches.count*Height320(40)+cardSize.height+height:Height320(138)+cardSize.height+height;
            
        }
        
    }else if(tableView.tag == 102){
        
        Checkout *checkout = self.checkouts[indexPath.row];
        
        NSString *str = [NSString stringWithFormat:@"会员卡：%@",checkout.card.cardKind.cardKindName];
        
        NSString *remain = @"";
        
        switch (checkout.card.cardKind.type) {
                
            case CardKindTypePrepaid:
                
                remain = [NSString stringWithFormat:@"余额：%.0f元",checkout.card.remain];
                
                break;
                
            case CardKindTypeCount:
                
                remain = [NSString stringWithFormat:@"余额：%.0f次",checkout.card.remain];
                
                break;
                
            case CardKindTypeTime:
                
                remain = [NSString stringWithFormat:@"有效期：%@-%@",[checkout.card.start substringToIndex:10],[checkout.card.end substringToIndex:10]];
                
                break;
                
            default:
                break;
        }
        
        NSString *cardString = [NSString stringWithFormat:@"%@（%@）",str,remain];
        
        CGSize cardSize = [cardString boundingRectWithSize:CGSizeMake(MSW-Width320(82), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
        
        if (checkout.chest) {
            
            return checkout.card.cardKind.type == CardKindTypeTime?Height320(157)+cardSize.height:Height320(177)+cardSize.height;
            
        }else{
            
            return checkout.card.cardKind.type == CardKindTypeTime?Height320(137)+cardSize.height:Height320(157)+cardSize.height;
            
        }
        
    }else{
        
        return Height320(72);
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 101) {
        
        CheckinCell *cell = [tableView dequeueReusableCellWithIdentifier:checkinIdentifier];
        
        cell.haveChest = self.settingInfo.autoChest;
        
        Checkin *checkin = self.checkins[indexPath.row];
        
        cell.name = checkin.student.name;
        
        cell.imgURL = checkin.student.photo;
        
        cell.sex = checkin.student.sex;
        
        cell.phone = checkin.student.phone;
        
        cell.cardName = checkin.card.cardKind.cardKindName;
        
        NSString *remain = @"";
        
        switch (checkin.card.cardKind.type) {
                
            case CardKindTypePrepaid:
                
                remain = [NSString stringWithFormat:@"余额：%.0f元",checkin.card.remain];
                
                break;
                
            case CardKindTypeCount:
                
                remain = [NSString stringWithFormat:@"余额：%.0f次",checkin.card.remain];
                
                break;
                
            case CardKindTypeTime:
                
                remain = [NSString stringWithFormat:@"有效期：%@-%@",[checkin.card.start substringToIndex:10],[checkin.card.end substringToIndex:10]];
                
                break;
                
            default:
                break;
        }
        
        cell.remain = remain;
        
        if (checkin.card.cardKind.type != CardKindTypeTime) {
            
            cell.price = [NSString stringWithFormat:checkin.card.cardKind.type == CardKindTypePrepaid?@"%ld元":@"%ld次",(long)checkin.card.cardKind.cost];
            
        }else{
            
            cell.price = @"";
            
        }
        
        cell.courseBatches = checkin.courseBatches;
        
        if (cell.haveChest && checkin.chest.chestId) {
            
            cell.chest = checkin.chest.name;
            
        }
        
        cell.tag = indexPath.row;
        
        cell.delegate = self;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else if(tableView.tag == 102){
        
        CheckoutCell *cell = [tableView dequeueReusableCellWithIdentifier:checkoutIdentifier];
        
        Checkout *checkout = self.checkouts[indexPath.row];
        
        cell.name = checkout.student.name;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.tag = indexPath.row;
        
        cell.name = checkout.student.name;
        
        cell.iconURL = checkout.student.photo;
        
        cell.sex = checkout.student.sex;
        
        cell.phone = checkout.student.phone;
        
        cell.cardName = checkout.card.cardKind.cardKindName;
        
        NSString *remain = @"";
        
        switch (checkout.card.cardKind.type) {
                
            case CardKindTypePrepaid:
                
                remain = [NSString stringWithFormat:@"余额：%.0f元",checkout.card.remain];
                
                break;
                
            case CardKindTypeCount:
                
                remain = [NSString stringWithFormat:@"余额：%.0f次",checkout.card.remain];
                
                break;
                
            case CardKindTypeTime:
                
                remain = [NSString stringWithFormat:@"有效期：%@-%@",[checkout.card.start substringToIndex:10],[checkout.card.end substringToIndex:10]];
                
                break;
                
            default:
                break;
        }
        
        cell.remain = remain;
        
        if (checkout.card.cardKind.type != CardKindTypeTime) {
            
            cell.price = [NSString stringWithFormat:checkout.card.cardKind.type == CardKindTypePrepaid?@"%ld元":@"%ld次",(long)checkout.card.cardKind.cost];
            
        }else{
            
            cell.price = @"";
            
        }
        
        if (checkout.chest) {
            
            cell.chestName = checkout.chest.name;
            
        }
        
        cell.checkinTime = checkout.createdTime;
        
        cell.delegate = self;
        
        return cell;
        
    }else{
        
        SearchStudentCell *cell = [tableView dequeueReusableCellWithIdentifier:studentIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        Student *stu = self.stuArray[indexPath.row];
        
        cell.title = stu.name;
        
        cell.sex = stu.sex;
        
        cell.phone = stu.phone;
        
        cell.imgUrl = stu.photo;
        
        return cell;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 103) {
        
        Student *stu = self.stuArray[indexPath.row];
        
        CheckinManualController *svc = [[CheckinManualController alloc]init];
        
        svc.stu = stu;
        
        svc.settingInfo = self.settingInfo;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else if (tableView.tag == 104){
        
        Student *stu = self.stuArray[indexPath.row];
        
        CheckoutManualController *svc = [[CheckoutManualController alloc]init];
        
        svc.stu = stu;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
}

-(void)showQRCodeWithHeader:(CheckTabelHeaderView *)headerView
{
    
    CheckinQRCodeController *svc = [[CheckinQRCodeController alloc]init];
    
    svc.checkType = headerView.type;
    
    if (headerView.type == CheckTypeCheckin) {
        
        svc.qrcode = self.codeInfo.checkinQRCode;
        
    }else{
        
        svc.qrcode = self.codeInfo.checkoutQRCode;
        
    }
    
    [self presentViewController:svc animated:YES completion:^{
        
    }];
    
}

-(void)showSearchViewWithType:(CheckType)type
{
    
    self.searchTableView.tag = type == CheckTypeCheckin?103:104;
    
    [self.searchTableView reloadData];
    
    [UIView animateWithDuration:0.5 animations:^{
       
        [self.checkView changeLeft:0];
        
    }];
    
}

-(void)hideSearchView
{
    
    self.searchBar.text = @"";
    
    self.stuArray = [NSArray array];
    
    [self.view endEditing:YES];
    
    [UIView animateWithDuration:0.5 animations:^{
       
        [self.checkView changeLeft:MSW];
        
    }];
    
}

-(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    if (tableView.tag == 103 || tableView.tag == 104) {
        
        UIView *emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(56), MSW, MSH-self.chooseView.rowHeight-64-Height320(56))];
        
        UIImageView *scanImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(148), Height320(32), Width320(24), Height320(24))];
        
        scanImg.image = [UIImage imageNamed:self.searchBar.text.length?@"empty_noperson":@"scan"];
        
        [emptyView addSubview:scanImg];
        
        self.checkLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, scanImg.bottom+Height320(15), MSW, Height320(15))];
        
        self.checkLabel.text = self.searchBar.text.length?@"没有找到匹配的会员":tableView.tag == 103?@"查找会员进行手动签到":@"查找会员进行手动签出";
        
        self.checkLabel.textColor = UIColorFromRGB(0x666666);
        
        self.checkLabel.font = AllFont(13);
        
        self.checkLabel.textAlignment = NSTextAlignmentCenter;
        
        [emptyView addSubview:self.checkLabel];
        
        return emptyView;
        
    }else{
        
        UIView *emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(56), MSW, Height320(418))];
        
        emptyView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(76), Height320(84), Width320(168), Height320(144))];
        
        emptyImg.image = [UIImage imageNamed:@"checkin_empty"];
        
        [emptyView addSubview:emptyImg];
        
        UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, emptyImg.bottom+Height320(15), MSW, Height320(15))];
        
        emptyLabel.text = tableView.tag == 101?@"暂无未处理的签到":@"暂无未处理的签出";
        
        emptyLabel.textColor = UIColorFromRGB(0x666666);
        
        emptyLabel.font = AllFont(13);
        
        emptyLabel.textAlignment = NSTextAlignmentCenter;
        
        [emptyView addSubview:emptyLabel];
        
        UIButton *historyButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW/2-Width320(64), emptyLabel.bottom+Height320(113), Width320(130), Height320(28))];
        
        historyButton.layer.borderColor = UIColorFromRGB(0xbbbbbb).CGColor;
        
        historyButton.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
        [historyButton setTitle:@"查看3小时内签到记录" forState:UIControlStateNormal];
        
        [historyButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        
        historyButton.titleLabel.font = AllFont(12);
        
        [emptyView addSubview:historyButton];
        
        [historyButton addTarget:self action:@selector(history:) forControlEvents:UIControlEventTouchUpInside];
        
        return emptyView;
        
    }
    
}

-(void)naviRightClick
{
    
    if ([PermissionInfo sharedInfo].permissions.checkinSettingPermssion.editState) {
        
        CheckinSettingController *svc = [[CheckinSettingController alloc]init];
        
        svc.setting = YES;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(void)manualCheckWithHeader:(CheckTabelHeaderView *)headerView
{
    
    [self showSearchViewWithType:headerView.type];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)chestChooseWithCheckinCell:(CheckinCell *)cell
{
    
    ChestSearchController *svc = [[ChestSearchController alloc]init];
    
    Checkin *checkin = self.checkins[cell.tag];
    
    if (checkin.chest.chestId) {
        
        svc.chest = checkin.chest;
        
    }
    
    __weak typeof(self)weakS = self;
    
    svc.chooseChestFinish = ^(Chest *chest){
        
        Checkin *tempCheckin = weakS.checkins[cell.tag];
        
        tempCheckin.chest = chest;
        
        [weakS.checkinTableView reloadData];
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}


-(void)checkoutCellCheckout:(CheckoutCell *)cell
{
    
    if (self.isDealing) {
        
        return;
        
    }
    
    self.isDealing = YES;
    
    __weak typeof(self)weakS = self;
    
    Checkout *checkout = self.checkouts[cell.tag];
    
    CheckoutInfo *info = [[CheckoutInfo alloc]init];
    
    [info checkoutWithCheckout:checkout result:^(BOOL success, NSString *error) {
        
        weakS.isDealing = NO;
        
        if (success) {
            
            NSMutableArray *checkouts = [weakS.checkouts mutableCopy];
            
            [checkouts removeObjectAtIndex:cell.tag];
            
            weakS.checkouts = [checkouts copy];
            
            [weakS.checkoutTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:cell.tag inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
            
            CheckSuccessView *successView = [CheckSuccessView defaultSuccessView];
            
            successView.title = [NSString stringWithFormat:@"%@签出成功",checkout.student.name];
            
            [weakS.view addSubview:successView];
            
            [successView show];
            
            [weakS reloadCheckoutData];
            
        }else{
            
            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
            
            hud.mode = MBProgressHUDModeText;
            
            [weakS.view addSubview:hud];
            
            hud.label.text = error;
            
            hud.label.numberOfLines = 0;
            
            [hud showAnimated:YES];
            
            [hud hideAnimated:YES afterDelay:1.5];
            
        }
        
    }];
    
}

-(void)ignoreCheckoutWithCheckoutCell:(CheckoutCell *)cell
{
    
    if (self.isDealing) {
        
        return;
        
    }
    
    self.isDealing = YES;
    
    __weak typeof(self)weakS = self;
    
    Checkout *checkout = self.checkouts[cell.tag];
    
    CheckoutInfo *info = [[CheckoutInfo alloc]init];
    
    [info ignoreWithCheckout:checkout result:^(BOOL success, NSString *error) {
        
        weakS.isDealing = NO;
        
        if (success) {
            
            NSMutableArray *checkouts = [weakS.checkouts mutableCopy];
            
            [checkouts removeObjectAtIndex:cell.tag];
            
            weakS.checkouts = [checkouts copy];
            
            [weakS.checkoutTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:cell.tag inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
            
        }
        
        [weakS reloadCheckoutData];
        
    }];
    
}

-(void)ignoreCheckinWithCheckinCell:(CheckinCell *)cell
{
    
    if (self.isDealing) {
        
        return;
        
    }
    
    self.isDealing = YES;
    
    __weak typeof(self)weakS = self;
    
    Checkin *checkin = self.checkins[cell.tag];
    
    CheckinInfo *info = [[CheckinInfo alloc]init];
    
    [info ignoreWithCheckin:checkin result:^(BOOL success, NSString *error) {
        
        weakS.isDealing = NO;
        
        if (success) {
            
            NSMutableArray *checkins = [weakS.checkins mutableCopy];
            
            [checkins removeObjectAtIndex:cell.tag];
            
            weakS.checkins = [checkins copy];
            
            [weakS.checkinTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:cell.tag inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
            
        }
        
        [weakS reloadCheckinData];
        
    }];
    
}

-(void)checkinWithCheckinCell:(CheckinCell *)cell
{
    
    if (self.isDealing) {
        
        return;
        
    }
    
    self.isDealing = YES;
    
    __weak typeof(self)weakS = self;
    
    Checkin *checkin = self.checkins[cell.tag];
    
    CheckinInfo *info = [[CheckinInfo alloc]init];
    
    [info checkinWithCheckin:checkin result:^(BOOL success, NSString *error) {
        
        weakS.isDealing = NO;
        
        if (success) {
            
            NSMutableArray *checkins = [weakS.checkins mutableCopy];
            
            [checkins removeObjectAtIndex:cell.tag];
            
            weakS.checkins = [checkins copy];
            
            [weakS.checkinTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:cell.tag inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
            
            CheckSuccessView *successView = [CheckSuccessView defaultSuccessView];
            
            successView.title = [NSString stringWithFormat:@"%@签到成功",checkin.student.name];
            
            [weakS.view addSubview:successView];
            
            [successView show];
            
            [weakS reloadCheckinData];
            
        }else{
            
            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
            
            hud.mode = MBProgressHUDModeText;
            
            [weakS.view addSubview:hud];
            
            hud.label.text = error;
            
            hud.label.numberOfLines = 0;
            
            [hud showAnimated:YES];
            
            [hud hideAnimated:YES afterDelay:1.5];
            
        }
        
    }];
    
}

-(void)uploadPhotoWithCheckinCell:(CheckinCell *)cell
{
    
    Checkin *checkin = self.checkins[cell.tag];
    
    if (!checkin.student.photo.absoluteString.length) {
        
        self.student = checkin.student;
        
        [self editPhoto];
        
    }else{
        
        PictureShowController *svc = [[PictureShowController alloc]init];
        
        svc.imageURL = checkin.student.photo;
        
        [self presentViewController:svc animated:YES completion:nil];
        
    }
    
}

-(void)uploadPhotoWithCheckoutCell:(CheckoutCell *)cell
{
    
    Checkout *checkout = self.checkouts[cell.tag];
    
    if (!checkout.student.photo.absoluteString.length) {
        
        self.student = checkout.student;
        
        [self editPhoto];
        
    }else{
        
        PictureShowController *svc = [[PictureShowController alloc]init];
        
        svc.imageURL = checkout.student.photo;
        
        [self presentViewController:svc animated:YES completion:nil];
        
    }
    
}

-(void)editPhoto
{
    
    if ([PermissionInfo sharedInfo].permissions.userPermission.editState||[PermissionInfo sharedInfo].permissions.personalUserPermission.editState) {
        
        UIActionSheet *actionSheet;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传会员照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
        }else{
            actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传会员照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册选择", nil];
        }
        actionSheet.delegate = self;
        [actionSheet showInView:self.view];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        if(buttonIndex == 0)
        {
            
            NSString *mediaType = AVMediaTypeVideo;
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
            if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
                
                
                [[[UIAlertView alloc]initWithTitle:@"提示" message:@"相机访问受限，请到设置-隐私-相机中允许【健身房管理】访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
                return;
            }
            //拍照
            sourceType = UIImagePickerControllerSourceTypeCamera;
        }else if(buttonIndex == 1)
        {
            //从相册选择
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }else
        {
            return;
        }
    }else{
        if (buttonIndex == 0) {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }else
        {
            return;
        }
        
    }
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        [self performSelector:@selector(showCamera:) withObject:[NSNumber numberWithInteger:sourceType] afterDelay:1.0f];
        
    }else
    {
        
        self.imagePickerController = [[UIImagePickerController alloc] init];
        
        self.imagePickerController.delegate = self;
        
        self.imagePickerController.allowsEditing = YES;
        
        self.imagePickerController.sourceType = sourceType;
        
        [self presentViewController:self.imagePickerController animated:YES completion:^{}];
        
    }
    
}

-(void)showCamera:(NSNumber*)typeNumber
{
    
    self.imagePickerController = [[UIImagePickerController alloc] init];
    
    self.imagePickerController.delegate = self;
    
    self.imagePickerController.allowsEditing = YES;
    
    self.imagePickerController.sourceType = [typeNumber integerValue];
    
    [self presentViewController:self.imagePickerController animated:YES completion:^{}];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    self.image = [UIImage fixOrientation:[info objectForKey:UIImagePickerControllerEditedImage]];
    
    [self uploadImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)uploadImage
{
    
    __weak typeof(self)weakS = self;
    
    UpYun *uy = [[UpYun alloc] init];
    
    uy.successBlocker = ^(NSURLResponse *response,id data){
        
        CheckinPhotoHistoryInfo *info = [[CheckinPhotoHistoryInfo alloc]init];
        
        [info uploadPhoto:weakS.student.photo.absoluteString student:weakS.student result:^(BOOL success, NSString *error) {
            
            if (success) {
                
                [weakS reloadData];
                
                weakS.hud.label.text = @"上传成功";
                
                weakS.hud.mode = MBProgressHUDModeText;
                
                [weakS.hud showAnimated:YES];
                
                [weakS.hud hideAnimated:YES afterDelay:1.0f];
                
            }else{
                
                weakS.student.photo = nil;
                
                weakS.hud.label.text = error;
                
                weakS.hud.label.numberOfLines = 0;
                
                weakS.hud.mode = MBProgressHUDModeText;
                
                [weakS.hud showAnimated:YES];
                
                [weakS.hud hideAnimated:YES afterDelay:1.0f];
                
            }
            
        }];
        
    };
    
    uy.failBlocker = ^(NSError *error){
        
        weakS.hud.label.text = @"上传图片失败";
        
        weakS.hud.mode = MBProgressHUDModeText;
        
        [weakS.hud showAnimated:YES];
        
        [weakS.hud hideAnimated:YES afterDelay:1.0f];
        
    };
    
    uy.progressBlocker = ^(CGFloat percent, long long requestDidSendBytes)
    {
        
        weakS.hud.mode = MBProgressHUDModeAnnularDeterminate;
        
        weakS.hud.label.text = @"";
        
        weakS.hud.progress = percent;
        
        [weakS.hud showAnimated:YES];
        
    };
    
    NSString *url = [UpYun getSaveKey];
    
    self.student.photo = [NSURL URLWithString:[NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url]];
    
    [uy uploadImage:self.image savekey:url];
    
}

-(void)dealloc
{
    
    self.checkinInfo = nil;
    
    self.checkoutInfo = nil;
    
}


@end
