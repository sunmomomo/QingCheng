//
//  CheckinCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CheckinCell.h"

#import "MOCell.h"

@interface CheckinCell ()

{
    
    UIButton *_iconView;
    
    UIImageView *_sexImg;
    
    UILabel *_nameLabel;
    
    UILabel *_phoneLabel;
    
    UILabel *_cardLabel;
    
    UILabel *_priceLabel;
    
    MOCell *_ChestCell;
    
    UIView *_courseView;
    
    UIView *_courseTop;
    
    UIImageView *_bottomView;
    
    UIView *_chestView;
    
    UIView *_mainView;
    
    UIButton *_ignoreButton;
    
    UIButton *_confirmButton;
    
}

@end

@implementation CheckinCell

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
        
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(183))];
        
        _mainView.backgroundColor = UIColorFromRGB(0x8CB5BA);
        
        _mainView.userInteractionEnabled = YES;
        
        [self.contentView addSubview:_mainView];
        
        _mainView.layer.shadowOffset = CGSizeMake(0, 2);
        
        _mainView.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
        
        _mainView.layer.shadowOpacity = 0.13;
        
        _iconView = [[UIButton alloc]initWithFrame:CGRectMake(Width320(12), Height320(12), Width320(50), Height320(50))];
        
        _iconView.backgroundColor = UIColorFromRGB(0xffffff);
        
        _iconView.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
        
        _iconView.layer.borderWidth = 1;
        
        [_iconView addTarget:self action:@selector(uploadPhoto) forControlEvents:UIControlEventTouchUpInside];
        
        [_mainView addSubview:_iconView];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconView.right+Width320(10), Height320(10), Width320(200), Height320(16))];
        
        _nameLabel.textColor = UIColorFromRGB(0xffffff);
        
        _nameLabel.font = AllFont(14);
        
        [_mainView addSubview:_nameLabel];
        
        _sexImg = [[UIImageView alloc]initWithFrame:CGRectMake(_nameLabel.right+Width320(5), Height320(13), Width320(12), Height320(12))];
        
        _sexImg.backgroundColor = UIColorFromRGB(0xffffff);
        
        _sexImg.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
        
        _sexImg.layer.borderWidth = 1;
        
        _sexImg.layer.cornerRadius = _sexImg.width/2;
        
        _sexImg.layer.masksToBounds = YES;
        
        [_mainView addSubview:_sexImg];
        
        _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.left, _nameLabel.bottom+Height320(5), MSW-Width320(22)-_iconView.right, Height320(14))];
        
        _phoneLabel.textColor = UIColorFromRGB(0xffffff);
        
        _phoneLabel.font = AllFont(12);
        
        [_mainView addSubview:_phoneLabel];
        
        _cardLabel = [[UILabel alloc]initWithFrame:CGRectMake(_phoneLabel.left, _phoneLabel.bottom+Height320(3), _phoneLabel.width, Height320(14))];
        
        _cardLabel.textColor = UIColorFromRGB(0xffffff);
        
        _cardLabel.font = AllFont(12);
        
        _cardLabel.numberOfLines = 0;
        
        [_mainView addSubview:_cardLabel];
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(_cardLabel.left, _cardLabel.bottom+Height320(3), _cardLabel.width, _cardLabel.height)];
        
        _priceLabel.textColor = UIColorFromRGB(0xffffff);
        
        _priceLabel.font = AllFont(12);
        
        [_mainView addSubview:_priceLabel];
        
        _chestView = [[UIView alloc]initWithFrame:CGRectMake(Width320(12), _priceLabel.bottom+Height320(10), MSW-Width320(20), Height320(80))];
        
        _chestView.backgroundColor = UIColorFromRGB(0xffffff);
        
        _chestView.layer.cornerRadius = 1;
        
        _chestView.layer.masksToBounds = YES;
        
        _chestView.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
        
        _chestView.layer.shadowOffset = CGSizeMake(0, Height320(5));
        
        _chestView.layer.shadowOpacity = 0.13;
        
        [_mainView addSubview:_chestView];
        
        _ChestCell = [[MOCell alloc]initWithFrame:CGRectMake(Width320(10), 0, _chestView.width-Width320(20), Height320(40))];
        
        _ChestCell.titleLabel.text = @"更衣柜：";
        
        _ChestCell.titleLabel.textColor = UIColorFromRGB(0x999999);
        
        _ChestCell.titleLabel.font = AllFont(13);
        
        _ChestCell.placeholder = @"请选择更衣柜";
        
        _ChestCell.subtitleLabel.font = AllFont(13);
        
        _ChestCell.noLine = YES;
        
        [_chestView addSubview:_ChestCell];
        
        [_ChestCell addTarget:self action:@selector(chestChoose:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(40)-1/[UIScreen mainScreen].scale, _chestView.width, 1/[UIScreen mainScreen].scale)];
        
        sep.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [_ChestCell addSubview:sep];
        
        _ignoreButton = [[UIButton alloc]initWithFrame:CGRectMake(0, Height320(40), _chestView.width/2, Height320(40))];
        
        [_ignoreButton addTarget:self action:@selector(ignore) forControlEvents:UIControlEventTouchUpInside];
        
        [_chestView addSubview:_ignoreButton];
        
        UIImageView *ignoreImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(51), Height320(13.5), Width320(14), Height320(12))];
        
        ignoreImg.image = [UIImage imageNamed:@"checkin_ignore"];
        
        [_ignoreButton addSubview:ignoreImg];
        
        UILabel *ignoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(ignoreImg.right+Width320(6), 0, Width320(40), Height320(40))];
        
        ignoreLabel.text = @"忽略";
        
        ignoreLabel.textColor = UIColorFromRGB(0x999999);
        
        ignoreLabel.font = AllFont(13);
        
        [_ignoreButton addSubview:ignoreLabel];
        
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(_chestView.width/2, Height320(40), _chestView.width/2, Height320(40))];
        
        [_confirmButton addTarget:self action:@selector(checkin) forControlEvents:UIControlEventTouchUpInside];
        
        [_chestView addSubview:_confirmButton];
        
        UIImageView *confirmImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(51), Height320(14), Width320(12), Height320(12))];
        
        confirmImg.image = [UIImage imageNamed:@"checkin_button"];
        
        [_confirmButton addSubview:confirmImg];
        
        UILabel *confirmLabel = [[UILabel alloc]initWithFrame:CGRectMake(confirmImg.right+Width320(6), 0, Width320(70), Height320(40))];
        
        confirmLabel.text = @"确认签到";
        
        confirmLabel.textColor = UIColorFromRGB(0x0DB14B);
        
        confirmLabel.font = AllFont(13);
        
        [_confirmButton addSubview:confirmLabel];
        
        UIView *hsep = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(10), 1/[UIScreen mainScreen].scale, Height320(20))];
        
        hsep.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [_confirmButton addSubview:hsep];
        
        _courseView = [[UIView alloc]initWithFrame:CGRectMake(0, _mainView.bottom, MSW, Height320(13))];
        
        _courseView.layer.shadowColor = [UIColor blackColor].CGColor;
        
        _courseView.layer.shadowOffset = CGSizeMake(0, Height320(2));
        
        _courseView.layer.shadowOpacity = 0.12;
        
        [self.contentView addSubview:_courseView];
        
        _courseTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW,_courseTop.height-Height320(8))];
        
        _courseTop.backgroundColor = UIColorFromRGB(0xffffff);
        
        [_courseView addSubview:_courseTop];
        
        _bottomView = [[UIImageView alloc]initWithFrame:CGRectMake(0, _courseTop.bottom, MSW, Height320(8))];
        
        _bottomView.image = [UIImage imageNamed:@"checkin_bottom"];
        
        [_courseView addSubview:_bottomView];
        
    }
    
    return self;
    
}

-(void)uploadPhoto
{
    
    [self.delegate uploadPhotoWithCheckinCell:self];
    
}

-(void)setImgURL:(NSURL *)imgURL
{
    
    _imgURL = imgURL;
    
    if (_imgURL.absoluteString.length) {
        
        [_iconView sd_setImageWithURL:_imgURL forState:UIControlStateNormal];
        
    }else{
        
        [_iconView setImage:[UIImage imageNamed:@"checkin_photo_add"] forState:UIControlStateNormal];
        
    }
    
}

-(void)setName:(NSString *)name
{
    
    _nameLabel.text = name;
    
    [_nameLabel autoWidth];
    
    [_sexImg changeLeft:_nameLabel.right+Width320(5)];
    
}

-(void)setSex:(SexType)sex
{
    
    _sex = sex;
    
    _sexImg.image = _sex == SexTypeMan?[UIImage imageNamed:@"sex_male"]:[UIImage imageNamed:@"sex_female"];
    
}

-(void)setPhone:(NSString *)phone
{
    
    _phone = phone;
    
    _phoneLabel.text = [NSString stringWithFormat:@"手机：%@",_phone.length?_phone:@""];
    
}

-(void)setPrice:(NSString *)price
{
    
    _price = price;
    
    if (_price.length) {
        
        _priceLabel.hidden = NO;
        
        _priceLabel.text = [NSString stringWithFormat:@"费用：%@",_price];
        
        [_priceLabel changeTop:_cardLabel.bottom+Height320(3)];
        
        [_chestView changeTop:_priceLabel.bottom+Height320(10)];
        
        [_mainView changeHeight:_chestView.bottom+Height320(12)];
        
        [_courseView changeTop:_mainView.bottom];
        
    }else{
        
        _priceLabel.hidden = YES;
        
        _priceLabel.text = @"";
        
    }
    
}

-(void)setCardName:(NSString *)cardName
{
    
    _cardName = cardName;
    
    _cardLabel.text = [NSString stringWithFormat:@"会员卡：%@",_cardName];
    
}

-(void)setRemain:(NSString*)remain
{
    
    _remain = remain;
    
    _cardLabel.text = [NSString stringWithFormat:@"会员卡：%@（%@）",_cardName,_remain];
    
    CGSize cardSize = [_cardLabel.text boundingRectWithSize:CGSizeMake(MSW-Width320(82), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
    
    [_cardLabel changeSize:cardSize];
    
    [_chestView changeTop:_cardLabel.bottom+Height320(10)];
    
    [_mainView changeHeight:_chestView.bottom+Height320(12)];
    
    [_courseView changeTop:_mainView.bottom];
    
}

-(void)setCourseBatches:(NSArray *)courseBatches
{
    
    _courseBatches = courseBatches;
    
    if (_courseBatches.count) {
        
        _mainView.layer.shadowOpacity = 0;
        
        [self.contentView addSubview:_courseView];
        
        [_courseTop changeHeight:Height320(30)+_courseBatches.count*Height320(40)];
        
        [_bottomView changeTop:_courseTop.bottom];
        
        [_courseView changeHeight:_bottomView.bottom];
        
        [_courseTop removeAllView];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(Width320(12), Height320(11), Width320(3), Height320(11)+Height320(40)*_courseBatches.count)];
        
        lineView.backgroundColor = UIColorFromRGB(0x8CB5BA);
        
        [_courseTop addSubview:lineView];
        
        UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(25), Height320(9), Width320(200), Height320(14))];
        
        numLabel.text = [NSString stringWithFormat:@"当天预约课程（%ld）",(unsigned long)_courseBatches.count];
        
        numLabel.textColor = UIColorFromRGB(0x999999);
        
        numLabel.font = AllFont(12);
        
        [_courseTop addSubview:numLabel];
        
        for (NSInteger i = 0 ; i<_courseBatches.count; i++) {
            
            CoursePlanBatch *batch = _courseBatches[i];
            
            Course *course = batch.course;
            
            UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(25), numLabel.bottom+Height320(40)*i+Height320(2), Width320(40), Height320(14))];
            
            timeLabel.text = batch.start;
            
            timeLabel.textColor = UIColorFromRGB(0x666666);
            
            timeLabel.font = AllFont(12);
            
            [_courseTop addSubview:timeLabel];
            
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(timeLabel.right, timeLabel.top, MSW-Width320(12)-timeLabel.right, Height320(14))];
            
            nameLabel.text = course.name;
            
            nameLabel.textColor = UIColorFromRGB(0x666666);
            
            nameLabel.font = AllFont(12);
            
            [_courseTop addSubview:nameLabel];
            
            UILabel *subLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.left, nameLabel.bottom+Height320(3), nameLabel.width, nameLabel.height)];
            
            Yard *yard = [batch.yards firstObject];
            
            subLabel.text = [NSString stringWithFormat:@"教练：%@    场地：%@",batch.coach.name,yard.name];
            
            subLabel.textColor = UIColorFromRGB(0x999999);
            
            subLabel.font = AllFont(12);
            
            [_courseTop addSubview:subLabel];
            
        }
        
    }else{
        
        _mainView.layer.shadowOpacity = 0.13;
        
        [_courseView removeFromSuperview];
        
    }
    
}

-(void)chestChoose:(MOCell*)cell
{
    
    [self.delegate chestChooseWithCheckinCell:self];
    
}

-(void)setHaveChest:(BOOL)haveChest
{
    
    _haveChest = haveChest;
    
    if (_haveChest) {
        
        [_chestView changeHeight:Height320(80)];
        
        [_mainView changeHeight:Height320(183)];
        
        [_courseView changeTop:_mainView.bottom];
        
        _ChestCell.hidden = NO;
        
        [_confirmButton changeTop:Height320(40)];
        
        [_ignoreButton changeTop:Height320(40)];
        
    }else{
        
        [_chestView changeHeight:Height320(40)];
        
        [_mainView changeHeight:Height320(143)];
        
        [_courseView changeTop:_mainView.bottom];
        
        _ChestCell.hidden = YES;
        
        [_confirmButton changeTop:0];
        
        [_ignoreButton changeTop:0];
        
    }
    
}

-(void)setChest:(NSString *)chest
{
    
    _chest = chest;
    
    _ChestCell.subtitle = _chest;
    
}

-(void)ignore
{
    
    [self.delegate ignoreCheckinWithCheckinCell:self];
    
}

-(void)checkin
{
    
    [self.delegate checkinWithCheckinCell:self];
    
}

@end
