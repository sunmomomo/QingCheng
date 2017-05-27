//
//  CheckinScreenSettingController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/2/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "CheckinScreenSettingController.h"

#import "FunctionHintController.h"

#import "GymURLInfo.h"

@interface CheckinScreenSettingController ()

@property(nonatomic,strong)UILabel *firstLabel;

@property(nonatomic,strong)UIButton *acopyButton;

@property(nonatomic,strong)UIView *topView;

@property(nonatomic,strong)UIButton *detailButton;

@end

@implementation CheckinScreenSettingController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)createData
{
    
    GymURLInfo *info = [[GymURLInfo alloc]init];
    
    [info requestResult:^(BOOL success, NSString *error) {
        
        if (AppGym.checkinScreenURL.absoluteString.length) {
            
            NSString *str = [NSString stringWithFormat:@"签到大屏幕链接：%@",AppGym.checkinScreenURL.absoluteString];
            
            CGSize size = [str boundingRectWithSize:CGSizeMake(MSW-Width320(56), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(14)} context:nil].size;
            
            self.firstLabel.text = str;
            
            [self.firstLabel changeHeight:size.height];
            
            [self.acopyButton changeTop:self.firstLabel.bottom+Height320(2)];
            
            [self.topView changeHeight:self.acopyButton.bottom+Height320(15)];
            
            [self.detailButton changeTop:self.topView.bottom];
            
        }
        
    }];
    
}

-(void)createUI
{
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.title = @"入场签到设置";
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(90))];
    
    self.topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.topView.layer.borderWidth = OnePX;
    
    self.topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:self.topView];
    
    self.firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(40), Height320(16), MSW-Width320(56), Height320(40))];
    
    self.firstLabel.numberOfLines = 0;
    
    self.firstLabel.textColor = UIColorFromRGB(0x666666);
    
    self.firstLabel.font = AllFont(14);
    
    [self.topView addSubview:self.firstLabel];
    
    NSString *buttonStr = @"复制链接到剪贴板";
    
    CGSize buttonSize = [buttonStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(13)} context:nil].size;
    
    self.acopyButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(40), self.firstLabel.bottom+Height320(2), buttonSize.width+Width320(24), Height320(20))];
    
    [self.acopyButton setTitle:buttonStr forState:UIControlStateNormal];
    
    [self.acopyButton setTitleColor:UIColorFromRGB(0x6EB8F1) forState:UIControlStateNormal];
    
    self.acopyButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    self.acopyButton.titleLabel.font = AllFont(13);
    
    [self.topView addSubview:self.acopyButton];
    
    [self.topView changeHeight:self.acopyButton.bottom+Height320(15)];
    
    [self.acopyButton addTarget:self action:@selector(copyLink) forControlEvents:UIControlEventTouchUpInside];
    
    self.detailButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.topView.bottom, MSW, Height320(40))];
    
    self.detailButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.detailButton.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.detailButton.layer.borderWidth = OnePX;
    
    [self.view addSubview:self.detailButton];
    
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MSW-Width320(120), Height320(40))];
    
    detailLabel.text = @"签到大屏幕设置";
    
    detailLabel.textColor = kMainColor;
    
    detailLabel.font = AllFont(14);
    
    detailLabel.textAlignment = NSTextAlignmentRight;
    
    [self.detailButton addSubview:detailLabel];
    
    UIImageView *detailImg = [[UIImageView alloc]initWithFrame:CGRectMake(detailLabel.right+Width320(5), Height320(14), Width320(7), Height320(12))];
    
    detailImg.image = [[UIImage imageNamed:@"cellarrow"] imageWithTintColor:kMainColor];
    
    [self.detailButton addSubview:detailImg];
    
    [self.detailButton addTarget:self action:@selector(detail) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)detail
{
 
    if ([PermissionInfo sharedInfo].permissions.checkinScreenPermission.editState) {
        
        FunctionHintController *svc = [[FunctionHintController alloc]init];
        
        svc.module = @"/checkin/screen";
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(void)copyLink
{
    
    if (AppGym.checkinScreenURL.absoluteString.length) {
        
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        
        pasteboard.string = AppGym.checkinScreenURL.absoluteString;
        
        [[[UIAlertView alloc]initWithTitle:@"链接已复制到剪贴板" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }
    
}


@end
