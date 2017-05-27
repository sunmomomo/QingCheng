//
//  CardCell.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/11/19.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "CardCell.h"

@interface CardCell ()

{
    
    UIView *_mainView;
    
    UILabel *_cardNameLabel;
    
    UILabel *_gymNameLabel;
    
    UILabel *_remainLabel;
    
    UILabel *_userLabel;
    
    UILabel *_timeTitleLabel;
    
    UILabel *_timeLabel;
    
    UIImageView *_arrowImg;
    
}

@end

@implementation CardCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(Width320(8.8), Height320(4.4), MSW-Width320(17.6), Height320(200))];
        
        _mainView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        _mainView.layer.borderWidth = 1;
        
        _mainView.layer.cornerRadius = 2;
        
        _mainView.layer.masksToBounds = YES;
        
        _mainView.backgroundColor = UIColorFromRGB(0xffffff);
        
        [self.contentView addSubview:_mainView];
        
        UIButton *greenView = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), Height320(9.3), Width320(2.7), Height320(13.3))];
        
        greenView.backgroundColor = kMainColor;
        
        [_mainView addSubview:greenView];
        
        _cardNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(greenView.right+Width320(6.67), Height320(7.5), Width320(200), Height320(17.3))];
        
        _cardNameLabel.textColor = kMainColor;
        
        _cardNameLabel.font = AllFont(14);
        
        [_mainView addSubview:_cardNameLabel];
        
        _remainLabel = [[UILabel alloc]initWithFrame:CGRectMake(_mainView.width-Width320(100), _cardNameLabel.top, Width320(84), _cardNameLabel.height)];
        
        _remainLabel.textColor = UIColorFromRGB(0xEDA640);
        
        _remainLabel.textAlignment = NSTextAlignmentRight;
        
        _remainLabel.font = AllFont(12);
        
        [_mainView addSubview:_remainLabel];
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(7.1), _cardNameLabel.bottom+Height320(7.1), _mainView.width-Width320(14.2), 1)];
        
        sep.backgroundColor = UIColorFromRGB(0xeeeeee);
        
        [_mainView addSubview:sep];
        
        UILabel *gymTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16.8), sep.bottom+Height320(10.2), Width320(60), Height320(13.7))];
        
        gymTitleLabel.text = @"卡号：";
        
        gymTitleLabel.textColor = UIColorFromRGB(0x999999);
        
        gymTitleLabel.font = AllFont(12);
        
        [gymTitleLabel autoWidth];
        
        [_mainView addSubview:gymTitleLabel];
        
        _gymNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(gymTitleLabel.right, gymTitleLabel.top, _mainView.width-Width320(35)-gymTitleLabel.right, gymTitleLabel.height)];
        
        _gymNameLabel.textColor = UIColorFromRGB(0x222222);
        
        _gymNameLabel.font = gymTitleLabel.font;
        
        [_mainView addSubview:_gymNameLabel];
        
        UILabel *usersTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(gymTitleLabel.left, gymTitleLabel.bottom+Height320(8), gymTitleLabel.width, gymTitleLabel.height)];
        
        usersTitleLabel.text = @"绑定会员：";
        
        usersTitleLabel.textColor = gymTitleLabel.textColor;
        
        usersTitleLabel.font = gymTitleLabel.font;
        
        [usersTitleLabel autoWidth];
        
        [_mainView addSubview:usersTitleLabel];
        
        _userLabel = [[UILabel alloc]initWithFrame:CGRectMake(usersTitleLabel.right, usersTitleLabel.top, _gymNameLabel.width, usersTitleLabel.height)];
        
        _userLabel.textColor = _gymNameLabel.textColor;
        
        _userLabel.font = _gymNameLabel.font;
        
        [_mainView addSubview:_userLabel];
        
        _timeTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(usersTitleLabel.left, _userLabel.bottom+Height320(8), gymTitleLabel.width, gymTitleLabel.height)];
        
        _timeTitleLabel.text = @"使用期限： ";
        
        _timeTitleLabel.textColor = gymTitleLabel.textColor;
        
        _timeTitleLabel.font = gymTitleLabel.font;
        
        [_timeTitleLabel autoWidth];
        
        [_mainView addSubview:_timeTitleLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_userLabel.left, _timeTitleLabel.top, _userLabel.width, _timeTitleLabel.height)];
        
        _timeLabel.textColor = _userLabel.textColor;
        
        _timeLabel.font = _userLabel.font;
        
        [_mainView addSubview:_timeLabel];
        
        _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(_mainView.right-Width320(23.6), 0, Width320(6.7), Height320(10.7))];
        
        _arrowImg.image = [UIImage imageNamed:@"cellarrow"];
        
        [_mainView addSubview:_arrowImg];
        
    }
    
    return self;
    
}

-(void)setCard:(Card *)card
{
    
    _card = card;
    
    _cardNameLabel.text = _card.cardName;
    
    _remainLabel.text = _card.cardKind.type == CardTypeCount?[NSString stringWithFormat:@"余额：%@次",_card.remainTimes]:[NSString stringWithFormat:@"余额：%ld元",(long)_card.remain];
    
    _remainLabel.hidden = _card.cardKind.type == CardTypeTime;
    
    _gymNameLabel.text = [NSString stringWithFormat:@"%ld",(long)_card.cardId];
    
    NSString *userStr = @"";
    
    for (NSString *stu in _card.students) {
        
        userStr = [userStr stringByAppendingString:[NSString stringWithFormat:@"%@，",stu]];
        
    }
    
    if ([userStr hasSuffix:@"，"]) {
        
        userStr = [userStr substringToIndex:userStr.length-1];
        
    }
    
    _userLabel.text = userStr;
    
    [_userLabel autoHeight];
    
    [_timeTitleLabel changeTop:_userLabel.bottom+Height320(8)];
    
    [_timeLabel changeTop:_timeTitleLabel.top];
    
    _timeTitleLabel.text = _card.cardKind.type == CardTypeTime?@"有  效  期：":@"使用期限： ";
    
    _timeLabel.text = [NSString stringWithFormat:@"%@至%@",_card.cardKind.type == CardTypeTime?_card.start:_card.validFrom,_card.cardKind.type == CardTypeTime?_card.end:_card.validTo];
    
    if (!_card.checkValid && _card.cardKind.type != CardTypeTime) {
        
        _timeLabel.text = @"无限制";
        
    }
    
    [_mainView changeHeight:_timeLabel.bottom+Height320(14.2)];
    
    [_arrowImg changeTop:_mainView.height/2-_arrowImg.height/2];

}

-(CGFloat)getHeight
{
    
    return _mainView.bottom+Height320(4.4);
    
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
    if (highlighted) {
        
        self.backgroundColor = UIColorFromRGB(0xeeeeee);
        
    }else
    {
        
        self.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
    }
    
}

@end
