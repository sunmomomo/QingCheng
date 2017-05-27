//
//  WorkDetailController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/12/24.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "WorkDetailController.h"

#import "WorkEditController.h"

#import "WorkUneditableController.h"

#define kColor UIColorFromRGB(0x2a804a)

#define HiddenApi @"/api/experiences/%ld/hidden/"

#define DeleteApi @"/api/experiences/"

@interface WorkDetailController ()<UIActionSheetDelegate,UIAlertViewDelegate>
{
    
    UILabel *_titleLabel;
    
    UILabel *_timeLabel;
    
    UIImageView *_iconView;
    
    UIImageView *_certificateImgView;
    
    UILabel *_jobLabel;
    
    UILabel *_summaryLabel;
    
    UILabel *_courseNumLabel;
    
    UILabel *_coursePeopleLabel;
    
    UILabel *_privateNumLabel;
    
    UILabel *_privatePeopleLabel;
    
    UILabel *_saleLabel;
    
    UIView *_secView;
    
    UIView *_hideView;
    
    UILabel *_hideLabel;
    
    UIView *_firstView;
    
    UIView *_secondView;
    
    UIView *_thirdView;
    
}

@end

@implementation WorkDetailController

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
    
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@|%@",_work.title,_work.gym.city]];
    
    [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x666666) range:NSMakeRange(astr.length-_work.gym.city.length-1, _work.gym.city.length+1)];
    
    [astr addAttribute:NSFontAttributeName value:STFont(13) range:NSMakeRange(astr.length-_work.gym.city.length-1, _work.gym.city.length+1)];
    
    _titleLabel.attributedText = astr;
    
    if (!_work.gym.city.length) {
        
        _titleLabel.text = _work.gym.name;
        
    }
    
    _timeLabel.text = [NSString stringWithFormat:@"%@ 至%@",_work.startTime,[_work.endTime isEqualToString:@"3000-01-01"]?@"今":[@" " stringByAppendingString:_work.endTime]];
    
    [_iconView sd_setImageWithURL:_work.gym.imgUrl];
    
    [_titleLabel autoWidth];
    
    if (_titleLabel.right+Width320(30)+_certificateImgView.width>MSW) {
        
        [_titleLabel changeWidth:MSW-_certificateImgView.width-Width320(30)];
        
    }
    
    [_certificateImgView changeLeft:_titleLabel.right+Width320(5)];
    
    _certificateImgView.hidden = !_work.isVerified;
    
    _jobLabel.text = _work.job;
    
    _summaryLabel.text = _work.summary;
    
    [_summaryLabel autoHeight];
    
    _courseNumLabel.text = [NSString stringWithFormat:@"%ld",(long)_work.group_course];
    
    _coursePeopleLabel.text = [NSString stringWithFormat:@"%ld",(long)_work.group_user];
    
    _privateNumLabel.text = [NSString stringWithFormat:@"%ld",(long)_work.private_course];
    
    _privatePeopleLabel.text = [NSString stringWithFormat:@"%ld",(long)_work.private_user];
    
    _saleLabel.text = [NSString stringWithFormat:@"%ld",(long)_work.sale];
    
    _firstView.hidden = NO;
    
    _secondView.hidden = NO;
    
    _thirdView.hidden = NO;
    
    [_firstView changeTop:Height320(93)];
    
    [_secondView changeTop:_firstView.bottom+Height320(6)];
    
    [_thirdView changeTop:_secondView.bottom+Height320(6)];
    
    [_secView changeHeight:Height320(276)];
    
    if (!self.work.showGroup||(!self.work.group_course && !self.work.group_user)) {
        
        _firstView.hidden = YES;
        
        [_thirdView changeTop:_secondView.top];
        
        [_secondView changeTop:_firstView.top];
        
        [_secView changeHeight:_secView.height-Height320(58)];
        
    }
    
    if (!self.work.showPrivate||(!self.work.private_course && !self.work.private_user)) {
        
        _secondView.hidden = YES;
        
        [_thirdView changeTop:_secondView.top];
        
        [_secView changeHeight:_secView.height-Height320(58)];
        
    }
    
    if (!self.work.showSale||!self.work.sale) {
        
        _thirdView.hidden = YES;
        
        [_secView changeHeight:_secView.height-Height320(58)];
        
    }
    
    [self check];
    
}

-(void)check
{
    
    if (_work.isVerified) {
        
        _hideView.hidden = NO;
        
        [_secView changeTop:_hideView.bottom+Height320(12)];
        
        if (_work.isHide) {
            
            _hideLabel.text = @"该工作经历已隐藏";
            
            _hideLabel.textColor =UIColorFromRGB(0xffffff);
            
            _hideView.backgroundColor = UIColorFromRGB(0xee9162);
            
        }else
        {
            
            _hideLabel.text = @"同步自【健身房管理系统】";
            
            _hideLabel.textColor =UIColorFromRGB(0x999999);
            
            _hideView.backgroundColor = UIColorFromRGB(0xf9f9f9);
            
        }
        
    }else
    {
        
        _hideView.hidden = YES;
        
        [_secView changeTop:Height320(84)+64];
        
    }
    
}

-(void)createUI
{
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.title = @"工作经历详情";
    
    self.rightType = MONaviRightTypeMore;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64,MSW, Height320(72))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:topView];
    
    _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(16), Width320(40), Height320(40))];
    
    _iconView.layer.cornerRadius = _iconView.width/2;
    
    _iconView.layer.masksToBounds = YES;
    
    [topView addSubview:_iconView];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconView.right+Width320(8), Height320(20), Width320(196), Height320(18.7))];
    
    _titleLabel.font = STFont(16);
    
    [topView addSubview:_titleLabel];
    
    _certificateImgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(42), Height320(41), Width320(14), Height320(14))];
    
    _certificateImgView.layer.cornerRadius = _certificateImgView.width/2;
    
    _certificateImgView.layer.masksToBounds = YES;
    
    _certificateImgView.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
    
    _certificateImgView.layer.borderWidth = 1;
    
    _certificateImgView.image = [UIImage imageNamed:@"ic_qc_identify"];
    
    _certificateImgView.center = CGPointMake(_certificateImgView.center.x, _titleLabel.center.y);
    
    [topView addSubview:_certificateImgView];
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(3), Width320(200), Height320(15))];
    
    _timeLabel.textColor = UIColorFromRGB(0x666666);
    
    _timeLabel.font = STFont(13);
    
    [topView addSubview:_timeLabel];
    
    _hideView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom, MSW, Height320(28))];
    
    [self.view addSubview:_hideView];
    
    _hideLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(10), 0, Width320(260), _hideView.height)];
    
    _hideLabel.textColor = UIColorFromRGB(0xffffff);
    
    _hideLabel.font = STFont(14);
    
    [_hideView addSubview:_hideLabel];
    
    _secView = [[UIView alloc]initWithFrame:CGRectMake(0, _hideView.bottom+Height320(12), MSW, Height320(276))];
    
    _secView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:_secView];
    
    UIImageView *jobImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(20), Height320(11), Width320(14.4), Height320(16))];
    
    jobImg.image = [UIImage imageNamed:@"workcell1"];
    
    [_secView addSubview:jobImg];
    
    _jobLabel = [[UILabel alloc]initWithFrame:CGRectMake(jobImg.right+Width320(10), Height320(4), Width320(260), Height320(32))];
    
    _jobLabel.textColor = UIColorFromRGB(0x666666);
    
    _jobLabel.font = STFont(14);
    
    [_secView addSubview:_jobLabel];
    
    UIImageView *summaryImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(20), jobImg.bottom+Height320(16), Width320(14.4), Height320(16))];
    
    summaryImg.image = [UIImage imageNamed:@"workcell2"];
    
    [_secView addSubview:summaryImg];
    
    _summaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(_jobLabel.left,Height320(45), Width320(260), Height320(40))];
    
    _summaryLabel.textColor = UIColorFromRGB(0x666666);
    
    _summaryLabel.font = STFont(14);
    
    [_secView addSubview:_summaryLabel];
    
    _firstView = [[UIView alloc]initWithFrame:CGRectMake(Width320(20), Height320(93), MSW-Width320(40), Height320(52))];
    
    _firstView.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
    
    _firstView.layer.borderWidth = 1;
    
    [_secView addSubview:_firstView];
    
    UIView *firstSep = [[UIView alloc]initWithFrame:CGRectMake(Width320(72), Height320(6), 1, _firstView.height-Height320(12))];
    
    firstSep.backgroundColor = UIColorFromRGB(0xeeeeee);
    
    [_firstView addSubview:firstSep];
    
    UIImageView *firstImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(25), Height320(18), Width320(22), Height320(14))];
    
    firstImg.image = [UIImage imageNamed:@"workcell3"];
    
    [_firstView addSubview:firstImg];
    
    _courseNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstSep.right, Height320(7), (_firstView.width-firstSep.right)/2, Height320(21))];
    
    _courseNumLabel.textColor = kColor;
    
    _courseNumLabel.font = STFont(16);
    
    _courseNumLabel.textAlignment = NSTextAlignmentCenter;
    
    [_firstView addSubview:_courseNumLabel];
    
    _coursePeopleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_courseNumLabel.right, _courseNumLabel.top, _courseNumLabel.width, _courseNumLabel.height)];
    
    _coursePeopleLabel.textAlignment = NSTextAlignmentCenter;
    
    _coursePeopleLabel.textColor = kColor;
    
    _coursePeopleLabel.font = STFont(16);
    
    [_firstView addSubview:_coursePeopleLabel];
    
    UILabel *courseNumTitle = [[UILabel alloc]initWithFrame:CGRectMake(_courseNumLabel.left, _courseNumLabel.bottom, _courseNumLabel.width, _courseNumLabel.height)];
    
    courseNumTitle.text = @"团课节数";
    
    courseNumTitle.textColor = UIColorFromRGB(0x999999);
    
    courseNumTitle.textAlignment = NSTextAlignmentCenter;
    
    courseNumTitle.font = STFont(13);
    
    [_firstView addSubview:courseNumTitle];
    
    UILabel *coursePeopleTitle = [[UILabel alloc]initWithFrame:CGRectMake(courseNumTitle.right, courseNumTitle.top, courseNumTitle.width, courseNumTitle.height)];
    
    coursePeopleTitle.text = @"服务人次";
    
    coursePeopleTitle.textAlignment = NSTextAlignmentCenter;
    
    coursePeopleTitle.textColor = UIColorFromRGB(0x999999);
    
    coursePeopleTitle.font = STFont(13);
    
    [_firstView addSubview:coursePeopleTitle];
    
    _secondView = [[UIView alloc]initWithFrame:CGRectMake(Width320(20), _firstView.bottom+Height320(6), MSW-Width320(40), Height320(52))];
    
    _secondView.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
    
    _secondView.layer.borderWidth = 1;
    
    [_secView addSubview:_secondView];
    
    UIView *secondSep = [[UIView alloc]initWithFrame:CGRectMake(Width320(72), Height320(6), 1, _firstView.height-Height320(12))];
    
    secondSep.backgroundColor = UIColorFromRGB(0xeeeeee);
    
    [_secondView addSubview:secondSep];
    
    UIImageView *secondImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(27), Height320(17), Width320(18), Height320(18))];
    
    secondImg.image = [UIImage imageNamed:@"workcell4"];
    
    [_secondView addSubview:secondImg];
    
    _privateNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(secondSep.right, Height320(7), (_secondView.width-secondSep.right)/2, Height320(21))];
    
    _privateNumLabel.textColor = kColor;
    
    _privateNumLabel.font = STFont(16);
    
    _privateNumLabel.textAlignment = NSTextAlignmentCenter;
    
    [_secondView addSubview:_privateNumLabel];
    
    _privatePeopleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_privateNumLabel.right, _privateNumLabel.top, _privateNumLabel.width, _privateNumLabel.height)];
    
    _privatePeopleLabel.textAlignment = NSTextAlignmentCenter;
    
    _privatePeopleLabel.textColor = kColor;
    
    _privatePeopleLabel.font = STFont(16);
    
    [_secondView addSubview:_privatePeopleLabel];
    
    UILabel *privateNumTitle = [[UILabel alloc]initWithFrame:CGRectMake(_privateNumLabel.left, _privateNumLabel.bottom, _privateNumLabel.width, _privateNumLabel.height)];
    
    privateNumTitle.text = @"私教节数";
    
    privateNumTitle.textColor = UIColorFromRGB(0x999999);
    
    privateNumTitle.textAlignment = NSTextAlignmentCenter;
    
    privateNumTitle.font = STFont(13);
    
    [_secondView addSubview:privateNumTitle];
    
    UILabel *privatePeopleTitle = [[UILabel alloc]initWithFrame:CGRectMake(privateNumTitle.right, privateNumTitle.top, privateNumTitle.width, privateNumTitle.height)];
    
    privatePeopleTitle.text = @"服务人次";
    
    privatePeopleTitle.textAlignment = NSTextAlignmentCenter;
    
    privatePeopleTitle.textColor = UIColorFromRGB(0x999999);
    
    privatePeopleTitle.font = STFont(13);
    
    [_secondView addSubview:privatePeopleTitle];
    
    _thirdView = [[UIView alloc]initWithFrame:CGRectMake(Width320(20), _secondView.bottom+Height320(6), MSW-Width320(40), Height320(52))];
    
    _thirdView.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
    
    _thirdView.layer.borderWidth = 1;
    
    [_secView addSubview:_thirdView];
    
    UIView *thirdSep = [[UIView alloc]initWithFrame:CGRectMake(Width320(72), Height320(6), 1, _thirdView.height-Height320(12))];
    
    thirdSep.backgroundColor = UIColorFromRGB(0xeeeeee);
    
    [_thirdView addSubview:thirdSep];
    
    UIImageView *thirdImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(26), Height320(16), Width320(20), Height320(20))];
    
    thirdImg.image = [UIImage imageNamed:@"workcell5"];
    
    [_thirdView addSubview:thirdImg];
    
    _saleLabel = [[UILabel alloc]initWithFrame:CGRectMake(thirdSep.right, Height320(7), _thirdView.width-thirdSep.right, Height320(21))];
    
    _saleLabel.textColor = kColor;
    
    _saleLabel.font = STFont(16);
    
    _saleLabel.textAlignment = NSTextAlignmentCenter;
    
    [_thirdView addSubview:_saleLabel];
    
    UILabel *saleTitle = [[UILabel alloc]initWithFrame:CGRectMake(_saleLabel.left, _saleLabel.bottom, _saleLabel.width, _saleLabel.height)];
    
    saleTitle.text = @"销售额（元）";
    
    saleTitle.textColor = UIColorFromRGB(0x999999);
    
    saleTitle.textAlignment = NSTextAlignmentCenter;
    
    saleTitle.font = STFont(13);
    
    [_thirdView addSubview:saleTitle];
    
    [self check];
    
}

-(void)naviRightClick
{
    
    if (_work.isVerified) {
        
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:_work.isHide?@"取消隐藏":@"隐藏",@"编辑", nil];
        
        [sheet showInView:self.view];
        
    }else
    {
        
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除工作经历" otherButtonTitles:@"编辑", nil];
        
        [sheet showInView:self.view];
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        NSString *api = [NSString stringWithFormat:@"%@%ld/",DeleteApi,(long)self.work.workId];
        
        [MOAFHelp AFDeleteHost:ROOT bindPath:api deleteParam:nil success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"]integerValue]== 200) {
                
                [self.navigationController popViewControllerAnimated:YES];
                
                if (self.editFinish) {
                    self.editFinish();
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

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (_work.isVerified) {
        
        if (buttonIndex == 0) {
            
            Parameters *para = [[Parameters alloc]init];
            
            [para setParameter:[NSNumber numberWithBool:!_work.isHide] forKey:@"is_hidden"];
            
            [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:HiddenApi,(long)_work.workId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
                
                if ([responseDic[@"status"]integerValue]==200) {
                    
                    [self hideSuccess];
                    
                }
                
            } failure:^(AFHTTPSessionManager *operation, NSString *error) {
                
            }];
            
        }else{
            
            WorkUneditableController *svc = [[WorkUneditableController alloc]init];
            
            svc.work = [self.work copy];
            
            __weak typeof(self)weakS = self;
            
            svc.editFinish = ^(Work *work){
                
                weakS.work = work;
                
                if (weakS.editFinish) {
                    weakS.editFinish();
                }
                
                [weakS createData];
                
            };
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }
        
    }else{
        
        if (buttonIndex == 0) {
            
            [[[UIAlertView alloc]initWithTitle:@"确定删除该资质认证吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil]show];
            
        }else if(buttonIndex == 1)
        {
            
            WorkEditController *svc = [[WorkEditController alloc]init];
            
            svc.work = [self.work copy];
            
            __weak typeof(self)weakS = self;
            
            svc.editFinish = ^(Work *work){
                
                weakS.work = work;
                
                if (weakS.editFinish) {
                    weakS.editFinish();
                }
                
                [weakS createData];
                
            };
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }
        
    }
    
}

-(void)hideSuccess
{
    
    if (self.editFinish) {
        self.editFinish();
    }
    
    _work.isHide = !_work.isHide;
    
    NSString *str = _work.isHide?@"隐藏成功！":@"取消隐藏成功！";
    
    UILabel *hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW/2-Width320(56), MSH-Height320(66), Width320(112), Height320(28))];
    
    hintLabel.backgroundColor = [UIColorFromRGB(0x4e4e4e) colorWithAlphaComponent:0.9];
    
    hintLabel.textColor = UIColorFromRGB(0xffffff);
    
    hintLabel.textAlignment = NSTextAlignmentCenter;
    
    hintLabel.font = STFont(14);
    
    hintLabel.text = str;
    
    [self.view addSubview:hintLabel];
    
    [self check];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [hintLabel removeFromSuperview];
        
    });
    
}


@end
