//
//  MainSecCell.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/16.
//  Copyright (c) 2015年 馍馍帝👿. All rights reserved.
//

#import "MainSecCell.h"

#define kWidth Width320(270)

@interface  MainSecCell ()

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *subtitleLabel;

@end

@implementation MainSecCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = UIColorFromRGB(0xf8f8f8);
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(24), 0, Width320(200), Height320(41))];
        
        self.titleLabel.font = AllFont(14);
        
        [self.contentView addSubview:self.titleLabel];
        
        self.subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWidth-Width320(100.5), 0, Width320(70), self.titleLabel.height)];
        
        self.subtitleLabel.font = HNFont(IPhone4_5_6_6P(12, 12, 13, 14));
        
        self.subtitleLabel.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:self.subtitleLabel];
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth-Width320(22.7), Height320(25.7), Width320(6.7), Height320(10.7))];
        
        imgView.image = [UIImage imageNamed:@"cellarrow"];
        
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        imgView.center = CGPointMake(imgView.center.x, Height320(22));
        
        [self.contentView addSubview:imgView];
        
    }
    
    return self;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    self.titleLabel.text = _title;
    
    self.titleLabel.textColor = UIColorFromRGB(0x222222);
    
}

-(void)setNum:(NSInteger)num
{
    
    _num = num;
    
    self.subtitleLabel.text = [NSString stringWithFormat:@"%ld",(long)_num];
    
    self.subtitleLabel.textColor = UIColorFromRGB(0x000000);
    
}

-(void)selected
{
    
    self.titleLabel.textColor = kMainColor;
    
    self.subtitleLabel.textColor = kMainColor;
    
}

@end
