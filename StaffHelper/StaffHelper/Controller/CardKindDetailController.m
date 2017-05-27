//
//  CardKindDetailController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/10.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardKindDetailController.h"

#import "CardKindEditController.h"

#import "CardKindView.h"

#import "CardKindSpecCell.h"

#import "CardKindEditSpecController.h"

#import "SpecListInfo.h"

#import "CardKindInfo.h"

#import "CardKindListGymController.h"

#import "CardKindListController.h"

static NSString *identifier = @"Cell";

@interface CardKindDetailController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UIActionSheetDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)CardKindView *cardView;

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)CardKindInfo *info;

@property(nonatomic,strong)UIView *headerView;

@property(nonatomic,strong)UIView *topView;

@property(nonatomic,strong)UILabel *headLeftLabel;

@property(nonatomic,strong)UILabel *headRightLabel;

@property(nonatomic,strong)UIImageView *headImg;

@end

@implementation CardKindDetailController

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
    
    [self reloadUI];
    
    self.info = [[CardKindInfo alloc]init];
    
    [self.info requestDataWithCardKind:self.cardKind result:^(BOOL success, NSString *error) {
        
        [self reloadUI];
        
        [self.collectionView reloadData];
        
    }];
    
}

-(void)reloadUI
{
    
    self.cardView.cardKindName = self.cardKind.cardKindName;
    
    self.cardView.cardId = self.cardKind.cardKindId;
    
    self.cardView.summary = self.cardKind.summary;
    
    self.cardView.astrict = self.cardKind.astrict;
    
    self.cardView.cardKindType = self.cardKind.type;
    
    self.cardView.gyms = self.cardKind.gyms;
    
    self.cardView.cardBackColor = self.cardKind.color;
    
    self.cardView.state = self.cardKind.state;
    
    NSString *gymStr = @"适用场馆：";
    
    for (NSInteger i = 0; i<self.cardKind.gyms.count; i++) {
        
        Gym *gym = self.cardKind.gyms[i];
        
        gymStr = [gymStr stringByAppendingString:gym.name];
        
        if (i<self.cardKind.gyms.count-1) {
            
            gymStr = [gymStr stringByAppendingString:@"，"];
            
        }
        
    }
    
    self.headLeftLabel.textColor = self.headRightLabel.textColor = self.cardKind.state == CardKindStateStop?UIColorFromRGB(0xcccccc):UIColorFromRGB(0x999999);
    
    self.headImg.alpha = self.cardKind.state == CardKindStateStop?0.4:1;
    
    NSString *astrictStr = self.cardKind.astrict.length?[NSString stringWithFormat:@"限制：%@",self.cardKind.astrict]:@"限制：无";
    
    CGSize size = [gymStr boundingRectWithSize:CGSizeMake(MSW-Width320(44), CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: AllFont(12)} context:nil].size;
    
    CGSize astrictSize = [astrictStr boundingRectWithSize:CGSizeMake(MSW-Width320(44), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
    
    [self.cardView changeHeight:Height320(138)+size.height+astrictSize.height];

    [self.topView changeHeight:self.cardView.height+Height320(20)];
    
    [self.headerView changeTop:self.topView.bottom];
    
    [self.collectionView changeTop:self.headerView.bottom];
    
    [self.collectionView changeHeight:MSH-self.headerView.bottom];
    
}

-(void)reloadData
{
    
    [self.info requestDataWithCardKind:self.cardKind result:^(BOOL success, NSString *error) {
        
        [self reloadUI];
        
        [self.collectionView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"会员卡种类详情";
    
    self.rightType = MONaviRightTypeMore;
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(184))];
    
    self.topView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.view addSubview:self.topView];
    
    self.cardView = [[CardKindView alloc]initWithFrame:CGRectMake(Width320(10), Height320(10), MSW-Width320(20), Height320(164))];
    
    self.cardView.layer.shadowOpacity = 0.2;
    
    self.cardView.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
    
    self.cardView.layer.shadowOffset = CGSizeMake(0, 2);
    
    self.cardView.state = self.cardKind.state;
    
    [self.topView addSubview:self.cardView];
    
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, self.topView.bottom, MSW, Height320(40))];
    
    self.headerView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:self.headerView];
    
    UIView *topSep = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, 1)];
    
    topSep.backgroundColor = UIColorFromRGB(0xeeeeee);
    
    [self.headerView addSubview:topSep];
    
    UIView *bottomSep = [[UIView alloc]initWithFrame:CGRectMake(0, self.headerView.height-1, MSW, 1)];
    
    bottomSep.backgroundColor = UIColorFromRGB(0xeeeeee);
    
    [self.headerView addSubview:bottomSep];
    
    NSString *str = @"会员卡规格 (";
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, Height320(40)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
    
    self.headLeftLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), 0, size.width, Height320(40))];
    
    self.headLeftLabel.text = str;
    
    self.headLeftLabel.textColor = UIColorFromRGB(0x999999);
    
    self.headLeftLabel.font = AllFont(12);
    
    [self.headerView addSubview:self.headLeftLabel];
    
    self.headImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.headLeftLabel.right+Width320(2), Height320(11), Width320(16), Height320(16))];
    
    self.headImg.image = [UIImage imageNamed:@"card_kind_spec_staff"];
    
    [self.headerView addSubview:self.headImg];
    
    self.headRightLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.headImg.right, 0, Width320(180), Height320(40))];
    
    self.headRightLabel.text = @"表示该规格仅工作人员可见)";
    
    self.headRightLabel.textColor = UIColorFromRGB(0x999999);
    
    self.headRightLabel.font = AllFont(12);
    
    [self.headerView addSubview:self.headRightLabel];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.headerView.bottom, MSW, MSH-self.headerView.bottom) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    
    self.collectionView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.collectionView.delegate = self;
    
    self.collectionView.dataSource = self;
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=10.0) {
        
        self.collectionView.prefetchingEnabled = NO;
        
    }
    
    [self.collectionView registerClass:[CardKindSpecCell class] forCellWithReuseIdentifier:identifier];
    
    [self.view addSubview:self.collectionView];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(void)naviRightClick
{
    
    if (self.cardKind.state == CardKindStateStop) {
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"恢复该会员卡种类" otherButtonTitles:@"编辑",nil];
        
        [actionSheet showInView:self.view];
        
    }else{
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"停用该会员卡种类" otherButtonTitles:@"编辑", nil];
        
        [actionSheet showInView:self.view];
        
    }
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
        
        UIAlertView *alert;
        
        if (self.cardKind.state == CardKindStateStop) {
            
            if (!AppGym&&[[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.cardKind.gyms andPermission:[Permission cardKindPermission] andType:PermissionTypeAdd] != PermissionStateAll) {
                
                if (self.cardKind.gyms.count>1) {
                    
                    alert = [[UIAlertView alloc]initWithTitle:@"无恢复权限" message:@"此会员卡种类适用于多个场馆，需要具有所有适用场馆下添加会员卡种类权限的用户才能进行恢复。" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
                    
                }else{
                    
                    [self showNoPermissionAlert];
                    
                    return;
                    
                }
                
            }else if (AppGym&&![PermissionInfo sharedInfo].permissions.cardKindPermission.addState){
                
                [self showNoPermissionAlert];
                
                return;
                
            }else if(AppGym && self.cardKind.gyms.count >1){
                
                alert = [[UIAlertView alloc]initWithTitle:@"无恢复权限" message:@"此会员卡种类种类适用于多个场馆，请在「连锁运营」中进行恢复。" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                
            }else{
                
                alert = [[UIAlertView alloc]initWithTitle:@"是否确认恢复？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                
                alert.tag = 102;
                
            }
            
            [alert show];
            
        }else{
            
            if (!AppGym&&[[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.cardKind.gyms andPermission:[Permission cardKindPermission] andType:PermissionTypeDelete] != PermissionStateAll) {
                
                if (self.cardKind.gyms.count>1) {
                    
                    alert = [[UIAlertView alloc]initWithTitle:@"无停用权限" message:@"此会员卡种类适用于多个场馆，需要具有所有适用场馆下停用会员卡种类权限的用户才能进行停用。" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
                    
                }else{
                    
                    [self showNoPermissionAlert];
                    
                    return;
                    
                }
                
            }else if (AppGym&&![PermissionInfo sharedInfo].permissions.cardKindPermission.deleteState){
                
                [self showNoPermissionAlert];
                
                return;
                
            }else if(AppGym && self.cardKind.gyms.count >1){
                
                alert = [[UIAlertView alloc]initWithTitle:@"无停用权限" message:@"此会员卡种类种类适用于多个场馆，请在「连锁运营」中进行停用。" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
                
            }else{
                
                alert = [[UIAlertView alloc]initWithTitle:@"是否确认停用？" message:@"1.停用后，此会员卡种类无法用于开卡\n2.停用后，该会员卡种类无法适用于排课支付\n3.不影响已发行会员卡的使用和显示" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                
                alert.tag = 101;
                
            }
            
            [alert show];
            
        }
        
    }else if(buttonIndex == 1)
    {
     
        if (self.cardKind.state == CardKindStateStop) {
            
            [[[UIAlertView alloc]initWithTitle:@"无法编辑已停用的会员卡种类" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }else{
            
            if ((AppGym && self.cardKind.gyms.count==1 &&[PermissionInfo sharedInfo].permissions.cardKindPermission.editState)||(!AppGym && [[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.cardKind.gyms andPermission:[PermissionInfo sharedInfo].permissions.cardKindPermission andType:PermissionTypeEdit])) {
                
                CardKindEditController *svc = [[CardKindEditController alloc]init];
                
                svc.cardKind = [self.cardKind copy];
                
                __weak typeof(self)weakS = self;
                
                svc.editFinish = ^{
                    
                    [weakS reloadData];
                    
                    for (MOViewController *vc in weakS.navigationController.viewControllers) {
                        
                        if ([vc isKindOfClass:[CardKindListGymController class]]) {
                            
                            [vc reloadData];
                            
                        }
                        
                        if ([vc isKindOfClass:[CardKindListController class]]) {
                            
                            [vc reloadData];
                            
                        }
                        
                    }
                    
                };
                
                [self.navigationController pushViewController:svc animated:YES];
                
            }else if(AppGym && ![PermissionInfo sharedInfo].permissions.cardKindPermission.editState){
                
                [self showNoPermissionAlert];
                
            }else if (AppGym && self.cardKind.gyms.count>1){
                
                [[[UIAlertView alloc]initWithTitle:@"无编辑权限" message:@"该会员卡种类适用于多个场馆，请到【连锁运营】中进行修改。" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil]show];
                
            }else if(!AppGym&&self.cardKind.gyms.count>1){
                
                [[[UIAlertView alloc]initWithTitle:@"无编辑权限" message:@"此会员卡种类适用于多个场馆，仅在所有适用场馆下都具有编辑会员卡种类权限的用户才能进行编辑。" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil]show];
                
            }else{
                
                [self showNoPermissionAlert];
                
            }
            
        }
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 101) {
        
        if (buttonIndex == 1) {
            
            self.hud.mode = MBProgressHUDModeIndeterminate;
            
            self.hud.label.text = @"";
            
            [self.hud showAnimated:YES];
            
            CardKindInfo *info = [[CardKindInfo alloc]init];
            
            [info deleteCardKind:self.cardKind result:^(BOOL success, NSString *error) {
                
                if (success) {
                    
                    self.hud.label.text = @"停用成功";
                    
                    self.hud.mode = MBProgressHUDModeText;
                    
                    [self.hud hideAnimated:YES afterDelay:1];
                    
                    [self reloadData];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        for (MOViewController *vc in self.navigationController.viewControllers) {
                            
                            if ([vc isKindOfClass:[CardKindListGymController class]]) {
                                
                                [vc reloadData];
                                
                            }
                            
                            if ([vc isKindOfClass:[CardKindListController class]]) {
                                
                                [vc reloadData];
                                
                            }
                            
                        }
                        
                    });
                    
                }else{
                    
                    self.hud.label.text = error;
                    
                    self.hud.mode = MBProgressHUDModeText;
                    
                    [self.hud hideAnimated:YES afterDelay:1];
                    
                }
                
            }];
            
        }
        
    }else{
        
        if (buttonIndex == 1) {
            
            self.hud.mode = MBProgressHUDModeIndeterminate;
            
            self.hud.label.text = @"";
            
            [self.hud showAnimated:YES];
            
            CardKindInfo *info = [[CardKindInfo alloc]init];
            
            [info renewCardKind:self.cardKind result:^(BOOL success, NSString *error) {
                
                if (success) {
                    
                    self.hud.label.text = @"恢复成功";
                    
                    self.hud.mode = MBProgressHUDModeText;
                    
                    [self.hud hideAnimated:YES afterDelay:1];
                    
                    [self reloadData];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        for (MOViewController *vc in self.navigationController.viewControllers) {
                            
                            if ([vc isKindOfClass:[CardKindListGymController class]]) {
                                
                                [vc reloadData];
                                
                            }
                            
                            if ([vc isKindOfClass:[CardKindListController class]]) {
                                
                                [vc reloadData];
                                
                            }
                            
                        }
                        
                    });
                    
                }else{
                    
                    self.hud.label.text = error;
                    
                    self.hud.mode = MBProgressHUDModeText;
                    
                    [self.hud hideAnimated:YES afterDelay:1];
                    
                }
                
            }];
            
        }
        
    }
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.cardKind.state == CardKindStateStop?self.cardKind.specs.count:self.cardKind.specs.count+1;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(Width320(142),self.cardKind.type == CardKindTypeTime?Height320(74): Height320(91));
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CardKindSpecCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if (indexPath.row<self.cardKind.specs.count) {
        
        Spec *spec = self.cardKind.specs[indexPath.row];
        
        cell.cardKindType = spec.cardKind.type;
        
        cell.price = spec.price;
        
        cell.charge = spec.charge;
        
        if (spec.cardKind.type != CardKindTypeTime) {
            
            cell.validDays = spec.validTime;
            
            cell.checkValid = spec.checkValid;
            
        }
        
        cell.onlyStaffCanSee = spec.onlyStaffCanSee;
        
        cell.userInteractionEnabled = self.cardKind.state != CardKindStateStop;
        
        cell.types = spec.canCreate?spec.canRecharge?@"新购卡、充值":@"新购卡":spec.canRecharge?@"充值":@"";
        
        cell.isAdd = NO;
        
    }else
    {
        
        cell.isAdd = YES;
        
        cell.onlyStaffCanSee = NO;
        
    }
    
    return cell;
    
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(Height320(11), Width320(12), Height320(11), Width320(12));
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ((AppGym && self.cardKind.gyms.count==1&&[PermissionInfo sharedInfo].permissions.cardKindPermission.editState)||(!AppGym && [[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.cardKind.gyms andPermission:[PermissionInfo sharedInfo].permissions.cardKindPermission andType:PermissionTypeEdit]==PermissionStateAll)) {
        
        CardKindEditSpecController *svc = [[CardKindEditSpecController alloc]init];
        
        svc.isAdd = indexPath.row == self.cardKind.specs.count;
        
        if (svc.isAdd) {
            
            svc.spec = [[Spec alloc]init];
            
            svc.spec.cardKind = self.cardKind;
            
        }else
        {
            
            Spec *spec = self.cardKind.specs[indexPath.row];
            
            svc.spec = spec;
            
        }
        
        __weak typeof(self)weakS = self;
        
        svc.editFinish = ^{
            
            [weakS reloadData];
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else if(AppGym && ![PermissionInfo sharedInfo].permissions.cardKindPermission.editState){
        
        [self showNoPermissionAlert];
        
    }else if (AppGym && self.cardKind.gyms.count>1){
        
        [[[UIAlertView alloc]initWithTitle:@"无编辑权限" message:@"该会员卡种类适用于多个场馆，请到【连锁运营】中进行修改。" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil]show];
        
    }else if(!AppGym&&self.cardKind.gyms.count>1){
        
        [[[UIAlertView alloc]initWithTitle:@"无编辑权限" message:@"此会员卡种类适用于多个场馆，仅在所有适用场馆下都具有编辑会员卡种类权限的用户才能进行编辑。" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil]show];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}


@end
