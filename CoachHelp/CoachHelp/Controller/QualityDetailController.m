//
//  QualityDetailController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/23.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "QualityDetailController.h"

#import "QualityMatchEditController.h"

#import "QualityMeetingEditController.h"

#import "QualityTrainEditController.h"

#import "PictureShowController.h"

#define kDeleteAPI @"/api/certificates/"

#define kHideAPI @"/api/certificates/%ld/hidden/"

@interface QualityDetailController ()<UIActionSheetDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)UIScrollView *mainView;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UIImageView *verifyImg;

@property(nonatomic,strong)UILabel *organLabel;

@property(nonatomic,strong)UILabel *getLabel;

@property(nonatomic,strong)UILabel *timeLabel;

@property(nonatomic,strong)UILabel *hideLabel;

@property(nonatomic,strong)UIView *hideView;

@property(nonatomic,strong)UIImageView *photo;

@end

@implementation QualityDetailController

- (void)viewDidLoad {
    
    [super viewDidLoad];
        
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self createUI];
    
    [self createData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    self.titleLabel.text = self.quality.title;
    
    [self.titleLabel autoWidth];
    
    [self.verifyImg changeLeft:self.titleLabel.right+Width320(5)];
    
    self.organLabel.text = self.quality.organization.name;
    
    self.timeLabel.text = !self.quality.willExpired?@"长期有效":[self.quality.endTime isEqualToString:@"3000-01-01"]?@"长期有效":self.quality.startTime.length &&self.quality.endTime.length?[NSString stringWithFormat:@"有效期：%@至%@",self.quality.startTime,self.quality.endTime]:@"长期有效";
    
    self.getLabel.text = [NSString stringWithFormat:@"发证日期：%@",self.quality.issueTime];
    
    [self.photo sd_setImageWithURL:self.quality.photo completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image) {
            
            [self.photo changeHeight:image.size.height/image.size.width*(MSW-Width320(32))];
            
        }
        
        [self.mainView setContentSize:CGSizeMake(0, self.photo.bottom+Height320(20))];
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"资质认证详情";
    
    if (self.quality.isVerified) {
        
        self.rightTitle = self.quality.isHidden?@"取消隐藏":@"隐藏";
        
    }else
    {
        
        self.rightType = MONaviRightTypeMore;
        
    }
    
    self.mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.mainView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:self.mainView];
        
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(16), MSW-Width320(32), Height320(18))];
    
    self.titleLabel.textColor = UIColorFromRGB(0x222222);
    
    self.titleLabel.font = STFont(15);
    
    [self.mainView addSubview:self.titleLabel];
    
    if (self.quality.isVerified) {
        
        self.verifyImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, Height320(18), Width320(14), Height320(14))];
        
        self.verifyImg.image = [UIImage imageNamed:@"ic_qc_identify"];
        
        [self.mainView addSubview:self.verifyImg];
        
    }
    
    if (self.quality.isVerified) {
        
        self.hideView = [[UIView alloc]initWithFrame:CGRectMake(0, self.titleLabel.bottom+Height320(10), MSW, Height320(28))];
        
        self.hideView.backgroundColor = self.quality.isHidden?UIColorFromRGB(0xee9162):UIColorFromRGB(0xf9f9f9);
        
        [self.mainView addSubview:self.hideView];
        
        self.hideLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(260), _hideView.height)];
        
        self.hideLabel.text = self.quality.isHidden?@"该资质认证已隐藏":[NSString stringWithFormat:@"来自【%@】",self.quality.organization.name];
        
        self.hideLabel.textColor = self.quality.isHidden?UIColorFromRGB(0xffffff):UIColorFromRGB(0x999999);
        
        self.hideLabel.font = STFont(14);
        
        [self.hideView addSubview:self.hideLabel];
        
    }
    
    UIImageView *organizationImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16),self.quality.isVerified?self.titleLabel.bottom+Height320(54):self.titleLabel.bottom+Height320(11), Width320(15), Height320(15))];
    
    organizationImg.image = [UIImage imageNamed:@"organization"];
    
    [self.mainView addSubview:organizationImg];
    
    self.organLabel = [[UILabel alloc]initWithFrame:CGRectMake(organizationImg.right+Width320(12), organizationImg.top, MSW-Width320(28)-organizationImg.right, Height320(15))];
    
    self.organLabel.textColor = UIColorFromRGB(0x747474);
    
    self.organLabel.font = STFont(14);
    
    self.organLabel.center = CGPointMake(self.organLabel.center.x, organizationImg.center.y);
    
    [self.mainView addSubview:self.organLabel];
    
    UIImageView *getImg = [[UIImageView alloc]initWithFrame:CGRectMake(organizationImg.left, organizationImg.bottom+Height320(7.5), organizationImg.width, organizationImg.height)];
    
    getImg.contentMode = UIViewContentModeScaleAspectFit;
    
    getImg.image = [UIImage imageNamed:@"gettime"];
    
    [self.mainView addSubview:getImg];
    
    self.getLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.organLabel.left, getImg.top, self.organLabel.width, self.organLabel.height)];
    
    self.getLabel.textColor = UIColorFromRGB(0x747474);
    
    self.getLabel.font = STFont(14);
    
    self.getLabel.center = CGPointMake(self.getLabel.center.x, getImg.center.y);
    
    [self.mainView addSubview:self.getLabel];
    
    UIImageView *timeImg = [[UIImageView alloc]initWithFrame:CGRectMake(organizationImg.left, getImg.bottom+Height320(7.5), organizationImg.width, organizationImg.height)];
    
    timeImg.image = [UIImage imageNamed:@"schedule"];
    
    [self.mainView addSubview:timeImg];
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.organLabel.left, timeImg.top, self.organLabel.width, self.organLabel.height)];
    
    self.timeLabel.textColor = UIColorFromRGB(0x747474);
    
    self.timeLabel.font = STFont(14);
    
    self.timeLabel.center = CGPointMake(self.timeLabel.center.x, timeImg.center.y);
    
    [self.mainView addSubview:self.timeLabel];
    
    self.photo = [[UIImageView alloc]initWithFrame:CGRectMake(organizationImg.left, self.timeLabel.bottom+Height320(13), MSW-organizationImg.left*2, Height320(216))];
    
    self.photo.contentMode = UIViewContentModeScaleAspectFit;
    
    self.photo.userInteractionEnabled = YES;
    
    [self.photo addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoClick:)]];
    
    [self.mainView addSubview:self.photo];
    
}

-(void)photoClick:(UITapGestureRecognizer*)tap
{
    
    if (self.quality.photo.absoluteString.length) {
        
        PictureShowController *svc = [[PictureShowController alloc]init];
        
        svc.imageURL = self.quality.photo;
        
        [self presentViewController:svc animated:YES completion:nil];
        
    }
    
}

-(void)naviRightClick
{
    
    if (self.quality.isVerified) {
        
        Parameters *para = [[Parameters alloc]init];
        
        [para setParameter:[NSNumber numberWithBool:!_quality.isHidden] forKey:@"is_hidden"];
        
        [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:kHideAPI,(long)_quality.qualityId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"]integerValue]==200) {
                
                [self hideSuccess];
                
            }
            
        } failure:^(AFHTTPSessionManager *operation, NSString *error) {
            
        }];
        
        
    }else
    {
        
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"编辑",@"删除资质认证", nil];
        
        [actionSheet showInView:self.view];
        
        
    }
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
        
        if (self.quality.type == QualityTypeMeeting) {
            
            QualityMeetingEditController *svc = [[QualityMeetingEditController alloc]init];
            
            svc.quality = self.quality;
            
            __weak typeof(self)weakS = self;
            
            svc.editFinish = ^(Quality *quality){
                
                weakS.quality = quality;
                
                if (weakS.edit) {
                    weakS.edit();
                }
                
                [weakS createData];
                
            };
            
            [weakS.navigationController pushViewController:svc animated:YES];
            
        }else if (self.quality.type == QualityTypeTrain){
            
            QualityTrainEditController *svc = [[QualityTrainEditController alloc]init];
            
            svc.quality = self.quality;
            
            __weak typeof(self)weakS = self;
            
            svc.editFinish = ^(Quality *quality){
                
                weakS.quality = quality;
                
                if (weakS.edit) {
                    weakS.edit();
                }
                
                [weakS createData];
                
            };
            
            [weakS.navigationController pushViewController:svc animated:YES];
            
        }else
        {
            
            QualityMatchEditController *svc = [[QualityMatchEditController alloc]init];
            
            svc.quality = self.quality;
            
            __weak typeof(self)weakS = self;
            
            svc.editFinish = ^(Quality *quality){
                
                weakS.quality = quality;
                
                if (weakS.edit) {
                    weakS.edit();
                }
                
                [weakS createData];
                
            };
            
            [weakS.navigationController pushViewController:svc animated:YES];
            
        }
        
    }else if(buttonIndex == 1)
    {
        
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"删除此条资质" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        alert.delegate = self;
        
        [alert show];
        
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        NSString *api = [NSString stringWithFormat:@"%@%ld/",kDeleteAPI,(long)self.quality.qualityId];
        
        [MOAFHelp AFDeleteHost:ROOT bindPath:api deleteParam:nil success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"]integerValue]== 200) {
                
                [self.navigationController popViewControllerAnimated:YES];
                
                if (self.edit) {
                    self.edit();
                }
                
            }else
            {
                
                [[[UIAlertView alloc]initWithTitle:@"删除失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
            }
            
        } failure:^(AFHTTPSessionManager *operation, NSString *error) {
            
            [[[UIAlertView alloc]initWithTitle:error message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }];
        
    }
    
}

-(void)hideSuccess
{
    
    if (self.edit) {
        self.edit();
    }
    
    _quality.isHidden = !_quality.isHidden;
    
    NSString *str = _quality.isHidden?@"隐藏成功！":@"取消隐藏成功！";
    
    UILabel *hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW/2-Width320(56), MSH-64-Height320(66), Width320(112), Height320(28))];
    
    hintLabel.backgroundColor = [UIColorFromRGB(0x4e4e4e) colorWithAlphaComponent:0.9];
    
    hintLabel.textColor = UIColorFromRGB(0xffffff);
    
    hintLabel.textAlignment = NSTextAlignmentCenter;
    
    hintLabel.font = STFont(14);
    
    hintLabel.text = str;
    
    [self.mainView addSubview:hintLabel];
    
    [self check];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [hintLabel removeFromSuperview];
        
    });
    
}

-(void)check
{
    
    if (_quality.isHidden) {
        
        self.rightTitle = @"取消隐藏";
        
        self.hideLabel.text = @"该资质认证已隐藏";
        
        self.hideLabel.textColor =UIColorFromRGB(0xffffff);
        
        self.hideView.backgroundColor = UIColorFromRGB(0xee9162);
        
    }else
    {
        
        self.rightTitle = @"隐藏";
        
        self.hideLabel.text = [NSString stringWithFormat:@"来自【%@】",self.quality.organization.name];
        
        self.hideLabel.textColor =UIColorFromRGB(0x999999);
        
        self.hideView.backgroundColor = UIColorFromRGB(0xf9f9f9);
        
    }
    
}

@end
