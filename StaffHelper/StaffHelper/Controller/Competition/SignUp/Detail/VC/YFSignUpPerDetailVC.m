//
//  YFSignUpPerDetailVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/27.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpPerDetailVC.h"

#import "YFButton.h"

#import "YFAppService.h"

#import "YFSignUpViewModel.h"

#import "YFSignUpDetailCModel.h"

#import "YFGrayCellModel.h"

@interface YFSignUpPerDetailVC ()

@property(nonatomic,strong)UIImageView *icon;

@property(nonatomic,strong)UIImageView *sexImg;

@property(nonatomic,strong)UILabel *phoneLabel;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic, strong)YFSignUpViewModel *viewModel;

@end

@implementation YFSignUpPerDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initView];
    [self refreshTableListDataNoPull];
}

//competition的 start 和当前时间对比 判断 比赛是否开始

- (void)requestData
{
    weakTypesYF
    [self.viewModel getResponseDetailDatashowLoadingOn:nil order_id:self.orderId successBlock:^{
        [weakS requestSuceessResultDeaiModel];
    } failBlock:^{
        [weakS failRequest:nil];
    }];
}


- (void)requestSuceessResultDeaiModel
{
//    self.viewModel.detailModel = [YFSignUpDetailCModel creatDetailModel];
    
    
    [self.icon sd_setImageWithURL:self.viewModel.detailModel.avatar];
    
    self.sexImg.image = [YFBaseCModel sexImageWithGender:self.viewModel.detailModel.gender];
    
    self.nameLabel.text = self.viewModel.detailModel.username;
    
    self.phoneLabel.text = self.viewModel.detailModel.phone;
    
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    [dataArray addObject:self.viewModel.detailModel];
    
    [dataArray addObject:[YFGrayCellModel defaultWithCellHeght:15.0]];

    
    // 已经开始
    if (self.viewModel.detailModel.beginDays >= 0)
    {
        [dataArray addObject:self.viewModel.detailModel.attendance];
    }else
    {
        self.viewModel.detailModel.attendanceNotBegin.days = -self.viewModel.detailModel.beginDays;
        // 未开始
        [dataArray addObject:self.viewModel.detailModel.attendanceNotBegin];
    }
    
    [self requestSuccessArray:dataArray];

}

- (void)initView
{
    self.canGetMore = NO;
    // 底部s 显示 部分 灰色 条
    self.baseTableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    self.baseTableView.showsVerticalScrollIndicator = NO;
    self.title = @"详情";
    self.baseTableView.backgroundColor = YFGrayViewColor;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(121))];
    
    self.baseTableView.bounces = NO;
    [self.baseTableView setTableHeaderView:topView];
    
    topView.backgroundColor = UIColorFromRGB(0x4e4e4e);
    
    self.icon = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(20), Height320(12), Width320(49), Height320(49))];
    
    self.icon.layer.cornerRadius = self.icon.width/2;
    
    self.icon.layer.masksToBounds = YES;
    
    self.icon.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
    
    self.icon.layer.borderWidth = 1;
    
    [topView addSubview:self.icon];
    
    self.sexImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.icon.right-Width320(15.3), self.icon.bottom-Height320(16), Width320(14), Height320(14))];
    
    self.sexImg.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.sexImg.layer.borderWidth = 1;
    
    self.sexImg.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
    
    self.sexImg.layer.cornerRadius = self.sexImg.width/2;
    
    self.sexImg.layer.masksToBounds = YES;
    
    [topView addSubview:self.sexImg];
    
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(78), self.icon.top + Height320(3), MSW-Width320(78) - 90.0, Height320(20))];
    
    self.nameLabel.textColor = UIColorFromRGB(0xffffff);
    
    self.nameLabel.font = AllFont(14);
    
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    //    self.nameLabel.backgroundColor = [UIColor redColor];
    [topView addSubview:self.nameLabel];
    
    self.phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.nameLabel.left, self.nameLabel.bottom + Height320(2), self.nameLabel.width, Height320(20))];
    
    self.phoneLabel.textColor = UIColorFromRGB(0xffffff);
    
    self.phoneLabel.font = AllFont(14);
    
    self.phoneLabel.textAlignment = NSTextAlignmentLeft;
    
    [topView addSubview:self.phoneLabel];
    
    CGFloat buttonWidth = MSW / 2.0;
    
    for (NSUInteger i = 0; i < 2; i ++)
    {
        YFButton *button = [[YFButton alloc] initWithFrame:CGRectMake(0 + (buttonWidth + 0.5) * i, topView.height - Height320(40.0), buttonWidth - 0.5, Height320(40)) imageFrame:CGRectMake(Width320(40.0), Height320(12.5), Width320(15.0), Height320(15.0)) titleFrame:CGRectMake(Width320(68), Height320(13.5), Width320(50.0), Height320(12.0))];
        [button setBackgroundColor:RGB_YF(61, 61, 61)];
        if (i == 0)
        {
            [button setTitle:@"拨打电话" forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"phoneStudentDetai"] forState:UIControlStateNormal];
        }else
        {
            [button setTitle:@"发送短信" forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"smsStudentDetai"] forState:UIControlStateNormal];
            
        }
        button.tag = i + 1;
        [button addTarget:self action:@selector(buttonPhoneAction:) forControlEvents:UIControlEventTouchUpInside];
        [button.titleLabel setFont:FontSizeFY(Width320(12.0))];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        
        [topView addSubview:button];
    }
}





- (void)buttonPhoneAction:(UIButton *)button
{
    if (button.tag == 1)
    {
        NSString *desStr = [NSString stringWithFormat:@"%@",self.viewModel.detailModel.phone];
        
        if ([UIDevice currentDevice].systemVersion.floatValue>=10.2) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.viewModel.detailModel.phone]]];
        }
        else{
            weakTypesYF
            [YFAppService showAlertMessage:desStr sureTitle:@"呼叫" sureBlock:^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",weakS.viewModel.detailModel.phone]]];
            }];
        }
    }
    else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms:%@",self.viewModel.detailModel.phone]]];
    }
}

- (YFSignUpViewModel *)viewModel
{
    if (!_viewModel)
    {
        _viewModel = [YFSignUpViewModel dataModel];
    }
    
    return _viewModel;
}


@end
