//
//  WorkUneditableController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 2017/3/7.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "WorkUneditableController.h"

#import "QCTextField.h"

#import "QCTextView.h"

#import "MOSwitchCell.h"

#define API @"/api/experiences/"

@interface WorkUneditableController ()<MOSwitchCellDelegate>

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *subtitleLabel;

@property(nonatomic,strong)UIScrollView *mainView;

@property(nonatomic,strong)QCTextField *startTF;

@property(nonatomic,strong)QCTextField *endTF;

@property(nonatomic,strong)QCTextField *jobTF;

@property(nonatomic,strong)QCTextView *introTV;

@property(nonatomic,strong)QCTextField *groupTF;

@property(nonatomic,strong)MOSwitchCell *groupCell;

@property(nonatomic,strong)QCTextField *privateTF;

@property(nonatomic,strong)MOSwitchCell *privateCell;

@property(nonatomic,strong)QCTextField *saleTF;

@property(nonatomic,strong)MOSwitchCell *saleCell;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)UIView *thirdView;

@end

@implementation WorkUneditableController

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
    
    self.title = @"编辑工作经历";
    
    self.rightTitle = @"保存";
    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.mainView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.view addSubview:self.mainView];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(66))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.mainView addSubview:topView];
    
    self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(13), Width320(40), Height320(40))];
    
    self.iconView.layer.cornerRadius = self.iconView.width/2;
    
    self.iconView.layer.masksToBounds = YES;
    
    [self.iconView sd_setImageWithURL:self.work.gym.imgUrl];
    
    [topView addSubview:self.iconView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.iconView.right+Width320(8), Height320(16), Width320(240), Height320(18))];
    
    self.titleLabel.textColor = UIColorFromRGB(0x222222);
    
    self.titleLabel.font = STFont(16);
    
    self.titleLabel.text = self.work.gym.name;
    
    [topView addSubview:self.titleLabel];
    
    self.subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom+Height320(3), self.titleLabel.width, Height320(18))];
    
    self.subtitleLabel.textColor = UIColorFromRGB(0x999999);
    
    self.subtitleLabel.font = STFont(14);
    
    self.subtitleLabel.text = [NSString stringWithFormat:@"%@%@",self.work.gym.city.length?[self.work.gym.city stringByAppendingString:@"    "]:@"",self.work.gym.brandName.length?self.work.gym.brandName:@""];
    
    [topView addSubview:self.subtitleLabel];
    
    UIView *secView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(10), MSW, Height320(224))];
    
    secView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.mainView addSubview:secView];
    
    self.startTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(21.3), 0, MSW-Width320(42.6), Height320(37))];
    
    self.startTF.placeholder = @"入职时间";
    
    self.startTF.text = _work.startTime;
    
    self.startTF.placeholderColor = UIColorFromRGB(0x999999);
    
    self.startTF.textColor = UIColorFromRGB(0xcccccc);
    
    self.startTF.userInteractionEnabled = NO;
    
    [secView addSubview:self.startTF];
    
    self.endTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.startTF.left, self.startTF.bottom, self.startTF.width, self.startTF.height)];
    
    self.endTF.placeholder = @"离职时间";
    
    self.endTF.text = [_work.endTime isEqualToString:@"3000-01-01"]?@"至今":_work.endTime;
    
    self.endTF.placeholderColor = UIColorFromRGB(0x999999);
    
    self.endTF.textColor = UIColorFromRGB(0xcccccc);
    
    self.endTF.userInteractionEnabled = NO;
    
    [secView addSubview:self.endTF];
    
    self.jobTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.startTF.left, self.endTF.bottom, self.startTF.width, self.startTF.height)];
    
    self.jobTF.placeholder = @"职位";
    
    self.jobTF.text = _work.job;
    
    self.jobTF.placeholderColor = UIColorFromRGB(0x999999);
    
    self.jobTF.textColor = UIColorFromRGB(0xcccccc);
    
    self.jobTF.userInteractionEnabled = NO;
    
    [secView addSubview:self.jobTF];
    
    self.introTV = [[QCTextView alloc]initWithFrame:CGRectMake(self.jobTF.left-5, self.jobTF.bottom, self.jobTF.width, secView.height-self.jobTF.bottom)];
    
    self.introTV.placeholder = @"描述";
    
    self.introTV.placeholderColor = UIColorFromRGB(0x999999);
    
    self.introTV.text = _work.descriptions;
    
    [secView addSubview:self.introTV];
    
    self.thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, secView.bottom+Height320(12), MSW, Height320(40)*6)];
    
    self.thirdView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.thirdView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.thirdView.layer.borderWidth = OnePX;
    
    [self.mainView addSubview:self.thirdView];
    
    self.groupCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.groupCell.titleLabel.text = @"展示团课业绩";
    
    self.groupCell.titleLabel.textColor = UIColorFromRGB(0x333333);
    
    self.groupCell.delegate = self;
    
    [self.thirdView addSubview:self.groupCell];
    
    self.groupTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), self.groupCell.bottom, MSW-Width320(32), Height320(40))];
    
    self.groupTF.placeholder = [NSString stringWithFormat:@"团课%ld节 服务%ld人次",(long)self.work.group_course,(long)self.work.group_user];
    
    self.groupTF.placeholderColor = UIColorFromRGB(0x999999);
    
    self.groupTF.userInteractionEnabled = NO;
    
    [self.thirdView addSubview:self.groupTF];
    
    self.privateCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), self.groupTF.bottom, MSW-Width320(32), Height320(40))];
    
    self.privateCell.titleLabel.text = @"展示私教业绩";
    
    self.privateCell.titleLabel.textColor = UIColorFromRGB(0x333333);
    
    self.privateCell.delegate = self;
    
    [self.thirdView addSubview:self.privateCell];
    
    self.privateTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), self.privateCell.bottom, MSW, Height320(40))];
    
    self.privateTF.placeholder = [NSString stringWithFormat:@"私教%ld节 服务%ld人次",(long)self.work.private_course,(long)self.work.private_user];
    
    self.privateTF.placeholderColor = UIColorFromRGB(0x999999);
    
    self.privateTF.userInteractionEnabled = NO;
    
    [self.thirdView addSubview:self.privateTF];
    
    self.saleCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), self.privateTF.bottom, MSW-Width320(32), Height320(40))];
    
    self.saleCell.titleLabel.text = @"展示销售业绩";
    
    self.saleCell.titleLabel.textColor = UIColorFromRGB(0x333333);
    
    self.saleCell.delegate = self;
    
    [self.thirdView addSubview:self.saleCell];
    
    self.saleTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), self.saleCell.bottom, MSW, Height320(40))];
    
    self.saleTF.placeholder = [NSString stringWithFormat:@"销售额达%ld元",(long)self.work.sale];
    
    self.saleTF.placeholderColor = UIColorFromRGB(0x999999);
    
    self.saleTF.userInteractionEnabled = NO;
    
    self.saleTF.noLine = YES;
    
    [self.thirdView addSubview:self.saleTF];
    
    [self reloadSaleView];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    self.hud.mode = MBProgressHUDModeText;
    
    [self.view addSubview:self.hud];
    
}

-(void)reloadSaleView
{
    
    self.groupCell.on = self.work.showGroup;
    
    self.groupTF.hidden = !self.work.showGroup;
    
    [self.privateCell changeTop:self.groupTF.hidden?self.groupCell.bottom:self.groupTF.bottom];
    
    self.privateCell.on = self.work.showPrivate;
    
    [self.privateTF changeTop:self.privateCell.bottom];
    
    self.privateTF.hidden = !self.work.showPrivate;
    
    [self.saleCell changeTop:self.privateTF.hidden?self.privateCell.bottom:self.privateTF.bottom];
    
    self.saleCell.on = self.work.showSale;
    
    [self.saleTF changeTop:self.saleCell.bottom];
    
    self.saleTF.hidden = !self.work.showSale;
    
    self.saleCell.noLine = !self.work.showSale;
    
    [self.thirdView changeHeight:self.saleTF.hidden?self.saleCell.bottom:self.saleTF.bottom];
    
    self.mainView.contentSize = CGSizeMake(0, self.thirdView.bottom+Height(12));
    
}

-(void)switchCellSwitchChanged:(MOSwitchCell *)cell
{
    
    if (cell == self.groupCell) {
        
        self.work.showGroup = cell.on;
        
    }else if (cell == self.privateCell){
        
        self.work.showPrivate = cell.on;
        
    }else{
        
        self.work.showSale = cell.on;
        
    }
    
    [self reloadSaleView];
    
}

-(void)naviRightClick
{
    
    self.rightButtonEnable = NO;
    
    self.hud.mode = MBProgressHUDModeIndeterminate;
    
    self.hud.label.text = @"";
    
    [self.hud showAnimated:YES];
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:self.introTV.text forKey:@"description"];
    
    [para setParameter:[NSNumber numberWithBool:!self.groupCell.on] forKey:@"group_is_hidden"];
    
    [para setParameter:[NSNumber numberWithBool:!self.privateCell.on] forKey:@"private_is_hidden"];
    
    [para setParameter:[NSNumber numberWithBool:!self.saleCell.on] forKey:@"sale_is_hidden"];
    
    NSString *api = [NSString stringWithFormat:@"%@%ld/",API,(long)self.work.workId];
    
    [MOAFHelp AFPutHost:ROOT bindPath:api putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        self.rightButtonEnable = YES;
        
        if ([responseDic[@"status"]integerValue]==200) {
            
            self.hud.mode = MBProgressHUDModeText;
            
            self.hud.label.text = @"修改成功";
            
            [self.hud showAnimated:YES];
            
            [self.hud hideAnimated:YES afterDelay:1.0f];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                self.work.job = self.jobTF.text;
                
                self.work.summary = self.introTV.text;
                
                if (self.editFinish) {
                    self.editFinish(self.work);
                }
                
                [self.navigationController popViewControllerAnimated:YES];
                
            });
            
        }else
        {
            
            [self errorWithInfo:responseDic[@"msg"]];
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.rightButtonEnable = YES;
        
        [self errorWithInfo:error];
        
    }];
    
}


-(void)errorWithInfo:(NSString *)info
{
    
    self.hud.mode = MBProgressHUDModeText;
    
    self.hud.label.text = info;
    
    [self.hud showAnimated:YES];
    
    [self.hud hideAnimated:YES afterDelay:1.0f];
    
}

@end
