//
//  MainTitleCell.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/16.
//  Copyright (c) 2015年 馍馍帝👿. All rights reserved.
//

#import "MainTopCell.h"

@interface MainTopCell ()

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UIImageView *imgView;

@end

@implementation MainTopCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = UIColorFromRGB(0xf8f8f8);
        
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(23), Height320(19.5), Width320(18), Height320(18))];
        
        self.imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:self.imgView];
        
        self.imgView.center = CGPointMake(self.imgView.center.x, Height320(23));
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.imgView.right+Width320(21), 0, Width320(200), Height320(49))];
                
        self.titleLabel.font = AllFont(14);
        
        [self.contentView addSubview:self.titleLabel];
        
        self.titleLabel.center = CGPointMake(self.titleLabel.center.x, Height320(23));
        
    }
    
    return self;
    
}

-(void)setTitle:(NSString *)title
{
    
    self.titleLabel.text = title;
    
    self.titleLabel.textColor = UIColorFromRGB(0x222222);
    
}

-(void)setImg:(NSString *)img
{
    
    _img = img;
    
    self.imgView.image = [UIImage imageNamed:img];
    
}

-(void)selected
{
    
    self.imgView.image = [UIImage imageNamed:_selectedImg];
    
    self.titleLabel.textColor = kMainColor;
    
}

-(void)setImgUrl:(NSURL *)imgUrl
{
    
    [self.imgView sd_setImageWithURL:imgUrl];
    
}


@end
