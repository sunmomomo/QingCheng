
//
//  ScheduleReportDetailCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/5/10.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ScheduleReportDetailCell.h"

@interface ScheduleReportDetailCell ()

{
    
    UIImageView *_iconView;
    
    UILabel *_nameLabel;
    
    UIImageView *_sexImg;
    
    UILabel *_stateLabel;
    
    UILabel *_phoneLabel;
    
    UILabel *_timeLabel;
    
    UIImageView *_typeImg;
    
    UILabel *_cardLabel;
    
    UILabel *_countLabel;
    
    UILabel *_priceLabel;
    
    UILabel *_realLabel;
    
}

@end

@implementation ScheduleReportDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width(15), Height(15), Width(48), Height(48))];
        
        _iconView.layer.cornerRadius = _iconView.width/2;
        
        _iconView.layer.masksToBounds = YES;
        
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:_iconView];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconView.right+Width(15), Height(15), Width(100), Height(21))];
        
        _nameLabel.textColor = UIColorFromRGB(0x333333);
        
        _nameLabel.font = AllFont(14);
        
        [self.contentView addSubview:_nameLabel];
        
        _sexImg = [[UIImageView alloc]initWithFrame:CGRectMake(_nameLabel.right+Width(4), Height(18.5), Width(14), Height(14))];
        
        [self.contentView addSubview:_sexImg];
        
        _stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width(60), Height(17), Width(50), Height(18))];
        
        _stateLabel.textColor = kMainColor;
        
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        
        _stateLabel.font = AllFont(12);
        
        [self.contentView addSubview:_stateLabel];
        
        _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.left, _nameLabel.bottom+Height(4), MSW-Width(15)-_nameLabel.left, Height(18))];
        
        _phoneLabel.textColor = UIColorFromRGB(0x888888);
        
        _phoneLabel.font = AllFont(12);
        
        [self.contentView addSubview:_phoneLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.left, _phoneLabel.bottom+Height(4), _phoneLabel.width, Height(18))];
        
        _timeLabel.textColor = UIColorFromRGB(0x888888);
        
        _timeLabel.font = AllFont(12);
        
        [self.contentView addSubview:_timeLabel];
        
        _typeImg = [[UIImageView alloc]initWithFrame:CGRectMake(_nameLabel.left, _timeLabel.bottom+Height(6.5), Width(16), Height(16))];
        
        [self.contentView addSubview:_typeImg];
        
        _cardLabel = [[UILabel alloc]initWithFrame:CGRectMake(_typeImg.right+Width(6), _timeLabel.bottom+Height(5), MSW-Width(15)-Width(6)-_typeImg.right, Height(18))];
        
        _cardLabel.textColor = UIColorFromRGB(0x888888);
        
        _cardLabel.font = AllFont(12);
        
        [self.contentView addSubview:_cardLabel];
        
        UILabel *countLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.left, _cardLabel.bottom+Height(15), Width(30), Height(17))];
        
        countLabel.text = @"人数";
        
        countLabel.textColor = UIColorFromRGB(0xbbbbbb);
        
        countLabel.font = AllFont(11);
        
        [self.contentView addSubview:countLabel];
        
        _countLabel = [[UILabel alloc]initWithFrame:CGRectMake(countLabel.left, countLabel.bottom+Height(2), Width(64), Height(21))];
        
        _countLabel.textColor = UIColorFromRGB(0x333333);
        
        _countLabel.font = AllFont(14);
        
        [self.contentView addSubview:_countLabel];
        
        UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(_countLabel.right+Width(20), countLabel.top, Width(88), Height(17))];
        
        priceLabel.text = @"课程收入";
        
        priceLabel.textColor = UIColorFromRGB(0xbbbbbb);
        
        priceLabel.font = AllFont(11);
        
        [self.contentView addSubview:priceLabel];
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(priceLabel.left, priceLabel.bottom+Height(2), priceLabel.width, Height(21))];
        
        _priceLabel.textColor = UIColorFromRGB(0x333333);
        
        _priceLabel.font = AllFont(14);
        
        [self.contentView addSubview:_priceLabel];
        
        UILabel *realLabel = [[UILabel alloc]initWithFrame:CGRectMake(priceLabel.right+Width(20), priceLabel.top, Width(88), Height(17))];
        
        realLabel.text = @"实收";
        
        realLabel.textColor = UIColorFromRGB(0xbbbbbb);
        
        realLabel.font = AllFont(11);
        
        [self.contentView addSubview:realLabel];
        
        _realLabel = [[UILabel alloc]initWithFrame:CGRectMake(realLabel.left, realLabel.bottom+Height(2), realLabel.width, Height(21))];
        
        _realLabel.textColor = UIColorFromRGB(0xF9944E);
        
        _realLabel.font = AllFont(14);
        
        [self.contentView addSubview:_realLabel];
        
    }
    
    return self;
    
}

-(void)layoutSubviews
{
    
    [super layoutSubviews];
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:_icon]];
    
    _nameLabel.text = _name;
    
    [_nameLabel autoWidth];
    
    [_sexImg changeLeft:_nameLabel.right+Width(4)];
    
    _sexImg.image = [UIImage imageNamed:_sex==SexTypeWoman?@"sex_female":@"sex_male"];
    
    switch (self.status) {
            
        case ScheduleReportDetailPayStatusCreate:
            
            _stateLabel.text = @"已预约";
            
            break;
            
        case ScheduleReportDetailPayStatusDone:
            
            _stateLabel.text = @"已完成";
            
            break;
            
        case ScheduleReportDetailPayStatusCancel:
            
            _stateLabel.text = @"已取消";
            
            break;
            
        case ScheduleReportDetailPayStatusSignin:
            
            _stateLabel.text = @"已签课";
            
            break;
            
        default:
            break;
    }
    
    _phoneLabel.text = _phone;
    
    _timeLabel.text = [NSString stringWithFormat:@"预约时间：%@",_time];
    
    switch (self.type) {
        case ScheduleReportDetailPayTypeCard:
            
            _typeImg.image = [UIImage imageNamed:@"card_pay_card"];
            
            if (_card.cardNumber.length) {
                
                _cardLabel.text = [NSString stringWithFormat:@"%@(ID:%@)",_card.cardKind.cardKindName,_card.cardNumber];
                
            }else{
                
                _cardLabel.text = _card.cardKind.cardKindName;
                
            }
            
            break;
            
        case ScheduleReportDetailPayTypeOnline:
        case ScheduleReportDetailPayTypeWechat:
        case ScheduleReportDetailPayTypeWechatCode:
            
            _typeImg.image = [UIImage imageNamed:@"pay_way_wechat"];
            
            _cardLabel.text = @"微信支付";
            
            break;
            
        case ScheduleReportDetailPayTypeNopay:
            
            _typeImg.image = [UIImage imageNamed:@"pay_way_free"];
            
            _cardLabel.text = @"无需结算";
            
            break;
            
        default:
            break;
    }
    
    _countLabel.text = [NSString stringWithFormat:@"%ld",(long)_count];
    
    if (_card.cardKind.type == CardKindTypeTime) {
        
        _priceLabel.text = @"- -";
        
        _realLabel.text = @"- -";
        
    }else{
        
        _priceLabel.text = _card.cardKind.type==CardKindTypeCount?[NSString stringWithFormat:@"%ld次",(long)_price]:[NSString stringWithFormat:@"%.2f元",_price];
        
        _realLabel.text = [NSString stringWithFormat:@"%.2f元",_realPrice];
        
    }
    
}

@end
