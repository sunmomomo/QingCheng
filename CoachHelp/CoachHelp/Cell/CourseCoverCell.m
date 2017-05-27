//
//  CourseCoverCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseCoverCell.h"

@interface CourseCoverCell ()

{
    
    UIImageView *_imageView;
    
    UIButton *_deleteButton;
    
}

@end

@implementation CourseCoverCell

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
        
        _deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(12), Height320(32), Width320(16), Height320(16))];
        
        [_deleteButton setImage:[UIImage imageNamed:@"cell_delete"] forState:UIControlStateNormal];
        
        [_deleteButton addTarget:self action:@selector(coverDelete:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_deleteButton];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(40), 0, Width320(80), Height320(80))];
        
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        _imageView.layer.masksToBounds = YES;
        
        [self addSubview:_imageView];
        
        UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(_imageView.right, 0, MSW-_imageView.right-Width320(12), _imageView.height)];
        
        whiteView.backgroundColor = UIColorFromRGB(0xffffff);
        
        [self addSubview:whiteView];
        
    }
    
    return self;
    
}

-(void)coverDelete:(UIButton*)button
{
    
    [self.delegate deleteClickOfCourseCoverCell:self];
    
}

-(void)setImageURL:(NSURL *)imageURL
{
    
    _imageURL = imageURL;
    
    [_imageView sd_setImageWithURL:_imageURL];
    
}

-(void)willTransitionToState:(UITableViewCellStateMask)state{
    [super willTransitionToState:state];
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    for (UIView *view in self.subviews) {
        
        if ([NSStringFromClass([view class]) isEqualToString:@"UITableViewCellReorderControl"]) {
            
            view.frame = CGRectMake(MSW-Width320(48), Height320(35), Width320(20), Height320(10));
            
        }
        
    }
    
}

@end
