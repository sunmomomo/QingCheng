//
//  JoinCompleteController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/20.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "JoinCompleteController.h"

#import "GymDetailInfo.h"

#import "WebViewController.h"

#define WeChatURL @"/mobile/weixin/guide/"

@interface JoinCompleteController ()

@end

@implementation JoinCompleteController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)createData
{
    
    
    
}

-(void)createUI
{
    
    self.title = @"完成对接";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(203))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:topView];
    
    UILabel *firstTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(16), Width320(24), Height320(18))];
    
    firstTitleLabel.text = @"1.";
    
    [topView addSubview:firstTitleLabel];
    
    NSString *str = [NSString stringWithFormat:@"复制会员端页面链接：%@",AppGym.hintURL.absoluteString];
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(MSW-Width320(56), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(14)} context:nil].size;
    
    UILabel *firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(40), Height320(16), MSW-Width320(56), size.height)];
    
    firstLabel.numberOfLines = 0;
    
    firstLabel.textColor = UIColorFromRGB(0x666666);
    
    firstLabel.font = AllFont(14);
    
    firstLabel.text = str;
    
    [topView addSubview:firstLabel];
    
    NSString *buttonStr = @"复制链接到剪贴板";
    
    CGSize buttonSize = [buttonStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(13)} context:nil].size;
    
    UIButton *copyButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(40), firstLabel.bottom+Height320(2), buttonSize.width+Width320(24), Height320(20))];
    
    [copyButton setTitle:@"复制链接到剪贴板" forState:UIControlStateNormal];
    
    [copyButton setTitleColor:UIColorFromRGB(0x6EB8F1) forState:UIControlStateNormal];
    
    copyButton.titleLabel.font = AllFont(13);
    
    [topView addSubview:copyButton];
    
    [copyButton addTarget:self action:@selector(copyLink) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *secondTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), copyButton.bottom+Height320(16), Width320(24), Height320(18))];
    
    secondTitleLabel.text = @"2.";
    
    [topView addSubview:secondTitleLabel];
    
    NSString *secStr = @"将链接添加到健身房微信公众号的菜单栏";
    
    CGSize secSize = [secStr boundingRectWithSize:CGSizeMake(MSW-Width320(56), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(14)} context:nil].size;
    
    UILabel *secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstLabel.left, copyButton.bottom+Height320(16), firstLabel.width, secSize.height)];
    
    secondLabel.text = secStr;
    
    secondLabel.numberOfLines = 0;
    
    secondLabel.textColor = UIColorFromRGB(0x666666);
    
    secondLabel.font = AllFont(14);
    
    [topView addSubview:secondLabel];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(40), secondLabel.bottom+Height320(7), MSW-Width320(60), Height320(70))];
    
    image.image = [UIImage imageNamed:@"hint_image"];
    
    [topView addSubview:image];
    
    UIButton *detailButton = [[UIButton alloc]initWithFrame:CGRectMake(0, topView.bottom, MSW, Height320(40))];
    
    detailButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    detailButton.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    detailButton.layer.borderWidth = OnePX;
    
    [self.view addSubview:detailButton];
    
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MSW-Width320(100), Height320(40))];
    
    detailLabel.text = @"微信菜单配置详细教程";
    
    detailLabel.textColor = kMainColor;
    
    detailLabel.font = AllFont(14);
    
    detailLabel.textAlignment = NSTextAlignmentRight;
    
    [detailButton addSubview:detailLabel];
    
    UIImageView *detailImg = [[UIImageView alloc]initWithFrame:CGRectMake(detailLabel.right+Width320(5), Height320(14), Width320(7), Height320(12))];
    
    detailImg.image = [[UIImage imageNamed:@"cellarrow"] imageWithTintColor:kMainColor];
    
    [detailButton addSubview:detailImg];
    
    [detailButton addTarget:self action:@selector(detail) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *completeButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), detailButton.bottom+Height320(12), MSW-Width320(32), Height320(40))];
    
    completeButton.backgroundColor = kMainColor;
    
    [completeButton setTitle:@"我已完成上述步骤" forState:UIControlStateNormal];
    
    [completeButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    completeButton.titleLabel.font = AllFont(16);
    
    [self.view addSubview:completeButton];
    
    [completeButton addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)copyLink
{
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    pasteboard.string = AppGym.hintURL.absoluteString;
    
    [[[UIAlertView alloc]initWithTitle:@"链接已复制到剪贴板" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    
}

-(void)complete
{
    
    GymDetailInfo *info = [[GymDetailInfo alloc]init];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:hud];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    
    hud.label.text = @"";
    
    [hud showAnimated:YES];
    
    [info uploadWechatImg:self.wechatImg andWechatName:self.wechatName result:^(BOOL success, NSString *error){
        
        hud.mode = MBProgressHUDModeText;
        
        if (success) {
            
            hud.label.text = @"上传成功";
            
            [hud hideAnimated:YES afterDelay:1.5];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self popToViewControllerName:@"GymHomePageController" isReloadData:YES];
                
            });
            
        }else{
            
            hud.label.text = error;
            
            [hud hideAnimated:YES afterDelay:1.5];
            
        }
        
    }];
    
}

-(void)detail
{
    
    WebViewController *svc = [[WebViewController alloc]init];
    
    NSString *api = [NSString stringWithFormat:@"%@%@",ROOT,WeChatURL];
    
    svc.url = [NSURL URLWithString:api];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

@end
