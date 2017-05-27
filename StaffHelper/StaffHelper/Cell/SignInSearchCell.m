//
//  SignInSearchCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/8.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "SignInSearchCell.h"

@interface SignInSearchCell ()

{
    
    UIImageView *_imgView;
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
}

@end

@implementation SignInSearchCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(12), Height320(12), Width320(28), Height320(28))];
        
        _imgView.layer.borderWidth = 1;
        
        _imgView.layer.borderColor = UIColorFromRGB(0x333333).CGColor;
        
        _imgView.layer.cornerRadius = _imgView.width/2;
        
        _imgView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_imgView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right+Width320(8), 0, Width320(150), Height320(53))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(12);
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width320(115), 0, Width320(103), Height320(53))];
        
        _subtitleLabel.textColor = UIColorFromRGB(0x999999);
        
        _subtitleLabel.textAlignment = NSTextAlignmentRight;
        
        _subtitleLabel.font = AllFont(12);
        
        [self.contentView addSubview:_subtitleLabel];
        
        self.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        self.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
    }
    
    return self;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
}

-(void)setSubtitle:(NSString *)subtitle
{
    
    _subtitle = subtitle;
    
    _subtitleLabel.text = _subtitle;
    
}

-(void)setIconURL:(NSURL *)iconURL
{
    
    _iconURL = iconURL;
    
    [_imgView sd_setImageWithURL:_iconURL];
    
}

-(void)setPredicate:(NSString *)predicate
{
    
    _predicate = predicate;
    
    if (_predicate.length) {
        
        NSRange  titleRange = [_title rangeOfString:_predicate];
        
        if (titleRange.length) {
            
            NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc]initWithString:_title];
            
            [titleStr addAttribute:NSForegroundColorAttributeName value:kMainColor range:titleRange];
            
            _titleLabel.attributedText = titleStr;
            
        }else
        {
            
            _titleLabel.text = _title;
            
        }
        
        NSRange subtitleRange = [_subtitle rangeOfString:_predicate];
        
        if (subtitleRange.length) {
            
            NSMutableAttributedString *subtitleStr = [[NSMutableAttributedString alloc]initWithString:_subtitle];
            
            [subtitleStr addAttribute:NSForegroundColorAttributeName value:kMainColor range:subtitleRange];
            
            _subtitleLabel.attributedText = subtitleStr;
            
        }else
        {
            
            _subtitleLabel.text = _subtitle;
            
        }
        
    }else
    {
        
        _titleLabel.text = _title;
        
        _subtitleLabel.text = _subtitle;
        
    }
    
}

@end
