//
//  MOViewController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/1/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "GuideBrandSetController.h"

#define NaviColor kMainColor

#define NaviTitleColor UIColorFromRGB(0xffffff)

#define NaviFont [UIFont boldSystemFontOfSize:IPhone4_5_6_6P(16, 16, 17, 18)]

typedef enum : NSUInteger {
    TitleButtonTypeDown,
    TitleButtonTypePull,
} TitleButtonType;

@interface TitleButton : UIButton

{
    
    UILabel *_titleLabel;
    
    UIImageView *_arrowImg;
    
    UIImageView *_pullImg;
    
    BOOL _isTransformed;
    
}

@property(nonatomic,copy)NSString *title;

@property(nonatomic,assign)CGFloat maxTitleRight;

@property(nonatomic,strong)UIColor *titleColor;

@property(nonatomic,assign)TitleButtonType type;

@end

@implementation TitleButton

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, frame.size.height)];
        
        _titleLabel.font = NaviFont;
        
        _titleLabel.textColor = NaviTitleColor;
        
        _titleLabel.userInteractionEnabled = NO;
        
        [self addSubview:_titleLabel];
        
        _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(_titleLabel.right+8, frame.size.height/2-3, 10.6, 6)];
        
        _arrowImg.image = [UIImage imageNamed:@"white_down_arrow"];
        
        [self addSubview:_arrowImg];
        
        _pullImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.width/2-3, self.height-11, 6, 4)];
        
        _pullImg.image = [UIImage imageNamed:@"navi_pull_image"];
        
        [self addSubview:_pullImg];
        
        _pullImg.hidden = YES;
        
    }
    
    return self;
    
}

-(void)setTitleColor:(UIColor *)titleColor
{
    
    _titleColor = titleColor;
    
    _titleLabel.textColor = _titleColor;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
    [_titleLabel autoWidth];
    
    if (self.maxTitleRight) {
        
        if (_titleLabel.right+28.6>self.maxTitleRight) {
            
            [_titleLabel changeWidth:self.maxTitleRight-_titleLabel.left-28.6];
            
        }
        
    }else
    {
        
        if (_titleLabel.width>MSW-100) {
            
            [_titleLabel changeWidth:MSW-100];
            
        }
        
    }
    
    _titleLabel.center = CGPointMake(self.width/2, _titleLabel.center.y);
    
    [_arrowImg changeLeft:_titleLabel.right+8];
    
}

-(void)setType:(TitleButtonType)type
{
    
    _type = type;
    
    _arrowImg.hidden = _type == TitleButtonTypePull;
    
    _pullImg.hidden = _type == TitleButtonTypeDown;
    
}

-(void)didClick
{
    
    _pullImg.transform = CGAffineTransformMakeRotation(_isTransformed?0:M_PI);
    
    _isTransformed = !_isTransformed;
    
}

@end

@interface NumView : UIView

{
    
    UILabel *_numLabel;
    
}

@property(nonatomic,assign)NSInteger num;

@end

@implementation NumView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        
        self.layer.cornerRadius = frame.size.width/2;
        
        self.layer.masksToBounds = YES;
        
        self.hidden = YES;
        
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, frame.size.width-4, frame.size.height-4)];
        
        _numLabel.backgroundColor = UIColorFromRGB(0xea6161);
        
        _numLabel.textColor = UIColorFromRGB(0xffffff);
        
        _numLabel.textAlignment = NSTextAlignmentCenter;
        
        _numLabel.font = STFont(12);
        
        _numLabel.adjustsFontSizeToFitWidth = YES;
        
        _numLabel.layer.cornerRadius = _numLabel.width/2;
        
        _numLabel.layer.masksToBounds = YES;
        
        _numLabel.layer.borderWidth = 1;
        
        _numLabel.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
        
        [self addSubview:_numLabel];
        
    }
    
    return self;
    
}

-(void)setNum:(NSInteger)num
{
    
    _num = num;
    
    if (_num &&_num<100) {
        
        self.hidden = NO;
        
        _numLabel.text = [NSString stringWithFormat:@"%ld",(long)_num];
        
    }else if (_num &&_num>=100) {
        
        self.hidden = NO;
        
        _numLabel.text = @"99";
        
    }else
    {
        
        self.hidden = YES;
        
    }
    
}


@end

@interface NaviButton : UIButton

{
    
    UIImageView *_imgView;
    
    UILabel *_label;
    
    UIView *_chooseView;
    
    UIImageView *_chooseImgView;
    
}

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,assign)BOOL isChooseType;

@property(nonatomic,assign)BOOL choosed;

@property(nonatomic,assign)BOOL isRight;

@end

@implementation NaviButton

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width*0.4, frame.size.height*0.4)];
        
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        _imgView.userInteractionEnabled = NO;
        
        [self addSubview:_imgView];
        
        _imgView.center = CGPointMake(self.width/2, self.height/2);
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, self.width-15, self.height)];
        
        _label.textAlignment = NSTextAlignmentRight;
        
        _label.textColor = UIColorFromRGB(0xffffff);
        
        _label.font = STFont(14);
        
        _label.userInteractionEnabled = NO;
        
        [self addSubview:_label];
        
    }
    
    return self;
    
}

-(void)setIsRight:(BOOL)isRight
{
    
    _isRight = isRight;
    
    [_label changeLeft:_isRight?0:15];
    
    _label.textAlignment = _isRight?NSTextAlignmentRight:NSTextAlignmentLeft;
    
}

-(void)setIsChooseType:(BOOL)isChooseType
{
    
    _isChooseType = isChooseType;
    
    if (_isChooseType) {
        
        if (!_chooseView) {
            
            _chooseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 73, 44)];
            
            _chooseView.userInteractionEnabled = NO;
            
            _chooseImgView = [[UIImageView alloc]initWithFrame:CGRectMake(16, self.height/2-7, 14, 14)];
            
            _chooseImgView.layer.cornerRadius = _chooseImgView.width/2;
            
            _chooseImgView.layer.masksToBounds = YES;
            
            _chooseImgView.image = nil;
            
            _chooseImgView.layer.borderWidth = OnePX;
            
            _chooseImgView.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
            
            [_chooseView addSubview:_chooseImgView];
            
            UILabel *chooseLabel = [[UILabel alloc]initWithFrame:CGRectMake(_chooseImgView.right+3, 0, 37, self.height)];
            
            chooseLabel.text = @"全选";
            
            chooseLabel.textColor = UIColorFromRGB(0xffffff);
            
            chooseLabel.font = STFont(14);
            
            chooseLabel.textAlignment = NSTextAlignmentCenter;
            
            [_chooseView addSubview:chooseLabel];
            
        }
        
        [self addSubview:_chooseView];
        
    }else{
        
        if (_chooseView) {
            
            [_chooseView removeFromSuperview];
            
        }
        
    }
    
}

-(void)setChoosed:(BOOL)choosed
{
    
    _choosed = choosed;
    
    _chooseImgView.image = _choosed?[UIImage imageNamed:@"selected"]:nil;
    
    _chooseImgView.layer.borderWidth = _choosed?0:OnePX;
    
}

-(void)changeWidth:(CGFloat)width
{
    
    [super changeWidth:width];
    
    [_label changeWidth:width];
    
}

-(void)setImage:(UIImage *)image
{
    
    _image = image;
    
    _imgView.image = _image;
    
    _label.hidden = YES;
    
    _imgView.hidden = NO;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    if (_title.length) {
        
        _label.text = _title;
        
        [_label autoWidth];
        
        if (_isRight) {
            
            [_label changeLeft:self.width-_label.width];
            
        }
        
        _label.hidden = NO;
        
        _imgView.hidden = YES;
        
    }else
    {
        
        _label.hidden = YES;
        
        _imgView.hidden = YES;
        
    }
    
}

-(void)setTitleColor:(UIColor *)color forState:(UIControlState)state
{
    
    [super setTitleColor:color forState:state];
    
    _label.textColor = color;
    
}

@end

@interface MONaviView ()

{
    
    UILabel *_titleLabel;
    
    TitleButton *_titleButton;
    
    NumView *_numView;
    
    NaviButton *_rightSubButton;
    
    UIView *_line;
    
}

@property(nonatomic,strong)NaviButton *rightButton;

@property(nonatomic,strong)NaviButton *leftButton;

@property(nonatomic,assign)BOOL shadowHidden;

@property(nonatomic,strong)UIImage *leftImg;

@property(nonatomic,strong)UIImage *rightImg;

@property(nonatomic,strong)UIColor *titleColor;

@property(nonatomic,strong)UIColor *rightColor;

@property(nonatomic,strong)UIColor *leftColor;

@end

@implementation MONaviView


-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = NaviColor;
        
        if (AppDebug) {
            
            UIView *naviTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, 20)];
            
            naviTop.backgroundColor = UIColorFromRGB(0x000000);
            
            [self addSubview:naviTop];
            
        }
        
        _line = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
        
        _line.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self addSubview:_line];
        
        _numView = [[NumView alloc]initWithFrame:CGRectMake(MSW-25, 28, 22, 22)];
        
        [_numView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(numClick)]];
        
        [self addSubview:_numView];
        
        _leftButton = [[NaviButton alloc]initWithFrame:CGRectMake(0, 20, 48, 44)];
        
        [self addSubview:_leftButton];
        
        _rightButton = [[NaviButton alloc]initWithFrame:CGRectMake(MSW-48, 20, 48, 44)];
        
        _rightButton.isRight = YES;
        
        [_rightButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
        [self addSubview:_rightButton];
        
        _rightSubButton = [[NaviButton alloc]initWithFrame:CGRectMake(MSW-101, 20, 48, 44)];
        
        _rightSubButton.hidden = YES;
        
        _titleButton = [[TitleButton alloc]initWithFrame:CGRectMake(_leftButton.right+10, 20, MSW-_leftButton.width*2-20, 44)];
        
        [_titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_titleButton];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_leftButton.right+10, 20, MSW-_leftButton.width*2-20, 44)];
        
        _titleLabel.textColor = NaviTitleColor;
        
        _titleLabel.font = NaviFont;
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_titleLabel];
        
        self.titleType = MONaviTitleTypeLabel;
        
        [self bringSubviewToFront:_rightButton];
        
        [self bringSubviewToFront:_leftButton];
        
    }
    
    return self;
    
}

-(void)numClick
{
    
    if (_rightType == MONaviRightTypeRing) {
        
        [self rightClick:_rightButton];
        
    }else if (_rightSubType == MONaviRightSubTypeRing){
        
        [self rightSubClick:_rightSubButton];
        
    }
    
}

-(void)setTitleColor:(UIColor *)titleColor
{
    
    _titleColor = titleColor;
    
    _titleLabel.textColor = _titleColor;
    
    _titleButton.titleColor = _titleColor;
    
}

-(void)setMsgNum:(NSInteger)msgNum
{
    
    _msgNum = msgNum;
    
    _numView.num = _msgNum;
    
    if (_msgNum) {
        
        _numView.hidden = NO;
        
        [self bringSubviewToFront:_numView];
        
    }else{
        
        _numView.hidden = YES;
        
        [self sendSubviewToBack:_numView];
        
    }
    
}

-(void)setTitleType:(MONaviTitleType)titleType
{
    
    _titleType = titleType;
    
    if (_titleType == MONaviTitleTypeLabel) {
        
        _titleButton.hidden = YES;
        
        _titleLabel.hidden = NO;
        
    }else
    {
        
        _titleButton.hidden = NO;
        
        _titleLabel.hidden = YES;
        
        _titleButton.type = _titleType == MONaviTitleTypeButton?TitleButtonTypeDown:TitleButtonTypePull;
        
    }
    
}

-(void)setShadowHidden:(BOOL)shadowHidden
{
    
    _shadowHidden = shadowHidden;
    
    _line.hidden = shadowHidden;
    
}

-(void)setMaxTitleRight:(CGFloat)maxTitleRight
{
    
    _maxTitleRight = maxTitleRight;
    
    _titleButton.maxTitleRight = _maxTitleRight;
    
}

-(void)setLeftImg:(UIImage *)leftImg
{
    
    _leftImg = leftImg;
    
    _leftButton.image = _leftImg;
    
    [_leftButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)setRightImg:(UIImage *)rightImg
{
    
    _rightImg = rightImg;
    
    _rightButton.image = _rightImg;
    
    [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)setLeftType:(MONaviLeftType)leftType
{
    
    _leftType = leftType;
    
    switch (_leftType) {
            
        case MONaviLeftTypeBlackClose:
            
            _leftButton.isChooseType = NO;
            
            _leftButton.image = [UIImage imageNamed:@"navi_black_close"];
            
            [_leftButton changeWidth:48];
            
            [_leftButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        case MONaviLeftTypeBack:
            
            _leftButton.isChooseType = NO;
            
            _leftButton.image = [UIImage imageNamed:@"navi_back"];
            
            [_rightButton changeWidth:48];
            
            [_leftButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        case MONaviLeftTypePage:
            
            _leftButton.isChooseType = NO;
            
            _leftButton.image = [UIImage imageNamed:@"navi_page"];
            
            [_rightButton changeWidth:48];
            
            [_leftButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        case MONaviLeftTypeClose:
            
            _leftButton.isChooseType = NO;
            
            _leftButton.image = [UIImage imageNamed:@"navi_close"];
            
            [_rightButton changeWidth:48];
            
            [_leftButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        case MONaviLeftTypeTitle:
            
            _leftButton.isChooseType = NO;
            
            [_leftButton setImage:nil];
            
            [_leftButton changeWidth:70];
            
            [_leftButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        case MONaviLeftTypeNO:
            
            _leftButton.isChooseType = NO;
            
            _leftButton.image = nil;
            
            [_leftButton removeTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
            break;
        case MONaviLeftTypeAllChoose:
            
            _leftButton.image = nil;
            
            _leftButton.isChooseType = YES;
            
            [_leftButton changeWidth:73];
            
            [_leftButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        default:
            break;
    }
    
}

-(void)setRightSubType:(MONaviRightSubType)rightSubType
{
    
    _rightSubType = rightSubType;
    
    if (_rightType != MONaviRightTypeRing) {
        
        _numView.hidden = YES;
        
    }
    
    switch (_rightSubType) {
            
        case MONaviRightSubTypeSearch:
            
            _maxTitleRight = _rightSubButton.left;
            
            [_rightSubButton setImage:[UIImage imageNamed:@"navi_search"]];
            
            [_rightSubButton addTarget:self action:@selector(rightSubClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:_rightSubButton];
            
            [self bringSubviewToFront:_rightSubButton];
            
            _rightSubButton.hidden = NO;
            
            break;
        
        case MONaviRightSubTypeNO:
            
            _maxTitleRight = _rightButton.left;
            
            [_rightSubButton setImage:nil];
            
            [_rightSubButton removeTarget:self action:@selector(rightSubClick:) forControlEvents:UIControlEventTouchUpInside];
            
            _rightSubButton.hidden = YES;
            
            [_rightSubButton removeFromSuperview];
            
            break;
    
        case MONaviRightSubTypeShare:
            
            _maxTitleRight = _rightSubButton.left;
            
            [_rightSubButton setImage:[UIImage imageNamed:@"navi_share"]];
            
            [_rightSubButton addTarget:self action:@selector(rightSubClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:_rightSubButton];
            
            [self bringSubviewToFront:_rightSubButton];
            
            _rightSubButton.hidden = NO;
            
            break;
        
        case MONaviRightSubTypeRing:
            
            _numView.hidden = NO;
            
            [_numView changeLeft:MSW-78];
            
            _maxTitleRight = _rightSubButton.left;
            
            [_rightSubButton setImage:[UIImage imageNamed:@"navi_ring"]];
            
            [_rightSubButton addTarget:self action:@selector(rightSubClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:_rightSubButton];
            
            [self bringSubviewToFront:_rightSubButton];
            
            _rightSubButton.hidden = NO;
            
            break;
            
        case MONaviRightSubTypeEdit:
            
            _maxTitleRight = _rightSubButton.left;
            
            [_rightSubButton setImage:[UIImage imageNamed:@"navi_edit"]];
            
            [_rightSubButton addTarget:self action:@selector(rightSubClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:_rightSubButton];
            
            [self bringSubviewToFront:_rightSubButton];
            
            _rightSubButton.hidden = NO;
            
            break;
            
        default:
            break;
    }
    
}

-(void)setRightType:(MONaviRightType)rightType
{
    
    _rightType = rightType;
    
    switch (_rightType) {
            
        case MONaviRightTypeAdd:
            
            [_rightButton setImage:[UIImage imageNamed:@"navi_add"]];
            
            [_rightButton changeLeft:MSW-48];
            
            [_rightButton changeWidth:48];
            
            [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        case MONaviRightTypeEdit:
            
            [_rightButton setImage:[UIImage imageNamed:@"navi_edit"]];
            
            [_rightButton changeLeft:MSW-48];
            
            [_rightButton changeWidth:48];
            
            [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        case MONaviRightTypeRing:
            
            [_numView changeLeft:MSW-25];
            
            [_rightButton setImage:[UIImage imageNamed:@"navi_ring"]];
            
            [_rightButton changeLeft:MSW-48];
            
            [_rightButton changeWidth:48];
            
            [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        case MONaviRightTypeEditDisable:
            
            [_rightButton setImage:[UIImage imageNamed:@"navi_edit_disabled"]];
            
            [_rightButton changeLeft:MSW-48];
            
            [_rightButton changeWidth:48];
            
            [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        case MONaviRightTypeTrash:
            
            [_rightButton setImage:[UIImage imageNamed:@"navi_trash"]];
            
            [_rightButton changeLeft:MSW-48];
            
            [_rightButton changeWidth:48];
            
            [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
        case MONaviRightTypeShare:
            
            [_rightButton setImage:[UIImage imageNamed:@"navi_share"]];
            
            [_rightButton changeLeft:MSW-48];
            
            [_rightButton changeWidth:48];
            
            [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
        case MONaviRightTypeCheck:
            
            [_rightButton setImage:[UIImage imageNamed:@"navi_check"]];
            
            [_rightButton changeLeft:MSW-48];
            
            [_rightButton changeWidth:48];
            
            [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
        case MONaviRightTypeMore:
            
            [_rightButton setImage:[UIImage imageNamed:@"navi_more"]];
            
            [_rightButton changeLeft:MSW-48];
            
            [_rightButton changeWidth:48];
            
            [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        case MONaviRightTypeTitle:
            
            [_rightButton setImage:nil];
            
            [_rightButton changeLeft:MSW-101];
            
            [_rightButton changeWidth:81];
            
            [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        case MONaviRightTypeSearch:
            
            [_rightButton setImage:[UIImage imageNamed:@"navi_search"]];
            
            [_rightButton changeLeft:MSW-48];
            
            [_rightButton changeWidth:48];
            
            [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        case MONaviRightTypeNO:
            
            [_rightButton setImage:nil];
            
            [_rightButton setTitle:@""];
            
            [_rightButton removeTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        case MONaviRightTypeSetting:
            
            [_rightButton setImage:[UIImage imageNamed:@"navi_setting"]];
            
            [_rightButton changeLeft:MSW-48];
            
            [_rightButton changeWidth:48];
            
            [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        default:
            break;
    }
    
}

-(void)setRightColor:(UIColor *)rightColor
{
    
    _rightColor = rightColor;
    
    [_rightButton setTitleColor:rightColor forState:UIControlStateNormal];
    
}

-(void)setLeftColor:(UIColor *)leftColor
{
    
    _leftColor = leftColor;
    
    [_leftButton setTitleColor:leftColor forState:UIControlStateNormal];
    
}

-(void)setRightTitle:(NSString *)rightTitle
{
    
    _rightTitle = rightTitle;
    
    if (_rightTitle.length&&_rightType != MONaviRightTypeTitle) {
        
        self.rightType = MONaviRightTypeTitle;
        
    }
    
    _rightButton.title = rightTitle;
    
}

-(void)setLeftTitle:(NSString *)leftTitle
{
    
    _leftTitle = leftTitle;
    
    if (_leftTitle.length && _leftType != MONaviLeftTypeTitle) {
        
        self.leftType = MONaviLeftTypeTitle;
        
    }
    
    _leftButton.title = leftTitle;
    
}

-(void)leftClick:(NaviButton*)btn
{
    
    if ([_delegate respondsToSelector:@selector(naviLeftClick)]) {
        
        [_delegate naviLeftClick];
        
    }else
    {
        
        if ([_delegate isKindOfClass:[UIViewController class]]) {
            
            UIViewController *vc = (UIViewController*)_delegate;
            
            if ([vc.navigationController.visibleViewController isKindOfClass:[vc superclass]]) {
                
                [vc.navigationController popViewControllerAnimated:YES];
                
            }
            
        }
        
    }
    
}

-(void)rightClick:(NaviButton*)btn
{
    
    if ([_delegate respondsToSelector:@selector(naviRightClick)]) {
        
        [_delegate naviRightClick];
        
    }
    
}

-(void)rightSubClick:(NaviButton*)btn
{
    
    if ([_delegate respondsToSelector:@selector(naviRightSubClick)]) {
        
        [_delegate naviRightSubClick];
        
    }
    
}

-(void)titleClick:(UIButton*)btn
{
    
    if ([_delegate respondsToSelector:@selector(naviTitleClick)]) {
        
        [_delegate naviTitleClick];
        
    }
    
    if (_titleButton.type == TitleButtonTypePull) {
        
        [_titleButton didClick];
        
    }
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
    _titleButton.title = _title;
    
}

@end

@interface MOViewController ()<UITextFieldDelegate>

{
    
    BOOL _haveChanged;
    
    UIWindow *_window;
    
}

@end

@implementation MOViewController

-(void)reloadData
{
    
    
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _navi = [[MONaviView alloc]initWithFrame:CGRectMake(0, 0, MSW, 64)];
        
        _navi.shadowHidden = _shadowType == MONaviShadowTypeDefault;
        
        _navi.leftType = MONaviLeftTypeBack;
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    if (_navi.top != 0) {
        
        [_navi changeTop:0];
        
    }
    
    [self.view bringSubviewToFront:_navi];
    
}

-(void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self.view addSubview:_navi];
    
    _navi.delegate = self;
    
    _navi.title = self.title;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}

-(void)setTabTitle:(NSString *)tabTitle
{
    
    _tabTitle = tabTitle;
    
    [self setTitle:_tabTitle];
    
}

-(void)setRightTitle:(NSString *)rightTitle
{
    
    _rightTitle = rightTitle;
    
    _navi.rightTitle = rightTitle;
    
}

-(void)setLeftTitle:(NSString *)leftTitle
{
    
    _leftTitle = leftTitle;
    
    _navi.leftTitle = leftTitle;
    
}

-(void)setLeftColor:(UIColor *)leftColor
{
    
    _leftColor = leftColor;
    
    _navi.leftColor = leftColor;
    
}

-(void)setRightColor:(UIColor *)rightColor
{
    
    _rightColor = rightColor;
    
    _navi.rightColor = rightColor;
    
}

-(void)setLeftType:(MONaviLeftType)leftType
{
    
    _leftType = leftType;
    
    _navi.leftType = _leftType;
    
}

-(void)setRightType:(MONaviRightType)rightType
{
    
    _rightType = rightType;
    
    _navi.rightType = _rightType;
    
}

-(void)setTitle:(NSString *)title
{
    
    [super setTitle:title];
    
    _navi.title = self.title;
    
}

-(void)setTitleType:(MONaviTitleType)titleType
{
    
    _navi.titleType = titleType;
    
}

-(void)setShadowType:(MONaviShadowType)shadowType
{
    
    _shadowType = shadowType;
    
    _navi.shadowHidden = shadowType == MONaviShadowTypeDefault;
    
}

-(void)setNavigationBarHidden:(BOOL)navigationBarHidden
{
    
    _navi.hidden = navigationBarHidden;
    
}

-(void)setNavigationBarColor:(UIColor *)navigationBarColor
{
    
    _navigationBarColor = navigationBarColor;
    
    _navi.backgroundColor = navigationBarColor;
    
}

-(void)setNavigationTitleColor:(UIColor *)navigationTitleColor
{
    
    _navigationTitleColor = navigationTitleColor;
    
    _navi.titleColor = _navigationTitleColor;
    
}

-(void)setLeftImg:(UIImage *)leftImg
{
    
    _leftImg = leftImg;
    
    _navi.leftImg = _leftImg;
    
}

-(void)setRightImg:(UIImage *)rightImg
{
    
    _rightImg = rightImg;
    
    _navi.rightImg = _rightImg;
    
}

-(void)setRightNum:(NSInteger)rightNum
{
    
    _rightNum = rightNum;
    
    _navi.msgNum = _rightNum;
    
}

-(void)setRightSubType:(MONaviRightSubType)rightSubType
{
    
    _rightSubType = rightSubType;
    
    _navi.rightSubType = _rightSubType;
    
}

-(void)setRightButtonEnable:(BOOL)rightButtonEnable
{
    
    _rightButtonEnable = rightButtonEnable;
    
    _navi.rightButton.userInteractionEnabled = _rightButtonEnable;
    
}

-(void)setLeftChoosed:(BOOL)leftChoosed
{
    
    _leftChoosed = leftChoosed;
    
    _navi.leftButton.choosed = _leftChoosed;
    
}

-(void)setLeftButtonEnable:(BOOL)leftButtonEnable
{
    
    _leftButtonEnable = leftButtonEnable;
    
    _navi.leftButton.userInteractionEnabled = _leftButtonEnable;
    
}

-(void)viewWillLayoutSubviews
{
    
    [super viewWillLayoutSubviews];
    
    if (self.view.frame.size.height != MSH) {
        
        _haveChanged = YES;
        
    }else if(self.view.frame.size.height == MSH){
        
        if (_haveChanged) {
            
            for (UIView *subView in self.view.subviews) {
                
                [subView changeTop:subView.top];
                
            }
            
            _haveChanged = NO;
            
        }
        
    }
    
}

-(void)popToViewControllerName:(NSString *)vcname isReloadData:(BOOL)isReload
{
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if ([vcname isEqualToString:NSStringFromClass([vc class])]) {
            
            [self.navigationController popToViewController:vc animated:YES];
            
            if (isReload && [vc isKindOfClass:[MOViewController class]]) {
                
                [(MOViewController*)vc reloadData];
                
            }
            
            break;
            
        }
        
    }
    
}

-(void)popViewControllerAndReloadData
{
    
    if (self.navigationController) {
        
        if (self.navigationController.viewControllers.count>1) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
            if ([self.navigationController.visibleViewController isKindOfClass:[MOViewController class]]) {
                
                [((MOViewController*)self.navigationController.visibleViewController) reloadData];
                
            }
            
        }else{
            
            if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]) {
                
                [self dismissViewControllerAnimated:YES completion:^{
                    
                    if ([[MOAppDelegate getCurrentVC]isKindOfClass:[UINavigationController class]]) {
                        
                        UINavigationController *nv = ((UINavigationController*)[MOAppDelegate getCurrentVC]);
                        
                        if ([nv.visibleViewController isKindOfClass:[MOViewController class]]) {
                            
                            [((MOViewController*)nv.visibleViewController) reloadData];
                            
                        }
                        
                    }
                    
                }];
                
            }
            
        }
        
    }else{
        
        if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]) {
            
            [self dismissViewControllerAnimated:YES completion:^{
                
                if ([[MOAppDelegate getCurrentVC]isKindOfClass:[UINavigationController class]]) {
                    
                    UINavigationController *nv = ((UINavigationController*)[MOAppDelegate getCurrentVC]);
                    
                    if ([nv.visibleViewController isKindOfClass:[MOViewController class]]) {
                        
                        [((MOViewController*)nv.visibleViewController) reloadData];
                        
                    }
                    
                }
                
            }];
            
        }
        
    }
    
}

-(void)showNoPermissionAlert
{
    
    [[[UIAlertView alloc]initWithTitle:@"无该功能权限" message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil]show];
    
}

-(void)setHaveSearchBar:(BOOL)haveSearchBar
{
    
    _haveSearchBar = haveSearchBar;
    
    if (_haveSearchBar) {
        
        if (!_naviSearchBar) {
            
            _naviSearchBar = [[UITextField alloc]initWithFrame:CGRectMake(37, 25, MSW-49, 34)];
            
            _naviSearchBar.layer.cornerRadius = 2;
            
            _naviSearchBar.layer.masksToBounds = YES;
            
            _naviSearchBar.backgroundColor = UIColorFromRGB(0xffffff);
            
            _naviSearchBar.font = STFont(12);
            
            _naviSearchBar.delegate = self;
            
            _naviSearchBar.returnKeyType = UIReturnKeyDone;
            
            [_naviSearchBar addTarget:self action:@selector(naviSearchBarDidChanged:) forControlEvents:UIControlEventEditingChanged];
            
            UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 28, 34)];
            
            _naviSearchBar.leftView = leftView;
            
            _naviSearchBar.leftViewMode = UITextFieldViewModeAlways;
            
            UIImageView *searchImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
            
            searchImg.image = [UIImage imageNamed:@"student_search"];
            
            searchImg.center = CGPointMake(leftView.width/2, leftView.height/2);
            
            [leftView addSubview:searchImg];
            
            _naviSearchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
            
        }
        
        [_navi addSubview:_naviSearchBar];
        
    }else{
        
        [_navi removeFromSuperview];
        
    }
    
}

-(void)naviSearchBarDidChanged:(UITextField *)searchBar
{
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)dealloc
{
    
    for (UIView *subView in self.view.subviews) {
        
        if ([subView isKindOfClass:[UIScrollView class]]) {
            
            if (((UIScrollView *)subView).mj_header) {
                
                ((UIScrollView *)subView).mj_header = nil;
                
            }
            
        }
        
        [subView removeFromSuperview];
        
    }
    
}

-(void)showAppAlertWithTitle:(NSString *)title andSubtitle:(NSString*)subtitle
{
    
    _window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    _window.windowLevel = UIWindowLevelAlert+1;
    
    _window.backgroundColor = [UIColorFromRGB(0x000000)colorWithAlphaComponent:0.4];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(MSW/2-Width320(120), MSH/2-Height320(120), Width320(240), Height320(240))];
    
    view.backgroundColor = UIColorFromRGB(0xffffff);
    
    view.layer.cornerRadius = 1;
    
    view.layer.masksToBounds = YES;
    
    [_window addSubview:view];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(32), 0, view.width-Width320(64), Height320(38))];
    
    titleLabel.text = title;
    
    titleLabel.textColor = kMainColor;
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    titleLabel.font = AllFont(16);
    
    [view addSubview:titleLabel];
    
    UIButton *hintCloseButton = [[UIButton alloc]initWithFrame:CGRectMake(view.width-Width320(38), 0, Width320(32), Height320(38))];
    
    [view addSubview:hintCloseButton];
    
    [hintCloseButton addTarget:self action:@selector(closeAlert) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *buttonImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(13), Height320(13), Width320(12), Height320(12))];
    
    buttonImg.image = [UIImage imageNamed:@"app_alert_close"];
    
    [hintCloseButton addSubview:buttonImg];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(38), view.width, OnePX)];
    
    line.backgroundColor = kMainColor;
    
    [view addSubview:line];
    
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(view.frame.size.width/2-Width320(32), Height320(50), Width320(64), Height320(64))];
    
    iconView.image = [UIImage imageNamed:@"staff_app_icon"];
    
    [view addSubview:iconView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(10), iconView.bottom+Height320(12), view.width-Width320(20), Height320(40))];
    
    label.text = subtitle.length?subtitle:@"请在青橙健身房管理App中\n使用该功能";
    
    label.textColor = UIColorFromRGB(0x666666);
    
    label.textAlignment = NSTextAlignmentCenter;

    label.numberOfLines = 2;
    
    label.font = AllFont(14);
    
    [view addSubview:label];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), label.bottom+Height320(16), view.width-Width320(32), Height320(38))];
    
    button.layer.cornerRadius = 2;
    
    button.backgroundColor = kMainColor;
    
    [button setTitle:@"打开健身房管理App" forState:UIControlStateNormal];
    
    [button setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    button.titleLabel.font = AllFont(15);
    
    [view addSubview:button];
    
    [button addTarget:self action:@selector(openApp) forControlEvents:UIControlEventTouchUpInside];
    
    [_window makeKeyAndVisible];
    
}

-(void)closeAlert
{
    
    [_window resignKeyWindow];
    
    _window.hidden = YES;
    
    _window = nil;
    
}

-(void)openApp
{
    
    [self closeAlert];
    
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"qcstaff://"]]) {
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"qcstaff://"]];
        
    }else{
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/app/id1131440134"]];
        
    }
    
}

@end
