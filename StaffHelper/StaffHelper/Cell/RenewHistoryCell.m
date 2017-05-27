//
//  RenewHistoryCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/20.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "RenewHistoryCell.h"

@interface RenewHistoryCell ()

{
    
    UILabel *_dateLabel;
    
    UILabel *_validTimeLabel;
    
    UILabel *_priceLabel;
    
    UILabel *_staffLabel;
    
    UILabel *_typeLabel;
    
    UILabel *_successLabel;
    
}

@end

@implementation RenewHistoryCell

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
        
        self.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        UIView *mainView = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(12), MSW, Height320(112))];
        
        mainView.backgroundColor = UIColorFromRGB(0xffffff);
        
        mainView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        mainView.layer.borderWidth = OnePX;
        
        [self.contentView addSubview:mainView];
        
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), Height320(10), Width320(256), Height320(20))];
        
        _dateLabel.textColor = UIColorFromRGB(0x333333);
        
        _dateLabel.font = AllBFont(14);
        
        [mainView addSubview:_dateLabel];
        
        _successLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width320(48), Height320(11), Width320(48), Height320(17))];
        
        _successLabel.textAlignment = NSTextAlignmentCenter;
        
        _successLabel.font = AllFont(12);
        
        [mainView addSubview:_successLabel];
        
        NSString *str = @"系统有效期：";
        
        CGSize size = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, Height320(17)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
        
        UILabel *validTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_dateLabel.left, _dateLabel.bottom+Height320(5), size.width, Height320(17))];
        
        validTimeLabel.text = str;
        
        validTimeLabel.textColor = UIColorFromRGB(0x666666);
        
        validTimeLabel.font = AllFont(12);
        
        [mainView addSubview:validTimeLabel];
        
        _validTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(validTimeLabel.right, _dateLabel.bottom+Height320(5), _dateLabel.right-validTimeLabel.right, Height320(17))];
        
        _validTimeLabel.textColor = UIColorFromRGB(0x666666);
        
        _validTimeLabel.font = AllFont(12);
        
        [mainView addSubview:_validTimeLabel];
        
        UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(_dateLabel.left, validTimeLabel.bottom+Height320(3), validTimeLabel.width, Height320(17))];
        
        priceLabel.text = @"实收金额：";
        
        priceLabel.textColor = UIColorFromRGB(0x666666);
        
        priceLabel.font = AllFont(12);
        
        [mainView addSubview:priceLabel];
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(_validTimeLabel.left, priceLabel.top, _validTimeLabel.width, Height320(17))];
        
        _priceLabel.textColor = UIColorFromRGB(0x666666);
        
        _priceLabel.font = AllFont(12);
        
        [mainView addSubview:_priceLabel];
        
        _typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_dateLabel.left, priceLabel.bottom+Height320(15), priceLabel.width, Height320(14))];
        
        _typeLabel.textColor = UIColorFromRGB(0x999999);
        
        _typeLabel.font = AllFont(12);
        
        [mainView addSubview:_typeLabel];
        
        _staffLabel = [[UILabel alloc]initWithFrame:CGRectMake(_priceLabel.left, _typeLabel.top, _priceLabel.width, Height320(14))];
        
        _staffLabel.textColor = UIColorFromRGB(0x999999);
        
        _staffLabel.font = AllFont(12);
        
        [mainView addSubview:_staffLabel];
        
    }
    
    return self;
    
}

-(void)setDate:(NSString *)date
{
    
    _date = date;
    
    _dateLabel.text = _date;
    
}

-(void)setValidTime:(NSString *)validTime
{
    
    _validTime = validTime;
    
    _validTimeLabel.text = _validTime;
    
}

-(void)setRealPrice:(NSString *)realPrice
{
    
    _realPrice = realPrice;
    
    _priceLabel.text = _realPrice;
    
}

-(void)setHistoryType:(RenewHistoryType)historyType
{
    
    _historyType = historyType;
    
    switch (_historyType) {
        case RenewHistoryTypeWeixin:
        case RenewHistoryTypeWeixinQRCode:
        case RenewHistoryTypeAlipay:
            _typeLabel.text = @"在线续费";
            
            break;
         
        default:
            
            _typeLabel.text = @"线下续费";
            
            break;
    }
    
}

-(void)setStaffName:(NSString *)staffName
{
    
    _staffName = staffName;
    
    _staffLabel.text = _staffName;
    
}

-(void)setRenewSuccess:(BOOL)renewSuccess
{
    
    _renewSuccess = renewSuccess;
    
    _successLabel.text = _renewSuccess?@"成功":@"失败";
    
    _successLabel.textColor = _renewSuccess?UIColorFromRGB(0x0DB14B):UIColorFromRGB(0xEA6161);
    
}

@end
