//
//  MinePhotoCell.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 2017/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "MinePhotoCell.h"

@interface MinePhotoCell ()

{
    
    UIImageView *_imgView;
    
    UIImageView *_chooseImg;
    
}

@end

@implementation MinePhotoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        [self addSubview:_imgView];
        
        _chooseImg = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-Width320(22), Height320(4), Width320(18), Height320(18))];
        
        _chooseImg.layer.cornerRadius = _chooseImg.width/2;
        
        _chooseImg.backgroundColor = UIColorFromRGB(0xffffff);
        
        _chooseImg.layer.masksToBounds = YES;
        
        [self addSubview:_chooseImg];
        
        _chooseImg.hidden = YES;
        
    }
    
    return self;
    
}

-(void)setImgURL:(NSURL *)imgURL
{
    
    _imgURL = imgURL;
    
    [_imgView sd_setImageWithURL:_imgURL];
    
}

-(void)setEditing:(BOOL)editing
{
    
    _editing = editing;
    
    _chooseImg.hidden = !_editing;
    
}

-(void)setChoosed:(BOOL)choosed
{
    
    _choosed = choosed;
    
    if (_choosed) {
        
        _chooseImg.layer.borderColor = [UIColor clearColor].CGColor;
        
        _chooseImg.layer.borderWidth = 0;
        
        _chooseImg.image = [UIImage imageNamed:@"selected"];
        
    }else{
        
        _chooseImg.layer.borderColor = UIColorFromRGB(0xC8C8C8).CGColor;
        
        _chooseImg.layer.borderWidth = OnePX;
        
        _chooseImg.image = nil;
        
    }
    
}

@end
