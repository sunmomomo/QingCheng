//
//  BrandGymCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/13.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "BrandGymCell.h"

@interface BrandGymCell ()<UIAlertViewDelegate>

{
    
    UIImageView *_iconView;
    
    UILabel *_titleLabel;
    
    UILabel *_validTimeLabel;
    
    UILabel *_contactLabel;
    
    UILabel *_positionLabel;
    
    UILabel *_proLabel;
    
}

@end

@implementation BrandGymCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        UIView *mainBackView = [[UIView alloc]initWithFrame:CGRectMake(Width320(12), Height320(6), MSW-Width320(12)*2, Height320(99))];
        
        mainBackView.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
        
        mainBackView.layer.shadowOffset = CGSizeMake(0, 2);
        
        mainBackView.layer.shadowOpacity = 0.17;
        
        [self.contentView addSubview:mainBackView];
        
        UIView *mainView = [[UIView alloc]initWithFrame:CGRectMake(0,0,mainBackView.frame.size.width,mainBackView.frame.size.height)];
        
        mainView.backgroundColor = UIColorFromRGB(0xffffff);
        
        mainView.layer.cornerRadius = Width320(2);
        
        mainView.layer.masksToBounds = YES;
        
        [mainBackView addSubview:mainView];
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(10), Height320(12), Width320(40), Height320(40))];
        
        _iconView.layer.cornerRadius = _iconView.width/2;
        
        _iconView.layer.masksToBounds = YES;
        
        [mainView addSubview:_iconView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconView.right+Width320(8), Height320(12), mainView.width-_iconView.right-Width320(55), Height320(16))];
        
        _titleLabel.font = AllFont(14);
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        [mainView addSubview:_titleLabel];
        
        _proLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.right+Width320(2), Height320(18), Width320(21), Height320(12))];
        
        _proLabel.layer.cornerRadius = _proLabel.height/2;
        
        _proLabel.layer.masksToBounds = YES;
        
        _proLabel.textAlignment = NSTextAlignmentCenter;
        
        _proLabel.textColor = UIColorFromRGB(0xffffff);
        
        _proLabel.font = AllFont(7);
        
        [mainView addSubview:_proLabel];
        
        _proLabel.center = CGPointMake(_proLabel.center.x, _titleLabel.center.y);
        
        _validTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(6), _titleLabel.width, Height320(14))];
        
        _validTimeLabel.font = AllFont(12);
        
        _validTimeLabel.textColor = UIColorFromRGB(0x999999);
        
        [mainView addSubview:_validTimeLabel];
        
        _contactLabel = [[UILabel alloc]initWithFrame:CGRectMake(_validTimeLabel.left, _validTimeLabel.bottom+Height320(6), _validTimeLabel.width, _validTimeLabel.height)];
        
        _contactLabel.font = AllFont(12);
        
        _contactLabel.textColor = UIColorFromRGB(0x999999);
        
        [mainView addSubview:_contactLabel];
        
        _positionLabel = [[UILabel alloc]initWithFrame:CGRectMake(_contactLabel.left, _contactLabel.bottom+Height320(6), _contactLabel.width, _contactLabel.height)];
        
        _positionLabel.font = AllFont(12);
        
        _positionLabel.textColor = UIColorFromRGB(0x999999);
        
        [mainView addSubview:_positionLabel];
        
        UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(mainView.width-Width320(47), Height320(6), Width320(47), Height320(26))];
        
        self.deleteButton = deleteButton;

        [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        
        [deleteButton setTitleColor:UIColorFromRGB(0xF9944E) forState:UIControlStateNormal];
        
        deleteButton.titleLabel.font = AllFont(12);
        
        [mainView addSubview:deleteButton];
        
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
    
}

-(void)deleteClick
{
    
    if (self.deleteBlock) {
        self.deleteBlock(self.deleteButton.tag);
    }
//    [[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"请联系青橙客服\n%@",QCPhone] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫",nil]show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",QCPhone]]];
        
    }
    
}

-(void)setIconURL:(NSURL *)iconURL
{
    
    _iconURL = iconURL;
    
    [_iconView sd_setImageWithURL:_iconURL placeholderImage:[UIImage imageNamed:@"gymplaceholder"]];
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
    CGSize size = [_title boundingRectWithSize:CGSizeMake(MSW-Width320(130), Height320(16)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(14)} context:nil].size;
    
    [_titleLabel changeWidth:size.width];
    
    [_proLabel changeLeft:_titleLabel.right+Width320(3)];
    
}

-(void)setPro:(BOOL)pro
{
    
    _pro = pro;
    
    _proLabel.text = _pro?@"PRO":@"FREE";
    
    _proLabel.backgroundColor = _pro?kMainColor:UIColorFromRGB(0xD0D0D0);
    
}

-(void)setPhone:(NSString *)phone
{
    
    _phone = phone;
    
    _validTimeLabel.text = [NSString stringWithFormat:@"联系方式：%@",_phone.length?_phone:@""];
    
}

-(void)setSuperuserName:(NSString *)superuserName
{
    
    _superuserName = superuserName;
    
    _contactLabel.text = [NSString stringWithFormat:@"超级管理员：%@",_superuserName.length?_superuserName:@""];
    
}

-(void)setPosition:(NSString *)position
{
    
    _position = position;
    
    _positionLabel.text = [NSString stringWithFormat:@"我的职位：%@",_position.length?_position:@""];
    
}

@end
