//
//  SignInAlertView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/7.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "SignInAlertView.h"

#define kAnimationDuring 0.3

static NSString *identifier = @"Cell";

@interface SignInAlertView ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

{
    
    UIImageView *_iconView;
    
    UILabel *_nameLabel;
    
    UIImageView *_sexImg;
    
    UILabel *_phoneLabel;
    
    UILabel *_saleLabel;
    
    UIButton *_confirmButton;
    
    UITextField *_cardTF;
    
    UITextField *_numberTF;
    
    NSInteger _chooseNum;
    
    UIView *_alertView;
    
    UIView *_chooseCardView;
    
    UITableView *_tableView;
    
}

@property(nonatomic,strong)Student *stu;

@end

@implementation SignInAlertView

+(instancetype)defaultAlertVieWithStudent:(Student *)stu
{
    
    SignInAlertView *alert = [[self alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
    alert.stu = stu;
    
    return alert;
    
}

-(void)setStu:(Student *)stu
{
    
    _stu = stu;
    
    
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *backView = [[UIView alloc]initWithFrame:self.frame];
        
        backView.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.4];
        
        [backView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)]];
    
        [self addSubview:backView];
        
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(-Width320(280), Height320(153), Width320(280), Height320(262))];
        
        _alertView.backgroundColor = UIColorFromRGB(0xffffff);
        
        _alertView.layer.cornerRadius = Width320(4);
        
        _alertView.layer.masksToBounds = YES;
        
        [self addSubview:_alertView];
        
        UIView *alertTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _alertView.width, Height320(98))];
        
        alertTop.backgroundColor = UIColorFromRGB(0xf8f8f8);
        
        alertTop.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        alertTop.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
        [_alertView addSubview:alertTop];
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(12), Height320(20), Width320(58), Height320(58))];
        
        _iconView.layer.cornerRadius = _iconView.width/2;
        
        _iconView.layer.masksToBounds = YES;
        
        _iconView.layer.borderWidth = 1;
        
        _iconView.layer.borderColor = [UIColorFromRGB(0x333333) colorWithAlphaComponent:0.12].CGColor;
        
        [_alertView addSubview:_iconView];
        
        UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(Width320(255), Height320(11), Width320(12), Height320(12))];
        
        [closeBtn setImage:[UIImage imageNamed:@"gray_close"] forState:UIControlStateNormal];
        
        [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        
        [_alertView addSubview:closeBtn];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconView.right+Width320(10), Height320(23), Width320(160), Height320(16))];
        
        _nameLabel.font = AllFont(14);
        
        _nameLabel.textColor = UIColorFromRGB(0x333333);
        
        [_alertView addSubview:_nameLabel];
        
        _sexImg = [[UIImageView alloc]initWithFrame:CGRectMake(_nameLabel.right+Width320(4), Height320(24), Width320(12), Height320(12))];
        
        [_alertView addSubview:_sexImg];
        
        _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.left, _nameLabel.bottom+Height320(5), _nameLabel.width, Height320(14))];
        
        _phoneLabel.textColor = UIColorFromRGB(0x666666);
        
        _phoneLabel.font = AllFont(12);
        
        [_alertView addSubview:_phoneLabel];
        
        _saleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_phoneLabel.left, _phoneLabel.bottom+Height320(4), _phoneLabel.width, _phoneLabel.height)];
        
        _saleLabel.textColor = UIColorFromRGB(0x666666);
        
        _saleLabel.font = AllFont(12);
        
        [_alertView addSubview:_saleLabel];
        
        _cardTF = [[UITextField alloc]initWithFrame:CGRectMake(Width320(12), alertTop.bottom+Height320(12), _alertView.width-Width320(24), Height320(40))];
        
        _cardTF.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
        
        _cardTF.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
        _cardTF.layer.cornerRadius = 2;
        
        _cardTF.placeholder = @"选择会员卡";
        
        _cardTF.font = AllFont(14);
        
        _cardTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width320(8), _cardTF.width)];
        
        _cardTF.leftViewMode = UITextFieldViewModeAlways;
        
        _cardTF.rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width320(28), _cardTF.height)];
        
        UIImageView *rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(8), _cardTF.height/2-Height320(3), Width320(12), Height320(6))];
        
        rightImg.image = [UIImage imageNamed:@"gray_arrow_down"];
        
        _cardTF.delegate = self;
        
        [_cardTF.rightView addSubview:rightImg];
        
        _cardTF.rightViewMode = UITextFieldViewModeAlways;
        
        _cardTF.delegate = self;
        
        [_alertView addSubview:_cardTF];
        
        _numberTF = [[UITextField alloc]initWithFrame:CGRectMake(_cardTF.left, _cardTF.bottom+Height320(10), _cardTF.width, _cardTF.height)];
        
        _numberTF.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
        _numberTF.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
        
        _numberTF.layer.cornerRadius = 2;
        
        _numberTF.placeholder = @"输入该会员使用的更衣柜号";
        
        _numberTF.font = AllFont(14);
        
        _numberTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width320(8), _numberTF.height)];
        
        _numberTF.leftViewMode = UITextFieldViewModeAlways;
        
        _numberTF.delegate = self;
        
        [_alertView addSubview:_numberTF];
        
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(_cardTF.left, _numberTF.bottom+Height320(10), _cardTF.width, _cardTF.height)];
        
        _confirmButton.layer.cornerRadius = 2;
        
        _confirmButton.backgroundColor = [kMainColor colorWithAlphaComponent:0.3];
        
        [_confirmButton setTitle:@"确认签到" forState:UIControlStateNormal];
        
        [_confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
        _confirmButton.titleLabel.font = AllFont(14);
        
        _confirmButton.userInteractionEnabled = NO;
        
        [_alertView addSubview:_confirmButton];
        
        _chooseCardView = [[UIView alloc]initWithFrame:CGRectMake(Width320(20), Height320(133), MSW-Width320(40), Height320(317))];
        
        _chooseCardView.backgroundColor = UIColorFromRGB(0xffffff);
        
        _chooseCardView.layer.cornerRadius = Width320(2);
        
        _chooseCardView.layer.masksToBounds = YES;
        
        _chooseCardView.hidden = YES;
        
        [self addSubview:_chooseCardView];
        
        UILabel *chooseTopView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _chooseCardView.width, Height320(40))];
        
        chooseTopView.text = @"选择会员卡";
        
        chooseTopView.textColor = UIColorFromRGB(0x999999);
        
        chooseTopView.textAlignment = NSTextAlignmentCenter;
        
        chooseTopView.font = AllFont(14);
        
        chooseTopView.userInteractionEnabled = YES;
        
        [_chooseCardView addSubview:chooseTopView];
        
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, Width320(31.4), Height320(40))];
        
        [backBtn addTarget:self action:@selector(chooseCancel) forControlEvents:UIControlEventTouchUpInside];
        
        [chooseTopView addSubview:backBtn];
        
        UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(12), Height320(14), Width320(7.4), Height320(12))];
        
        backImg.image = [UIImage imageNamed:@"gray_arrow_left"];
        
        [backBtn addSubview:backImg];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, chooseTopView.height-1, chooseTopView.width, 1)];
        
        line.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [chooseTopView addSubview:line];
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(Width320(20), Height320(133), MSW-Width320(40), Height320(317)) style:UITableViewStylePlain];
        
        _tableView.dataSource = self;
        
        _tableView.delegate = self;
        
        _tableView.separatorInset = UIEdgeInsetsMake(0, Width320(12), 0, Width320(12));
        
        _tableView.tableFooterView = [UIView new];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
        
        [_chooseCardView addSubview:_tableView];
        
    }
    
    return self;
}

-(void)confirmClick:(UIButton*)button
{
    
    [self dismissWithConfirm:YES];
    
}

-(void)showInView:(UIView *)view
{
    
    [view addSubview:self];
    
    [UIView animateWithDuration:kAnimationDuring animations:^{
        
        [_alertView changeLeft:MSW/2-Width320(140)];
        
    }];
    
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (textField == _cardTF) {
        
        _alertView.hidden = YES;
        
        _chooseCardView.hidden = NO;
        
        return NO;
        
    }else
    {
        
        return YES;
        
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)textFieldDidChanged:(UITextField *)textField
{
    
    
    
}

-(void)close
{
    
    if ([_numberTF isFirstResponder]) {
        
        [_numberTF resignFirstResponder];
        
    }else
    {
        
        [self dismissWithConfirm:NO];
        
    }
    
}

-(void)dismissWithConfirm:(BOOL)confirm
{
    
    [UIView animateWithDuration:kAnimationDuring animations:^{
        
        [_alertView changeLeft:MSW];
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        if (confirm) {
            
            if ([self.delegate respondsToSelector:@selector(confirmWithStudent:andCard:andNumber:)]) {
                
                [self.delegate confirmWithStudent:self.stu andCard:self.stu.cards[_chooseNum-1] andNumber:_numberTF.text];
                
            }
            
        }
        
    }];
    
}

-(void)check
{
    
    if (!_chooseNum) {
        
        _confirmButton.backgroundColor = [kMainColor colorWithAlphaComponent:0.3];
        
        _confirmButton.userInteractionEnabled = NO;
        
    }else
    {
        
        _confirmButton.backgroundColor = kMainColor;
        
        _confirmButton.userInteractionEnabled = YES;
        
    }
    
}

-(void)chooseCancel
{
    
    _chooseCardView.hidden = YES;
    
    _alertView.hidden = NO;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(48);
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Card *card = self.stu.cards[indexPath.row];
    
    cell.textLabel.text = card.cardName;
    
    cell.textLabel.textColor = UIColorFromRGB(0x333333);
    
    cell.textLabel.font = AllFont(14);
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.stu.cards.count;
    
}

@end
