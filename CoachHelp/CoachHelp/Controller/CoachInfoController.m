//
//  CoachInfoController.m
//  健身教练助手
//
//  Created by 馍馍帝😈 on 15/8/13.
//  Copyright (c) 2015年 馍馍帝. All rights reserved.
//

#import "CoachInfoController.h"

#import "ChooseView.h"

#import "WorkCell.h"

#import "QualityCell.h"

#import "QualitiesInfo.h"

#import "WorksInfo.h"

#import "UserDetailInfo.h"

#import "MOLableView.h"

#import "MOSawtoothView.h"

#import "MOStarRateView.h"

#import "CoachRemarkInfo.h"

#import "QualityDetailController.h"

#import "SettingController.h"

#import "RootController.h"

#import "IntroView.h"

#import "ShareActionSheet.h"

#import "PictureShowController.h"

static NSString *wIdentifier = @"Work";

static NSString *qIdentifier = @"Quality";

@interface TopButton : UIButton

{
    
    UIImageView *_img;
    
}

@property(nonatomic,strong)UIImage *image;

@end

@implementation TopButton

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        _img = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, frame.size.width-16, frame.size.height-16)];
        
        _img.contentMode = UIViewContentModeScaleAspectFit;
        
        _img.userInteractionEnabled = NO;
        
        [self addSubview:_img];
        
    }
    
    return self;
    
}

-(void)setImage:(UIImage *)image
{
    
    _image = image;
    
    _img.image = _image;
    
}

@end

@interface CoachInfoController ()<ChooseViewDatasource,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,ShareActionSheetDelegate,IntroViewDelegate,QualityCellDelegate>

@property(nonatomic,strong)UIView *mainView;

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UIScrollView *topView;

@property(nonatomic,strong)UIScrollView *bottomView;

@property(nonatomic,strong)UIView *secView;

@property(nonatomic,strong)UIImageView *sexImg;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *introLabel;

@property(nonatomic,strong)UILabel *cityLabel;

@property(nonatomic,strong)UILabel *coursePrice;

@property(nonatomic,strong)UILabel *coachPrice;

@property(nonatomic,strong)MOStarRateView *coachStar;

@property(nonatomic,strong)MOStarRateView *courseStar;

@property(nonatomic,strong)UILabel *totalLabel;

@property(nonatomic,strong)MOLableView *coachTagView;

@property(nonatomic,strong)MOLableView *stuRemarkView;

@property(nonatomic,strong)ChooseView *chooseView;

@property(nonatomic,strong)NSArray *chooseTitleArray;

@property(nonatomic,strong)UITableView *workView;

@property(nonatomic,strong)UITableView *qualityView;

@property(nonatomic,strong)UITableView *introView;

@property(nonatomic,strong)UILabel *hintLabel;

@property(nonatomic,strong)NSMutableArray *workMoreArray;

@property(nonatomic,strong)WorksInfo *worksInfo;

@property(nonatomic,strong)QualitiesInfo *qualitiesInfo;

@property(nonatomic,strong)User *user;

@property(nonatomic,strong)CoachRemarkInfo *coachRemarkInfo;

@property(nonatomic,strong)UIView *shareView;

@property(nonatomic,strong)IntroView *myIntroView;

@property(nonatomic,strong)UIScrollView *infoView;

@property(nonatomic,assign)BOOL coachEmpty;

@property(nonatomic,strong)UILabel *goodAtLabel;

@end

@implementation CoachInfoController

-(instancetype)init
{
    
    if (self = [super init]) {
        
        self.chooseTitleArray = @[@"基本信息",@"资质认证",@"工作经历",@"学员评价"];

    }
    
    return self;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)createData
{
    UserDetailInfo *userInfo = [[UserDetailInfo alloc]init];
    
    [userInfo requestResult:^(BOOL success, NSString *error) {
        
        self.user = userInfo.user;
        
        if (self.user.iconURL.absoluteString) {
            
            if ([self.user.iconURL.absoluteString rangeOfString:@"!"].length) {
                
                [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.user.iconURL.absoluteString] placeholderImage:[UIImage imageNamed:self.user.sex == SexTypeWoman?@"icon_female":@"icon_male"]];
                
            }else{
                
                if ([self.user.iconURL.absoluteString rangeOfString:@"!/watermark/"].length) {
                    
                    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@!small/watermark/%@",[[self.user.iconURL.absoluteString componentsSeparatedByString:@"!/watermark/"]firstObject],[[self.user.iconURL.absoluteString componentsSeparatedByString:@"!/watermark/"]lastObject]]] placeholderImage:[UIImage imageNamed:self.user.sex == SexTypeWoman?@"icon_female":@"icon_male"]];
                    
                }else if ([self.user.iconURL.absoluteString rangeOfString:@"/watermark/"].length){
                    
                    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.user.iconURL.absoluteString] placeholderImage:[UIImage imageNamed:self.user.sex == SexTypeWoman?@"icon_female":@"icon_male"]];
                    
                }else{
                    
                    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[self.user.iconURL.absoluteString stringByAppendingString:@"!small"]] placeholderImage:[UIImage imageNamed:self.user.sex == SexTypeWoman?@"icon_female":@"icon_male"]];
                    
                }
                
            }
            
        }
        
        self.sexImg.image = [UIImage imageNamed:self.user.sex == SexTypeMan?@"sex_male":@"sex_female"];
        
        self.nameLabel.text = self.user.username;
        
        self.introLabel.text = self.user.shortIntro;
        
        if (!self.user.shortIntro.length) {
            
            self.introLabel.text = @"这个人很懒，什么也没有写";
            
        }
        
        self.cityLabel.text = self.user.city;
        
        if(!self.user.city.length){
            
            self.cityLabel.text = @"尚未填写";
            
        }
        
        self.coachPrice.text = [NSString stringWithFormat:@"%.1f",self.user.coachScore];
        
        self.coursePrice.text = [NSString stringWithFormat:@"%.1f",self.user.courseScore];
        
        self.coachStar.scorePercent = self.user.coachScore;
        
        self.courseStar.scorePercent = self.user.courseScore;
        
        NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"评分基于\n%ld条评价",(long)self.user.totalCount]];
        
        [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xEDA640) range:NSMakeRange(4, astr.length-7)];
        
        self.totalLabel.attributedText = astr;
        
        if (!self.user.totalCount) {
            
            self.totalLabel.text = @"暂无评价";
            
        }
        
        self.coachTagView.dataArray = self.user.tags;
        
        NSMutableAttributedString *astr1;
        
        if (!self.user.tags.count) {
            
            astr1 = [[NSMutableAttributedString alloc]initWithString:@"擅长  (根据课程计划统计):暂无数据"];
            
            [astr1 addAttribute:NSFontAttributeName value:STFont(13) range:NSMakeRange(astr1.length-15, 15)];
            
        }else
        {
            astr1 = [[NSMutableAttributedString alloc]initWithString:@"擅长  (根据课程计划统计):"];
            
            [astr1 addAttribute:NSFontAttributeName value:STFont(13) range:NSMakeRange(astr1.length-11, 11)];
            
        }
        
        self.goodAtLabel.attributedText = astr1;
        
        [self.secView changeHeight:self.coachTagView.bottom+Height320(14.2)];
        
        [self.topView setContentSize:CGSizeMake(0, self.secView.bottom)];
        
        [self.chooseView reloadData];
        
        [self createBottomData];
        
        [self.topView.mj_header endRefreshing];
        
    }];
    
}

-(void)createBottomData
{
    
    __weak typeof(self)weakS = self;
    
    WorksInfo *workInfo = [[WorksInfo alloc]init];
    
    workInfo.noHide = YES;
    
    __weak typeof(WorksInfo *)weakWInfo = workInfo;
    
    workInfo.request = ^(BOOL success){
        
        if (success) {
            
            weakS.worksInfo = weakWInfo;
            
            [weakS.workView reloadData];
            
            [weakS.chooseView reloadData];
            
        }
        
    };
    
    [workInfo updataData];
    
    QualitiesInfo *qualityInfo = [[QualitiesInfo alloc]init];
    
    qualityInfo.noHide = YES;
    
    __weak typeof(QualitiesInfo *)weakQInfo = qualityInfo;
    
    qualityInfo.request = ^(BOOL success){
        
        if (success) {
            
            weakS.qualitiesInfo = weakQInfo;
            
            [weakS.qualityView reloadData];
            
            [weakS.chooseView reloadData];
            
        }
        
    };
    
    [qualityInfo updataData];
    
    CoachRemarkInfo *coachRemarkInfo = [[CoachRemarkInfo alloc]init];
    
    __weak typeof(CoachRemarkInfo*)weakCRInfo = coachRemarkInfo;
    
    coachRemarkInfo.request = ^(BOOL success){
        
        if (success) {
            
            weakS.coachRemarkInfo = weakCRInfo;
            
            weakS.coachEmpty = NO;
            
            if (!weakS.coachRemarkInfo.tags.count) {
                
                weakS.coachEmpty = YES;
                
            }
            
            [weakS.chooseView reloadData];
            
        }else
        {
            
            weakS.coachEmpty = YES;
            
        }
        
    };
    
}

-(void)createUI
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationBarColor = [UIColor clearColor];
    
    self.title = @"我的主页";
    
    self.rightType = MONaviRightTypeShare;

    self.mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
    [self.view addSubview:self.mainView];
    
    self.topView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
    self.topView.contentSize = CGSizeMake(0, 0);
    
    self.topView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(createData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.topView.mj_header = header;
    
    self.topView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        [self.topView.mj_footer endRefreshing];
        
        [UIView animateWithDuration:0.5f animations:^{
            
            [self.topView changeTop:-MSH];
            
            [self.bottomView changeTop:0];
            
            self.navigationBarColor = kMainColor;

        }];
        
    }];
    
    [self.mainView addSubview:self.topView];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(153))];
    
    topView.backgroundColor = kMainColor;
    
    [self.topView addSubview:topView];
    
    MOSawtoothView *sawView = [[MOSawtoothView alloc]initWithFrame:CGRectMake(0, topView.bottom, MSW, Height320(122.5)) topLineSeparatorType:MOSeparatorTypeNone bottomLineSeparatorType:MOSeparatorTypeJagged];
    
    sawView.backgroundColor = UIColorFromRGB(0xffffff);
    
    sawView.fillColor = UIColorFromRGB(0xf4f4f4);
    
    sawView.bottomStrokeColor = UIColorFromRGB(0xffffff);
    
    [self.topView addSubview:sawView];
    
    self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW/2-Width320(34.5), topView.bottom-Height320(53), Width320(69), Height320(69))];
    
    self.iconView.backgroundColor = [UIColor whiteColor];
    
    self.iconView.layer.cornerRadius = self.iconView.width/2;
    
    self.iconView.layer.masksToBounds = YES;
    
    self.iconView.layer.borderWidth = 1;
    
    self.iconView.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
    
    [_topView addSubview:self.iconView];
    
    self.sexImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.iconView.right-Width320(21), self.iconView.bottom-Height320(16), Width320(14), Height320(14))];
    
    self.sexImg.userInteractionEnabled = NO;
    
    self.sexImg.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.sexImg.layer.cornerRadius = self.sexImg.width/2;
    
    self.sexImg.layer.masksToBounds = YES;
    
    self.sexImg.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
    
    self.sexImg.layer.borderWidth = 1;
    
    [_topView addSubview:self.sexImg];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, self.iconView.bottom+Height320(9.5), MSW-80, Height320(17.5))];
    
    self.nameLabel.textColor = UIColorFromRGB(0x222222);
    
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    
    self.nameLabel.font = STFont(17);
    
    [_topView addSubview:self.nameLabel];
    
    self.introLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12.5), self.nameLabel.bottom+Height320(8), MSW-Width320(25), Height320(32))];
    
    self.introLabel.textAlignment = NSTextAlignmentCenter;
    
    self.introLabel.textColor = UIColorFromRGB(0x666666);
    
    self.introLabel.font = STFont(13);
    
    [_topView addSubview:self.introLabel];
    
    UIImageView *cityImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(140.5), _introLabel.bottom+Height320(10), Width320(8), Height320(11.5))];
    
    cityImg.image = [UIImage imageNamed:@"graylocation"];
    
    [_topView addSubview:cityImg];
    
    self.cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(cityImg.right+Width320(5.5), cityImg.top, Width320(100), Height320(13))];
    
    self.cityLabel.textColor = UIColorFromRGB(0x666666);
    
    self.cityLabel.font = STFont(13);
    
    [_topView addSubview:self.cityLabel];
    
    self.secView = [[UIView alloc]initWithFrame:CGRectMake(0, sawView.bottom+Height320(9.7), MSW, Height320(400))];
    
    self.secView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [_topView addSubview:self.secView];
    
    UILabel *coachLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(39), Height320(13), Width320(53), Height320(16))];
    
    coachLabel.text = @"教练评分";
    
    coachLabel.textColor = UIColorFromRGB(0x666666);
    
    coachLabel.font = STFont(13);
    
    coachLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.secView addSubview:coachLabel];
    
    UILabel *courseLabel = [[UILabel alloc]initWithFrame:CGRectMake(coachLabel.right+Width320(41), coachLabel.top, coachLabel.width, coachLabel.height)];
    
    courseLabel.text = @"课程评分";
    
    courseLabel.textColor = UIColorFromRGB(0x666666);
    
    courseLabel.font = STFont(13);
    
    courseLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.secView addSubview:courseLabel];
    
    self.coachPrice = [[UILabel alloc]initWithFrame:CGRectMake(coachLabel.left, coachLabel.bottom+Height320(1.5), coachLabel.width, Height320(26))];
    
    self.coachPrice.textColor = UIColorFromRGB(0xEDA640);
    
    self.coachPrice.textAlignment = NSTextAlignmentCenter;
    
    self.coachPrice.font = STFont(21);
    
    [self.secView addSubview:self.coachPrice];
    
    self.coursePrice = [[UILabel alloc]initWithFrame:CGRectMake(courseLabel.left, self.coachPrice.top, self.coachPrice.width, self.coachPrice.height)];
    
    self.coursePrice.textColor = UIColorFromRGB(0xEDA640);
    
    self.coursePrice.textAlignment = NSTextAlignmentCenter;
    
    self.coursePrice.font = STFont(21);
    
    [self.secView addSubview:self.coursePrice];
    
    self.hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(20), MSH-Height320(44), MSW-Width320(40), Height320(19))];
    
    self.hintLabel.text = @"----------向上拖动查看详情----------";
    
    self.hintLabel.textColor = UIColorFromRGB(0x999999);
    
    self.hintLabel.textAlignment = NSTextAlignmentCenter;
    
    self.hintLabel.font = STFont(13);
    
    [_topView addSubview:self.hintLabel];
    
    self.coachStar = [[MOStarRateView alloc]initWithFrame:CGRectMake(coachLabel.left, self.coachPrice.bottom+Height320(5.7), coachLabel.width, Height320(10.7))];
    
    [self.secView addSubview:self.coachStar];
    
    self.courseStar = [[MOStarRateView alloc]initWithFrame:CGRectMake(courseLabel.left, self.coachStar.top, self.coachStar.width, self.coachStar.height)];
    
    [self.secView addSubview:self.courseStar];
    
    UIView *vSep = [[UIView alloc]initWithFrame:CGRectMake(courseLabel.right+Width320(21.3), Height320(14.6), 1, Height320(59.5))];
    
    vSep.backgroundColor = UIColorFromRGB(0xeeeeee);
    
    [self.secView addSubview:vSep];
    
    self.totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(vSep.right, 0, self.secView.width-vSep.right, self.coachStar.bottom+Height320(14.6))];
    
    self.totalLabel.textColor = UIColorFromRGB(0x666666);
    
    self.totalLabel.numberOfLines = 2;
    
    self.totalLabel.textAlignment = NSTextAlignmentCenter;
    
    self.totalLabel.font =STFont(13);
    
    [self.totalLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(totalTap:)]];
    
    [self.secView addSubview:self.totalLabel];
    
    self.totalLabel.userInteractionEnabled = YES;
    
    UIView *hSep = [[UIView alloc]initWithFrame:CGRectMake(0, self.coachStar.bottom+Height320(14.6), MSW, 1)];
    
    hSep.backgroundColor = vSep.backgroundColor;
    
    [self.secView addSubview:hSep];
    
    self.goodAtLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(21.3), hSep.bottom+Height320(10), MSW-Width320(42.6), Height320(16))];
    
    self.goodAtLabel.textColor = UIColorFromRGB(0x999999);
    
    self.goodAtLabel.font = STFont(14);
    
    [self.secView addSubview:self.goodAtLabel];
    
    self.coachTagView = [[MOLableView alloc]initWithFrame:CGRectMake(Width320(21.3), self.goodAtLabel.bottom+Height320(10), MSW-Width320(21.3), Height320(500))];
    
    self.coachTagView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.coachTagView.key1 = @"name";
    
    self.coachTagView.key2 = @"count";
    
    self.coachTagView.haveArrow = YES;
    
    [self.secView addSubview:self.coachTagView];
    
    self.bottomView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _topView.bottom, MSW, MSH)];
    
    self.bottomView.contentSize = CGSizeMake(0, 0);
    
    self.bottomView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(endRefresh)];
    
    [self.mainView addSubview:self.bottomView];
    
    self.chooseView = [[ChooseView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.chooseView.backgroundColor = [UIColor whiteColor];
    
    self.chooseView.rowWidth = Width320(60);
    
    self.chooseView.rowGap = Width320(20.5);
    
    self.chooseView.rowHeight = Height320(38);
    
    self.chooseView.datasource = self;
        
    [self.bottomView addSubview:self.chooseView];
    
    self.shareView = [[UIView alloc]initWithFrame:CGRectMake(MSW/2-Width320(67), Height320(230), Width320(134), Height320(93))];
    
    self.shareView.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.45];
    
    self.shareView.layer.cornerRadius = 2;
    
    self.shareView.layer.masksToBounds = YES;
    
    [self.view addSubview:self.shareView];
    
    self.shareView.hidden = YES;
    
    UIImageView *shareImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, Height320(17), Width320(28), Height320(28))];
    
    shareImg.image = [UIImage imageNamed:@"share_success"];
    
    shareImg.center = CGPointMake(self.shareView.width/2, shareImg.center.y);
    
    [self.shareView addSubview:shareImg];
    
    UILabel *shareLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, shareImg.bottom+Height320(13.8), self.shareView.width-20, Height320(17))];
    
    shareLabel.textColor = UIColorFromRGB(0xffffff);
    
    shareLabel.text = @"分享成功";
    
    shareLabel.textAlignment = NSTextAlignmentCenter;
    
    shareLabel.font = STFont(13);
    
    [self.shareView addSubview:shareLabel];
    
}

-(void)endRefresh
{
    
    [self.bottomView.mj_header endRefreshing];
    
    [self showTop];
    
}

-(void)totalTap:(UITapGestureRecognizer*)tap
{
    
    [self.chooseView selectNum:4];
    
    [UIView animateWithDuration:0.5f animations:^{
        
        [self.topView changeTop:-MSH];
        
        [self.bottomView changeTop:0];
        
        self.navigationBarColor = kMainColor;

    }];
    
    
}

-(void)chooseViewEndRefresh
{
    
    [self showTop];
    
}

-(void)naviRightClick
{

    ShareActionSheet *actionSheet = [[ShareActionSheet alloc]init];
    
    actionSheet.delegate = self;
    
    actionSheet.title = [NSString stringWithFormat:@"%@教练的主页",CoachName];
    
    actionSheet.content = [NSString stringWithFormat:@"查看%@的课程及更多信息",CoachName];
    
    actionSheet.imgURL = [NSString stringWithFormat:@"%@!small",CoachIcon];
    
    actionSheet.url = [NSString stringWithFormat:@"%@/fitness/redirect/gym/welcome/",ROOT];
    
    [actionSheet show];
    
}

-(void)shareResult:(NSInteger)result
{
    
    if (result == WXSuccess) {
        
        self.shareView.hidden = NO;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.shareView.hidden = YES;
            
        });
        
    }
    
}

-(NSInteger)numberOfRowInChooseView
{
    
    return self.chooseTitleArray.count;
    
}

-(UIScrollView *)viewForRow:(NSInteger)row
{
    
    if (row == 0) {
    
        self.infoView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-Height320(87))];

        self.infoView.backgroundColor = UIColorFromRGB(0xffffff);
        
        self.infoView.delegate = self;
        
        [self.infoView removeAllView];
        
        self.infoView.showsVerticalScrollIndicator = NO;
        
        UIImageView *phoneImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(19), Height320(19), Width320(14), Height320(14))];
        
        phoneImg.image = [UIImage imageNamed:@"phoneinfo"];
        
        [self.infoView addSubview:phoneImg];
        
        UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(phoneImg.right+Width320(16), phoneImg.top, Width320(250), phoneImg.height)];
        
        phoneLabel.textColor = UIColorFromRGB(0x999999);
        
        phoneLabel.font = STFont(14);
        
        NSMutableAttributedString *phonestr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"手机   %@",self.user.phone.length?self.user.phone:@"尚未填写"]];
        
        [phonestr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x222222) range:NSMakeRange(5, phonestr.length-5)];
        
        phoneLabel.attributedText = phonestr;
        
        [self.infoView addSubview:phoneLabel];
        
        UIImageView *cityImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(19), phoneImg.bottom+Height320(16.5), Width320(14), Height320(14))];
        
        cityImg.image = [UIImage imageNamed:@"cityinfo"];
        
        [self.infoView addSubview:cityImg];
        
        UILabel *cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(cityImg.right+Width320(16), cityImg.top, Width320(250), cityImg.height)];
        
        cityLabel.textColor = UIColorFromRGB(0x999999);
        
        cityLabel.font = STFont(14);
        
        NSMutableAttributedString *citystr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"城市   %@",self.user.city.length?self.user.city:@"尚未填写"]];
        
        [citystr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x222222) range:NSMakeRange(5, citystr.length-5)];
        
        cityLabel.attributedText = citystr;
        
        [self.infoView addSubview:cityLabel];
        
        UIImageView *wechatImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(19), cityImg.bottom+Height320(16.5), Width320(14), Height320(14))];
        
        wechatImg.image = [UIImage imageNamed:@"wechatinfo"];
        
        [self.infoView addSubview:wechatImg];
        
        UILabel *wechatLabel = [[UILabel alloc]initWithFrame:CGRectMake(wechatImg.right+Width320(16), wechatImg.top, Width320(250), wechatImg.height)];
        
        wechatLabel.textColor = UIColorFromRGB(0x999999);
        
        wechatLabel.font = STFont(14);
        
        NSMutableAttributedString *wechatstr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"微信   %@",self.user.wechat.length?self.user.wechat:@"尚未填写"]];
        
        [wechatstr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x222222) range:NSMakeRange(5, wechatstr.length-5)];
        
        wechatLabel.attributedText = wechatstr;
        
        [self.infoView addSubview:wechatLabel];
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(0, wechatImg.bottom+Height320(16), MSW, 1)];
        
        sep.backgroundColor = UIColorFromRGB(0xeeeeee);
        
        [self.infoView addSubview:sep];

        self.myIntroView = [[IntroView alloc]initWithFrame:CGRectMake(0, sep.bottom+Height320(6.5), MSW, 2000)];
        
        self.myIntroView.delegate = self;
        
        self.myIntroView.dataArray = self.user.intro;
        
        [self.infoView addSubview:self.myIntroView];
        
        return self.infoView;
        
    }else if (row == 1)
    {
        
        self.qualityView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-Height320(87)) style:UITableViewStylePlain];
        
        self.qualityView.tag = 101;
        
        self.qualityView.dataSource = self;
        
        self.qualityView.delegate = self;
        
        self.qualityView.emptyDataSetSource = self;
        
        self.qualityView.separatorColor = UIColorFromRGB(0xeeeeee);
        
        self.qualityView.tableFooterView = [UIView new];
        
        [self.qualityView registerClass:[QualityCell class] forCellReuseIdentifier:qIdentifier];
        
        self.qualityView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        return self.qualityView;
        
    }else if (row == 2)
    {
        
        self.workView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-Height320(87)) style:UITableViewStylePlain];

        self.workView.tag = 102;
        
        self.workView.dataSource = self;
        
        self.workView.delegate = self;
        
        self.workView.emptyDataSetSource = self;
                
        self.workView.tableFooterView = [UIView new];
        
        self.workView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        [self.workView registerClass:[WorkCell class] forCellReuseIdentifier:wIdentifier];
        
        self.workView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        return self.workView;
        
    }else
    {
        
        UIScrollView *remarkView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-Height320(87))];
    
        self.stuRemarkView = [[MOLableView alloc]initWithFrame:CGRectMake(Width320(18.7), Height320(14.2), MSW-Width320(37.4), Height320(500))];
                
        self.stuRemarkView.key1 = @"comment";
        
        self.stuRemarkView.key2 = @"count";
        
        self.stuRemarkView.highLight = YES;
        
        self.stuRemarkView.haveArrow = NO;
        
        self.stuRemarkView.labelGap = 0 ;
        
        self.stuRemarkView.highNum = 5;
        
        [remarkView addSubview:self.stuRemarkView];
        
        self.stuRemarkView.dataArray = self.coachRemarkInfo.tags;
        
         UIView *remarkEmptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, remarkView.width, remarkView.height)];
        
        remarkEmptyView.backgroundColor = UIColorFromRGB(0xffffff);
        
        UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW/3, Height320(75.5), MSW/3, MSW/3)];
        
        emptyImg.image = [UIImage imageNamed:@"remarkempty"];
        
        [remarkEmptyView addSubview:emptyImg];
        
        UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, emptyImg.bottom+Height320(19.5), MSW-100, Height320(39))];
        
        emptyLabel.text = @"还没有学员评价过您哦";
        
        emptyLabel.numberOfLines = 2;
        
        emptyLabel.textColor = UIColorFromRGB(0x747474);
        
        emptyLabel.font = STFont(14);
        
        emptyLabel.textAlignment = NSTextAlignmentCenter;
        
        [remarkEmptyView addSubview:emptyLabel];
        
        [remarkView addSubview:remarkEmptyView];
        
        remarkEmptyView.hidden = !self.coachEmpty;
        
        return remarkView;
        
    }
    
    
}

-(void)introViewFinishLoad
{
    
    [self.infoView setContentSize:CGSizeMake(0, self.myIntroView.bottom)];
    
}

-(UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    
    UIScrollView *view = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-Height320(87))];
    
    view.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        
        [view.mj_header endRefreshing];
        
        [self showTop];
        
    }];
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW/3, Height320(75.5), MSW/3, MSW/3)];
    
    emptyImg.image = [UIImage imageNamed:scrollView.tag==101?@"qualityempty":@"workempty"];
    
    [view addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, emptyImg.bottom+Height320(19.5), MSW-100, Height320(39))];
    
    emptyLabel.text = scrollView.tag==101?@"您还没有添加任何资质认证\n请在设置页面中添加":@"您还没有添加任何工作经历\n请在设置页面中添加";
    
    emptyLabel.numberOfLines = 2;
    
    emptyLabel.textColor = UIColorFromRGB(0x747474);
    
    emptyLabel.font = STFont(14);
    
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:emptyLabel];

    return view;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView.tag == 101) {
        
        return self.qualitiesInfo.qualities.count;
        
    }else
    {
        
        return self.worksInfo.works.count;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 101) {
        
        return Height320(124);
        
    }else
    {
        
        WorkCell *cell = (WorkCell*)[self tableView:self.workView cellForRowAtIndexPath:indexPath];
        
        return cell.cellHeight;
        
    }
    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 101) {
        
        QualityCell *cell = [tableView dequeueReusableCellWithIdentifier:qIdentifier];
        
        Quality *quality = self.qualitiesInfo.qualities[indexPath.row];
        
        cell.title = quality.title;
        
        cell.ogn = quality.organization.name;
        
        cell.time = quality.issueTime;
        
        cell.imgUrl = quality.photo;
        
        cell.isVerified = quality.isVerified;
        
        cell.validTime = !quality.willExpired?@"长期有效":[quality.endTime isEqualToString:@"3000-01-01"]?@"长期有效":quality.startTime.length &&quality.endTime.length?[NSString stringWithFormat:@"有效期：%@至%@",quality.startTime,quality.endTime]:@"长期有效";
        
        cell.tag = indexPath.row;
        
        cell.delegate = self;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else
    {
        
        WorkCell *cell = [tableView dequeueReusableCellWithIdentifier:wIdentifier];
        
        Work *work = self.worksInfo.works[indexPath.row];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        cell.isShowing = [self.workMoreArray containsObject:[NSNumber numberWithInteger:indexPath.row]];
        
//        cell.delegate = self;
        
        cell.work = work;
        
        return cell;
        
    }
    
}

-(NSString*)titleForButtonAtRow:(NSInteger)row
{
    
    return self.chooseTitleArray[row];
    
}

-(void)workMore:(UIButton*)btn
{
    
    [self.workMoreArray addObject:[NSNumber numberWithInteger:btn.tag]];
    
}

-(void)workLess:(UIButton *)btn
{
    
    [self.workMoreArray removeObject:[NSNumber numberWithInteger:btn.tag]];
    
}

-(void)showTop
{
    
    [UIView animateWithDuration:0.5f animations:^{
        
        [self.topView changeTop:0];
        
        [self.bottomView changeTop:MSH];
        
        self.navigationBarColor = [UIColor clearColor];

    }];
    
}

-(void)cellClickImg:(QualityCell *)cell
{
    
    Quality *quality = self.qualitiesInfo.qualities[cell.tag];
    
    if (quality.photo.absoluteString.length) {
        
        PictureShowController *svc = [[PictureShowController alloc]init];
        
        svc.imageURL = quality.photo;
        
        [self presentViewController:svc animated:YES completion:nil];
        
    }
    
}

@end
