//
//  TestPictureView.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/12/4.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "TestPictureView.h"

@interface MOProgressView : UIView

{
    
    UIView *_progressView;
    
}

@property(nonatomic,strong)UIColor *tintColor;

@property(nonatomic,strong)UIColor *trackColor;

@property(nonatomic,assign)CGFloat progress;

@end

@implementation MOProgressView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.layer.cornerRadius = frame.size.height/2;

        self.layer.masksToBounds = YES;

        self.layer.borderWidth = 1;
        
        self.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
        
        _progressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, frame.size.height)];
        
        [self addSubview:_progressView];
        
    }
    
    return self;
    
}

-(void)setProgress:(CGFloat)progress
{
    
    _progress = progress;
    
    [_progressView changeWidth:self.width*_progress];
    
}

-(void)setTintColor:(UIColor *)tintColor
{
    
    _tintColor = tintColor;
    
    _progressView.backgroundColor = _tintColor;
    
}

-(void)setTrackColor:(UIColor *)trackColor
{
    
    _trackColor = trackColor;
    
    self.backgroundColor = _trackColor;
    
}

@end

@interface TestPictureView ()

@property(nonatomic,strong)UIImageView *imgView;

@property(nonatomic,strong)MOProgressView  *progressView;

@property(nonatomic,strong)UIButton *deleteButton;

@end

@implementation TestPictureView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = UIColorFromRGB(0xe6e6e6);
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_imgView];
        
        _progressView = [[MOProgressView alloc]initWithFrame:CGRectMake(0, 0, Width320(69.3), Height320(7.1))];
        
        _progressView.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        
        _progressView.trackColor = [UIColor clearColor];
        
        _progressView.tintColor = kMainColor;
        
        _progressView.hidden = YES;
        
        [self addSubview:_progressView];
        
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _deleteButton.frame = CGRectMake(frame.size.width-Width320(20.4), Height320(4.4), Width320(16), Height320(16));
        
        _deleteButton.layer.cornerRadius = _deleteButton.width/2;
        
        _deleteButton.layer.masksToBounds = YES;
        
        [_deleteButton setImage:[UIImage imageNamed:@"btn_delete"] forState:UIControlStateNormal];
        
         [_deleteButton setImage:[UIImage imageNamed:@"btn_delete"] forState:UIControlStateHighlighted];
        
        [_deleteButton addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _deleteButton.hidden = YES;
        
        [self addSubview:_deleteButton];
        
        [self addTarget:self.delegate action:@selector(pictureViewClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
    
}

-(void)setTag:(NSInteger)tag
{
    
    [super setTag:tag];
    
    _deleteButton.tag = tag;
    
}

-(void)deleteClick:(UIButton*)btn
{
    
    if ([self.delegate respondsToSelector:@selector(deleteClick:)]) {
        
        [self.delegate deleteClick:btn];
        
    }
    
}

-(void)setImgUrl:(NSURL *)imgUrl
{
    
    _imgUrl = imgUrl;
    
    self.imgView.hidden = NO;
    
    __weak typeof(self)weakS = self;
    
    if (self.progressView.hidden) {
        
        [_imgView sd_setImageWithURL:_imgUrl completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            weakS.progressView.hidden = YES;
            
        }];
        
    }
    
}

-(void)setImage:(UIImage *)image
{
    
    _image = image;
    
    _imgView.image = _image;
    
    _imgView.hidden = NO;

    _progressView.hidden = YES;
    
}

-(void)setCanDelete:(BOOL)canDelete
{
    
    _canDelete = canDelete;
    
    _deleteButton.hidden = !_canDelete;
    
}

-(void)setProgress:(CGFloat)progress
{
    
    _progress = progress;
    
    _progressView.progress = _progress;
    
    _progressView.hidden = NO;

}


@end
