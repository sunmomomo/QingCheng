//
//  ProgrammeGymCell.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 2016/11/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ProgrammeGymCell.h"

@interface ProgrammeGymCell()

{
    
    UILabel *_titleLabel;
    
    UIImageView *_iconView;
    
    UIImageView *_verifyImgView;
    
}

@end

@implementation ProgrammeGymCell

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
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(13), Height320(14), Width320(27), Height320(27))];
        
        _iconView.layer.cornerRadius = _iconView.width/2;
        
        _iconView.layer.masksToBounds = YES;
        
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:_iconView];
        
        _verifyImgView = [[UIImageView alloc]initWithFrame:CGRectMake(_iconView.right-Width320(10), _iconView.bottom-Height320(10), Width320(10), Height320(10))];
        
        _verifyImgView.layer.cornerRadius = _verifyImgView.width/2;
        
        _verifyImgView.layer.masksToBounds = YES;
        
        _verifyImgView.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
        
        _verifyImgView.layer.borderWidth = OnePX;
        
        _verifyImgView.image = [UIImage imageNamed:@"ic_qc_identify"];
        
        [self.contentView addSubview:_verifyImgView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconView.right+Width320(6), 0, Width320(170), Height320(55))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(14);
        
        [self.contentView addSubview:_titleLabel];
        
        UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(242)-Width320(23), Height320(22), Width320(7), Height320(12))];
        
        arrow.image = [UIImage imageNamed:@"cellarrow"];
        
        [self.contentView addSubview:arrow];
        
    }
    
    return self;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
}

-(void)setImgURL:(NSURL *)imgURL
{
    
    _imgURL = imgURL;
    
    [_iconView sd_setImageWithURL:_imgURL];
    
}

-(void)setHavePermission:(BOOL)havePermission
{
    
    _havePermission = havePermission;
    
    _titleLabel.textColor = _havePermission?UIColorFromRGB(0x333333):UIColorFromRGB(0xcccccc);
    
    _iconView.alpha = _havePermission?1:0.4;
    
}

@end
