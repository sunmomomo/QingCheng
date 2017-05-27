//
//  GymPaySuccessController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/17.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "GymPaySuccessController.h"

#import "GymDetailController.h"

@interface GymPaySuccessController ()

@end

@implementation GymPaySuccessController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
}

-(void)createUI
{
    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.title = @"升级成功";
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(MSW/2-Width320(71), 64+Height320(60), Width320(142), Height320(120))];
    
    img.image = [UIImage imageNamed:@"gym_pro_pay_success"];
    
    [self.view addSubview:img];
    
    UILabel *fLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, img.bottom+Height320(16), MSW, Height320(20))];
    
    fLabel.text = @"升级成功";
    
    fLabel.textColor = UIColorFromRGB(0x333333);
    
    fLabel.textAlignment = NSTextAlignmentCenter;
    
    fLabel.font = AllBFont(16);
    
    [self.view addSubview:fLabel];
    
    UILabel *sLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, fLabel.bottom+Height320(8), MSW, Height320(55))];
    
    sLabel.textColor = UIColorFromRGB(0x999999);
    
    sLabel.font = AllFont(13);
    
    sLabel.textAlignment = NSTextAlignmentCenter;
    
    sLabel.numberOfLines = 0;
    
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@成功升级到高级版\n有效期至：%@\n快去探索高级版的强大功能吧！",AppGym.name,AppGym.systemEnd]];
    
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    
    attch.image = [[UIImage imageNamed:@"gym_pro_img"]imageWithTintColor:UIColorFromRGB(0x999999)];
    
    attch.bounds = CGRectMake(0, 0, Width320(18), Height320(10));
    
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    
    [astr insertAttributedString:string atIndex:AppGym.name.length+8];
    
    [astr insertAttributedString:string atIndex:astr.length-7];
    
    sLabel.attributedText = astr;
    
    [self.view addSubview:sLabel];
    
    UIButton *tryButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW/2-Width320(68), sLabel.bottom+Height320(20), Width320(136), Height320(40))];
    
    tryButton.backgroundColor = kMainColor;
    
    tryButton.layer.cornerRadius = Width320(2);
    
    [tryButton setTitle:@"开始体验" forState:UIControlStateNormal];
    
    [tryButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    tryButton.titleLabel.font = AllFont(16);
    
    [self.view addSubview:tryButton];
    
    [tryButton addTarget:self action:@selector(tryClick) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)tryClick
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        if ([[MOAppDelegate getCurrentVC]isKindOfClass:[UINavigationController class]]) {
            
            for (MOViewController *vc in ((UINavigationController*)[MOAppDelegate getCurrentVC]).viewControllers) {
                
                if ([vc isKindOfClass:[GymDetailController class]]) {
                    
                    [((GymDetailController *)vc)reloadProSuccessData];
                    
                }
                
            }
            
        }
        
    }];
    
}


@end
