//
//  CardImproveController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardImproveController.h"

#import "CardView.h"

#import "QCTextField.h"

#import "QCKeyboardView.h"

#import "MOPickerView.h"

#import "MOCell.h"

#import "SummaryController.h"

#import "PayActionSheet.h"

#import "SellerChooseController.h"

#import "PayHelp.h"

#import "CardDetailController.h"

#import "CardListController.h"

#import "StudentDetailController.h"

#import "WebViewController.h"

#import "CheckinManualController.h"

#import "ChestLongBorrowController.h"
#import "YFHeader.h"

@interface CardImproveController ()<UITextFieldDelegate,PayActionSheetDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)CardView *cardView;

@property(nonatomic,strong)QCTextField *sellerTF;

@property(nonatomic,strong)MOCell *summaryCell;

@property(nonatomic,strong)MOCell *payCell;

@property(nonatomic,strong)UILabel *receiveLabel;

@property(nonatomic,assign)PayWay payWay;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)Seller *seller;

@end

@implementation CardImproveController

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
    
    self.cardView.cardName = self.card.cardName;
    
    self.cardView.cardNumber = self.card.cardNumber;
    
    self.cardView.users = self.card.users;
    
    self.cardView.state = self.card.state;
    
    self.cardView.type = self.card.cardKind.type;
    
    self.cardView.startTime = self.card.cardKind.type == CardKindTypeTime?self.card.start:self.card.validFrom;
    
    self.cardView.endTime = self.card.cardKind.type == CardKindTypeTime?self.card.end:self.card.validTo;
    
    self.cardView.remain = self.card.remain+[self.spec.charge integerValue];
    
    self.cardView.cardId = self.card.cardId;
    
    self.cardView.checkValid = self.card.checkValid;
    
    self.cardView.cardBackColor = self.card.color;
    
    self.payWay = PayWayQRCode;
    
    self.seller = [[Seller alloc]init];
    
    self.seller.sellerId = -1;
    
}

-(void)createUI
{
    
    self.title = @"完善信息";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(184))];
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:topView];
    
    self.cardView = [[CardView alloc]initWithFrame:CGRectMake(Width320(10), Height320(10), MSW-Width320(20), Height320(164))];
    
    [topView addSubview:self.cardView];
    
    UIView *secView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(10), MSW, Height320(40)*2)];
    
    secView.backgroundColor = UIColorFromRGB(0xffffff);
    
    secView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    secView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.view addSubview:secView];
    
    self.sellerTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.sellerTF.placeholder = @"销售";
    
    self.sellerTF.mustInput = YES;
    
    self.sellerTF.textPlaceholder = @"请选择";
    
    self.sellerTF.type = QCTextFieldTypeCell;
    
    self.sellerTF.delegate = self;
    
    [secView addSubview:self.sellerTF];
    
    self.summaryCell = [[MOCell alloc]initWithFrame:CGRectMake(self.sellerTF.left, self.sellerTF.bottom, self.sellerTF.width, self.sellerTF.height)];
    
    self.summaryCell.titleLabel.text = @"备注";
    
    self.summaryCell.placeholder = @"选填";
    
    self.summaryCell.noLine = YES;
    
    [secView addSubview:self.summaryCell];
    
    [self.summaryCell addTarget:self action:@selector(summaryClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, secView.bottom+Height320(10), MSW, Height320(40))];
    
    thirdView.backgroundColor = UIColorFromRGB(0xffffff);
    
    thirdView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    thirdView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.view addSubview:thirdView];
    
    self.payCell = [[MOCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.payCell.noLine = YES;
    
    self.payCell.titleLabel.text = @"支付方式";
    
    self.payCell.mustInput = YES;
    
    self.payCell.subtitle = @"微信扫码支付";
    
    self.payCell.subtitleColor = UIColorFromRGB(0x333333);
    
    [self.payCell addTarget:self action:@selector(choosePayWay) forControlEvents:UIControlEventTouchUpInside];
    
    [thirdView addSubview:self.payCell];
    
    UIView *confirmView = [[UIView alloc]initWithFrame:CGRectMake(0, MSH-Height320(50), MSW, Height320(50))];
    
    confirmView.backgroundColor = UIColorFromRGB(0xffffff);
    
    confirmView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    confirmView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.view addSubview:confirmView];
    
    self.receiveLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(150), Height320(50))];
    
    self.receiveLabel.textColor = UIColorFromRGB(0x999999);
    
    self.receiveLabel.font = AllFont(12);
    
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"实收%@元",self.spec.price]];
    
    [astr addAttribute:NSFontAttributeName value:AllFont(15) range:NSMakeRange(2, astr.length-2)];
    
    [astr addAttribute:NSForegroundColorAttributeName value:kMainColor range:NSMakeRange(2, astr.length-2)];
    
    self.receiveLabel.attributedText = astr;
    
    [confirmView addSubview:self.receiveLabel];
    
    UIButton* confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW-Width320(108), Height320(5), Width320(100), Height320(40))];
    
    confirmButton.layer.cornerRadius = 2;
    
    confirmButton.backgroundColor = kMainColor;
    
    confirmButton.titleLabel.font = AllFont(14);
    
    [confirmButton setTitle:@"确 定" forState:UIControlStateNormal];
    
    [confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    [confirmView addSubview:confirmButton];
    
    [confirmButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    SellerChooseController *svc = [[SellerChooseController alloc]init];
    
    __weak typeof(self)weakS = self;
    
    svc.chooseFinish = ^(Seller *seller){
        
        weakS.seller = seller;
        
        weakS.sellerTF.text = seller.name;
        
    };
    
    svc.gym = self.gym;
    
    svc.seller = self.seller;
    
    [self.navigationController pushViewController:svc animated:YES];
    
    return NO;
    
}

-(void)choosePayWay
{
    
    PayActionSheet *sheet = [PermissionInfo sharedInfo].permissions.cardKindPermission.editState?[PayActionSheet defaultActionSheet]:[PayActionSheet noPermissionActionSheet];
    
    sheet.payWay = self.payWay;
    
    sheet.delegate = self;
    
    [sheet showInView:self.view];
    
}

-(void)payActionSheetDismissWithPayWay:(PayWay)payWay
{
    
    self.payWay = payWay;
    
    switch (self.payWay) {
        case PayWayQRCode:
            self.payCell.subtitle = @"微信扫码支付";
            break;
        case PayWayWeChat:
            self.payCell.subtitle = @"微信支付";
            break;
        case PayWayCash:
            self.payCell.subtitle = @"现金支付";
            break;
        case PayWayCard:
            self.payCell.subtitle = @"刷卡支付";
            break;
        case PayWayTransfer:
            self.payCell.subtitle = @"转账支付";
            break;
        case PayWayOther:
            self.payCell.subtitle = @"其他支付";
            break;
        default:
            break;
    }
    
}

-(void)confirm:(UIButton*)button
{
    
    if (!self.sellerTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"请选择销售人员" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    self.hud.mode = MBProgressHUDModeIndeterminate;
    
    self.hud.label.text = @"";
    
    [self.hud showAnimated:YES];
    
    if (self.type == PayTypeCreate) {
        
        PayHelp *help = [[PayHelp alloc]init];
        
        [help createWithCard:self.card andSpec:self.spec andGym:self.gym andSellerId:self.seller.sellerId andRemarks:self.summaryCell.subtitle andPayWay:self.payWay result:^(BOOL success, NSString *error,NSURL *url) {
            
            if (success && !url.absoluteString.length) {
                
                self.hud.mode = MBProgressHUDModeText;
                
                self.hud.label.text = @"购卡成功";
                [[NSNotificationCenter defaultCenter] postNotificationName:kPostAddNewMemberIdtifierYF object:nil];
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
                if (self.card.users.count>1) {
                    
                    PayHelp *integralHelp = [[PayHelp alloc]init];
                    
                    [integralHelp calculateWithSpec:self.spec andGym:self.gym andPayWay:self.type result:^(BOOL success, NSString *error, NSURL *url) {
                        
                        if (integralHelp.haveIntegral) {
                            
                            [[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"本次购卡获得积分%@。由于会员卡绑定多个会员，请手动为会员分配积分。",[NSString formatStringWithFloat:integralHelp.integral]] message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil]show];
                            
                        }else{
                            
                            [self cardSuccess];
                            
                        }
                        
                    }];
                    
                }else{
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [self cardSuccess];
                        
                    });
                    
                }
                
            }else if(success && url.absoluteString.length){
                
                [self.hud hideAnimated:YES];
                
                WebViewController *svc = [[WebViewController alloc]init];
                
                svc.url = url;
                
                __weak typeof(self)weakS = self;
                
                svc.paySuccess = ^{
                    
                    for (UIViewController *vc in weakS.navigationController.viewControllers) {
                        
                        if ([vc isKindOfClass:[CardImproveController class]]) {
                            
                            [weakS.navigationController popToViewController:vc animated:YES];
                            
                        }
                        
                    }
                    
                    [weakS.hud showAnimated:YES];
                    
                    weakS.hud.mode = MBProgressHUDModeText;
                    
                    weakS.hud.label.text = @"购卡成功";
                    [[NSNotificationCenter defaultCenter] postNotificationName:kPostAddNewMemberIdtifierYF object:nil];

                    [weakS.hud hideAnimated:YES afterDelay:1.5];
                    
                    if (weakS.card.users.count>1) {
                        
                        PayHelp *integralHelp = [[PayHelp alloc]init];
                        
                        [integralHelp calculateWithSpec:weakS.spec andGym:weakS.gym andPayWay:weakS.type result:^(BOOL success, NSString *error, NSURL *url) {
                            
                            if (integralHelp.haveIntegral) {
                                
                                [[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"本次购卡获得积分%@。由于会员卡绑定多个会员，请手动为会员分配积分。",[NSString formatStringWithFloat:integralHelp.integral]] message:nil delegate:weakS cancelButtonTitle:nil otherButtonTitles:@"确定",nil]show];
                                
                            }else{
                                
                                [weakS cardSuccess];
                                
                            }
                            
                        }];
                        
                    }else{
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            [weakS cardSuccess];
                            
                        });
                        
                    }
                    
                };
                
                svc.completeAction = ^{
                    
                    for (UIViewController *vc in weakS.navigationController.viewControllers) {
                        
                        if ([vc isKindOfClass:[CardImproveController class]]) {
                            
                            [weakS.navigationController popToViewController:vc animated:YES];
                            
                        }
                        
                    }
                    
                    [weakS.hud showAnimated:YES];
                    
                    weakS.hud.mode = MBProgressHUDModeText;
                    
                    weakS.hud.label.text = @"购卡成功";
                    [[NSNotificationCenter defaultCenter] postNotificationName:kPostAddNewMemberIdtifierYF object:nil];

                    [weakS.hud hideAnimated:YES afterDelay:1.5];
                    
                    if (weakS.card.users.count>1) {
                        
                        PayHelp *integralHelp = [[PayHelp alloc]init];
                        
                        [integralHelp calculateWithSpec:weakS.spec andGym:weakS.gym andPayWay:weakS.type result:^(BOOL success, NSString *error, NSURL *url) {
                            
                            if (integralHelp.haveIntegral) {
                                
                                [[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"本次购卡获得积分%@。由于会员卡绑定多个会员，请手动为会员分配积分。",[NSString formatStringWithFloat:integralHelp.integral]] message:nil delegate:weakS cancelButtonTitle:nil otherButtonTitles:@"确定",nil]show];
                                
                            }else{
                                
                                [weakS cardSuccess];
                                
                            }
                            
                        }];
                        
                    }else{
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            [weakS cardSuccess];
                            
                        });
                        
                    }
                    
                };
                
                [self.navigationController pushViewController:svc animated:YES];
                
            }else
            {
                
                self.hud.mode = MBProgressHUDModeText;
                
                self.hud.label.text = error;
                
                self.hud.label.numberOfLines = 0;
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
            }
            
        }];
        
    }else
    {
        
        PayHelp *help = [[PayHelp alloc]init];
        
        [help rechargeWithCard:self.card andSpec:self.spec andGym:self.gym andSellerId:self.seller.sellerId andRemarks:self.summaryCell.subtitle andPayWay:self.payWay result:^(BOOL success, NSString *error,NSURL *url) {
            
            if (success && !url.absoluteString.length) {
                
                self.hud.mode = MBProgressHUDModeText;
                
                self.hud.label.text = @"充值成功";
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
                if (self.card.users.count>1) {
                    
                    PayHelp *integralHelp = [[PayHelp alloc]init];
                    
                    [integralHelp calculateWithSpec:self.spec andGym:self.gym andPayWay:self.type result:^(BOOL success, NSString *error, NSURL *url) {
                        
                        if (integralHelp.haveIntegral) {
                            
                            [[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"本次购卡获得积分%@。由于会员卡绑定多个会员，请手动为会员分配积分。",[NSString formatStringWithFloat:integralHelp.integral]] message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil]show];
                            
                        }else{
                            
                            [self cardSuccess];
                            
                        }
                        
                    }];
                    
                }else{
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [self cardSuccess];
                        
                    });
                    
                }
                
            }else if (success && url.absoluteString.length){
                
                [self.hud hideAnimated:YES];
                
                WebViewController *svc = [[WebViewController alloc]init];
                
                svc.url = url;
                
                __weak typeof(self)weakS = self;
                
                svc.paySuccess = ^{
                    
                    for (UIViewController *vc in weakS.navigationController.viewControllers) {
                        
                        if ([vc isKindOfClass:[CardImproveController class]]) {
                            
                            [weakS.navigationController popToViewController:vc animated:YES];
                            
                        }
                        
                    }
                    
                    [weakS.hud showAnimated:YES];
                    
                    weakS.hud.mode = MBProgressHUDModeText;
                    
                    weakS.hud.label.text = @"充值成功";
                    
                    [weakS.hud hideAnimated:YES afterDelay:1.5];
                    
                    if (weakS.card.users.count>1) {
                        
                        PayHelp *integralHelp = [[PayHelp alloc]init];
                        
                        [integralHelp calculateWithSpec:weakS.spec andGym:weakS.gym andPayWay:weakS.type result:^(BOOL success, NSString *error, NSURL *url) {
                            
                            if (integralHelp.haveIntegral) {
                                
                                [[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"本次购卡获得积分%@。由于会员卡绑定多个会员，请手动为会员分配积分。",[NSString formatStringWithFloat:integralHelp.integral]] message:nil delegate:weakS cancelButtonTitle:nil otherButtonTitles:@"确定",nil]show];
                                
                            }else{
                                
                                [weakS cardSuccess];
                                
                            }
                            
                        }];
                        
                    }else{
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            [weakS cardSuccess];
                            
                        });
                        
                    }
                    
                };
                
                svc.completeAction = ^{
                    
                    for (UIViewController *vc in weakS.navigationController.viewControllers) {
                        
                        if ([vc isKindOfClass:[CardImproveController class]]) {
                            
                            [weakS.navigationController popToViewController:vc animated:YES];
                            
                        }
                        
                    }
                    
                    [weakS.hud showAnimated:YES];
                    
                    weakS.hud.mode = MBProgressHUDModeText;
                    
                    weakS.hud.label.text = @"充值成功";
                    
                    [weakS.hud hideAnimated:YES afterDelay:1.5];
                    
                    if (weakS.card.users.count>1) {
                        
                        PayHelp *integralHelp = [[PayHelp alloc]init];
                        
                        [integralHelp calculateWithSpec:weakS.spec andGym:weakS.gym andPayWay:weakS.type result:^(BOOL success, NSString *error, NSURL *url) {
                            
                            if (integralHelp.haveIntegral) {
                                
                                [[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"本次购卡获得积分%@。由于会员卡绑定多个会员，请手动为会员分配积分。",[NSString formatStringWithFloat:integralHelp.integral]] message:nil delegate:weakS cancelButtonTitle:nil otherButtonTitles:@"确定",nil]show];
                                
                            }else{
                                
                                [weakS cardSuccess];
                                
                            }
                            
                        }];
                        
                    }else{
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            [weakS cardSuccess];
                            
                        });
                        
                    }
                    
                };
                
                [self.navigationController pushViewController:svc animated:YES];
                
            }else
            {
                
                self.hud.mode = MBProgressHUDModeText;
                
                self.hud.label.text = error;
                
                self.hud.label.numberOfLines = 0;
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
            }
            
        }];
        
    }
    
}

-(void)cardSuccess
{
    
    Student *stu = ((AppDelegate*)[UIApplication sharedApplication].delegate).student;
    
    if (stu) {
        
        for (MOViewController *vc in self.navigationController.viewControllers) {
            
            if ([vc isKindOfClass:[StudentDetailController class]]) {
                
                [vc reloadData];
                
                [self.navigationController popToViewController:vc animated:YES];
                
            }
            
        }
        
    }
    
    for (MOViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[CardDetailController class]]) {
            
            [vc reloadData];
            
            [self.navigationController popToViewController:vc animated:YES];
            
        }
        
    }
    
    for (MOViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[CardListController class]]) {
            
            [vc reloadData];
            
            [self.navigationController popToViewController:vc animated:YES];
            
        }
        
    }
    
    if ([self.navigationController.visibleViewController isKindOfClass:[CardImproveController class]]) {
        
        for (MOViewController *vc in self.navigationController.viewControllers) {
            
            if ([vc isKindOfClass:[CardListController class]]) {
                
                [self.navigationController popToViewController:vc animated:YES];
                
            }
            
        }
        
    }
    
    if ([self.navigationController.visibleViewController isKindOfClass:[CardImproveController class]]) {
        
        for (MOViewController *vc in self.navigationController.viewControllers) {
            
            if ([vc isKindOfClass:[CheckinManualController class]]) {
                
                [vc reloadData];
                
                [self.navigationController popToViewController:vc animated:YES];
                
            }
            
        }
        
    }
    
}

-(void)summaryClick:(MOCell*)cell
{
    
    SummaryController *svc = [[SummaryController alloc]init];
    
    svc.title = self.type == PayTypeCreate?@"购卡备注":@"充值备注";
    
    svc.placeholder = self.type == PayTypeCreate?@"购卡备注":@"充值备注";
    
    svc.text = self.summaryCell.subtitle;
    
    __weak typeof(self)weakS = self;
    
    svc.summaryFinish = ^(NSString *summary){
        
        weakS.summaryCell.subtitle = summary;
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    [self cardSuccess];
    
}

@end
