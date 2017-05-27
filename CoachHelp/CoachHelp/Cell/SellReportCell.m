//
//  SellReportCell.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/18.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "SellReportCell.h"

#import "UIImage+Category.h"

@interface SellReportCell ()

{
    
    UILabel *_dayLabel;
    
    UILabel *_monthLabel;
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UILabel *_userLabel;
    
    UILabel *_priceLabel;
    
    UILabel *_typeLabel;
    
    UIView *_sep;
    
    UIView *_lineView;
    
    UIView *_priceView;
    
    UIImageView *_tradeImg;
    
}

@end

@implementation SellReportCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(26), Width320(54), Height320(29))];
        
        _dayLabel.textColor = UIColorFromRGB(0x666666);
        
        _dayLabel.font = AllFont(25);
        
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_dayLabel];
        
        _monthLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _dayLabel.bottom, Width320(54), Height320(18))];
        
        _monthLabel.font = AllFont(14);
        
        _monthLabel.textColor = UIColorFromRGB(0x999999);
        
        _monthLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_monthLabel];
        
        _sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(54)-1, 0, 1, Height320(95))];
        
        _sep.backgroundColor = UIColorFromRGB(0xeeeeee);
        
        [self.contentView addSubview:_sep];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_sep.right+Width320(8), Height320(16), MSW-_sep.right-Width320(83), Height320(18))];
        
        _titleLabel.font = AllFont(14);
        
        _titleLabel.textColor = UIColorFromRGB(0x666666);
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(3), _titleLabel.width, Height320(14))];
        
        _subtitleLabel.textColor = UIColorFromRGB(0x999999);
        
        _subtitleLabel.font = AllFont(12);
        
        [self.contentView addSubview:_subtitleLabel];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _subtitleLabel.bottom+Height320(3), Width320(34), Height320(14))];
        
        label.text = @"会员：";
        
        label.textColor = UIColorFromRGB(0x999999);
        
        label.font = AllFont(12);
        
        label.textAlignment = NSTextAlignmentRight;
        
        [label autoWidth];
        
        [self.contentView addSubview:label];
        
        _userLabel = [[UILabel alloc]initWithFrame:CGRectMake(label.right, label.top, Width320(215), Height320(40))];
        
        _userLabel.textColor = UIColorFromRGB(0x999999);
        
        _userLabel.font = AllFont(12);
        
        _userLabel.numberOfLines = 0;
        
        [self.contentView addSubview:_userLabel];
        
        _priceView = [[UIView alloc]initWithFrame:CGRectMake(Width320(54), Height320(71), MSW-Width320(54), Height320(24))];
        
        _priceView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        [self.contentView addSubview:_priceView];
        
        _tradeImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(10), Height320(5), Width320(27), Height320(14))];
        
        _tradeImg.contentMode = UIViewContentModeScaleAspectFit;
        
        [_priceView addSubview:_tradeImg];
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(_tradeImg.right+Width320(6),0, _priceView.width-_tradeImg.width-Width320(12), Height320(24))];
        
        _priceLabel.textColor = UIColorFromRGB(0x666666);
        
        _priceLabel.font = AllFont(12);
        
        [_priceView addSubview:_priceLabel];
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, 1)];
        
        _lineView.backgroundColor = UIColorFromRGB(0xeeeeee);
        
        [self.contentView addSubview:_lineView];
        
    }
    
    return self;
    
}


-(void)setMonth:(NSString *)month
{
    
    _month = month;
    
    if (_sectionFirst) {
        
        _monthLabel.text = month;
        
    }
    
}

-(void)setDay:(NSString *)day
{
    
    _day = day;
    
    if (_sectionFirst) {
        
        _dayLabel.text = _day;
        
    }
    
}

-(void)setSectionFirst:(BOOL)sectionFirst
{
    
    _sectionFirst = sectionFirst;
    
    if (_sectionFirst) {
        
        _monthLabel.hidden = NO;
        
        _dayLabel.hidden = NO;
        
    }else
    {
        
        _monthLabel.hidden = YES;
        
        _dayLabel.hidden = YES;
        
    }
    
}

-(void)setSectionLast:(BOOL)sectionLast
{
    
    _sectionLast = sectionLast;
    
    if (_sectionLast) {
        
        [_lineView changeLeft:0];
        
        [_lineView changeWidth:MSW];
        
    }else
    {
        
        [_lineView changeLeft:Width320(54)];
        
        [_lineView changeWidth:MSW-Width320(54)];
        
    }
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
}

-(void)setCost:(float)cost
{
    
    _cost = cost;
    
    NSString *price = @"";
    
    if ([[NSString stringWithFormat:@"%.2f",_cost] rangeOfString:@".00"].length) {
        
        price = [NSString stringWithFormat:@"%ld",(long)_cost];
        
    }else{
        
        price = [NSString stringWithFormat:@"%.2f",_cost];
        
    }
    
    _priceLabel.text = [NSString stringWithFormat:@"￥%@元",price];
    
}

-(void)setUsers:(NSString *)users
{
    
    _users = users;
    
    CGSize size = [users boundingRectWithSize:CGSizeMake(Width320(215), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
    
    [_userLabel changeHeight:size.height];
    
    [_priceView changeTop:Height320(63)+size.height];
    
    [_lineView changeTop:_priceView.bottom-1];
    
    [_sep changeHeight:_priceView.bottom];
    
    _userLabel.text = users;
    
}

-(void)setSeller:(NSString *)seller
{
    
    _seller = seller;
    
    _subtitleLabel.text = [NSString stringWithFormat:@"销售：%@",_seller.length?_seller:@"无销售"];
    
}

-(void)setTradeType:(TradeType)tradeType
{
    
    _tradeType = tradeType;
    
    switch (_tradeType) {
            
        case TradeTypeCreate:
            
            _tradeImg.image = [UIImage imageNamed:@"sell_report_type_create"];
            
            [_tradeImg changeWidth:Width320(38)];
            
            [_priceLabel changeLeft:_tradeImg.right+Width320(6)];
            
            [_priceLabel changeWidth:_priceView.width-_tradeImg.width-Width320(12)];
            
            break;
            
        case TradeTypeRecharge:
            
            _tradeImg.image = [UIImage imageNamed:@"sell_report_type_recharge"];
            
            [_tradeImg changeWidth:Width320(27)];
            
            [_priceLabel changeLeft:_tradeImg.right+Width320(6)];
            
            [_priceLabel changeWidth:_priceView.width-_tradeImg.width-Width320(12)];
            
            break;
            
        case TradeTypeCost:
            
            _tradeImg.image = [UIImage imageNamed:@"sell_report_type_cost"];
            
            [_tradeImg changeWidth:Width320(27)];
            
            [_priceLabel changeLeft:_tradeImg.right+Width320(6)];
            
            [_priceLabel changeWidth:_priceView.width-_tradeImg.width-Width320(12)];
            
            break;
            
        case TradeTypeGive:
            
            _tradeImg.image = [UIImage imageNamed:@"sell_report_type_give"];
            
            [_tradeImg changeWidth:Width320(27)];
            
            [_priceLabel changeLeft:_tradeImg.right+Width320(6)];
            
            [_priceLabel changeWidth:_priceView.width-_tradeImg.width-Width320(12)];
            
            break;
            
        default:
            break;
            
    }
    
}

-(void)setPrice:(float)price andCost:(float)cost
{
    
    _price = price;
    
    _cost = cost;
    
    NSString *str = @"";
    
    NSString *priceStr = @"";
    
    if ([[NSString stringWithFormat:@"￥%.2f",_price] rangeOfString:@".00"].length) {
        
        priceStr = [NSString stringWithFormat:@"￥%ld",_tradeType == TradeTypeCost?(long)-_price:(long)_price];
        
    }else{
        
        priceStr = [NSString stringWithFormat:@"￥%.2f",_tradeType == TradeTypeCost?-_price:_price];
        
    }
    
    NSString *tradeStr = @"";
    
    if (_tradeType == TradeTypeCost) {
        
        tradeStr = [NSString stringWithFormat:@"退款%@  扣费",priceStr];
        
    }else if (_tradeType == TradeTypeGive){
        
        tradeStr = [NSString stringWithFormat:@"赠送%@  充值",priceStr];
        
    }else{
        
        NSString *payStr = @"";
        
        switch (_payWay) {
                
            case PayWayWeChat:
                
                payStr = @"微信支付";
                
                break;
                
            case PayWayQRCode:
                
                payStr = @"微信扫码支付";
                
                break;
                
            case PayWayCard:
                
                payStr = @"刷卡支付";
                
                break;
                
            case PayWayCash:
                
                payStr = @"现金支付";
                
                break;
                
            case PayWayTransfer:
                
                payStr = @"转账支付";
                
                break;
                
            case PayWayOther:
                
                payStr = @"其他支付";
                
                break;
                
            default:
                break;
        }
        
        tradeStr = [NSString stringWithFormat:_cardKindType == CardKindTypeTime?@"%@%@":@"%@%@  充值",payStr,priceStr];
        
    }
    
    NSString *costStr = @"";
    
    if ([[NSString stringWithFormat:@"￥%.2f",_cost] rangeOfString:@".00"].length) {
        
        costStr = [NSString stringWithFormat:@"%ld",_tradeType == TradeTypeCost?(long)-_cost:(long)_cost];
        
    }else{
        
        costStr = [NSString stringWithFormat:@"%.2f",_tradeType == TradeTypeCost?-_cost:_cost];
        
    }
    
    if (_cardKindType != CardKindTypeTime) {
        
        str = [NSString stringWithFormat:@"%@%@%@",tradeStr,costStr,_cardKindType == CardKindTypePrepaid?@"元":_cardKindType == CardKindTypeCount?@"次":@"天"];
        
    }else{
        
        str = tradeStr;
        
    }
    
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:str];
    
    [astr addAttribute:NSForegroundColorAttributeName value:_tradeType == TradeTypeCost?UIColorFromRGB(0xEA6161):UIColorFromRGB(0x0DB14B) range:[str rangeOfString:priceStr]];
    
    _priceLabel.attributedText = astr;
    
}

@end
