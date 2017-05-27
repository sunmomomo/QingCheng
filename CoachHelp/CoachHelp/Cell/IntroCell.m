//
//  IntroCell.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/24.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "IntroCell.h"

@interface IntroCell ()

@property(nonatomic,strong)UIView *mainView;

@property(nonatomic,strong)UIButton *deleteBtn;

@property(nonatomic,strong)UIButton *upBtn;

@property(nonatomic,strong)UIButton *downBtn;

@property(nonatomic,strong)UILabel *contentLabel;

@property(nonatomic,strong)UIImageView *imgView;

@property(nonatomic,assign)IntroStyle style;

@end

@implementation IntroCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(CGFloat)heightForCell
{
    
    return self.mainView.bottom+Height320(5);
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        self.mainView = [[UIView alloc]initWithFrame:CGRectMake(Width320(14), Height320(11.5), MSW-Width320(28), Height320(200))];
        
        self.mainView.layer.borderColor = UIColorFromRGB(0xe4e4e4).CGColor;
        
        self.mainView.layer.borderWidth = 1;
        
        self.mainView.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
        
        self.mainView.layer.shadowOffset = CGSizeMake(0, 2);
        
        self.mainView.layer.shadowOpacity = 0.04;
        
        [self.contentView addSubview:self.mainView];
        
        self.mainView.backgroundColor = UIColorFromRGB(0xffffff);
        
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _mainView.width, Height320(166))];
        
        self.imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.mainView addSubview:self.imgView];
        
        self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12.5), Height320(12.5), self.mainView.width-Width320(25), Height320(200))];
        
        self.contentLabel.textColor = UIColorFromRGB(0x222222);
        
        self.contentLabel.font = AllFont(12);
        
        [self.mainView addSubview:self.contentLabel];
        
        self.downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.downBtn.frame = CGRectMake(self.mainView.right-Width320(60), self.deleteBtn.top, Width320(30), Height320(15));
        
        self.downBtn.titleLabel.font = AllFont(12);
        
        [self.downBtn setTitle:@"下移" forState:UIControlStateNormal];
        
        [self.downBtn setTitleColor:kMainColor forState:UIControlStateNormal];
        
        [self.downBtn setTitleColor:[kMainColor colorWithAlphaComponent:0.3] forState:UIControlStateDisabled];
        
        [self.mainView addSubview:self.downBtn];
        
        self.upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.upBtn.frame = CGRectMake(self.downBtn.left-Width320(54), self.downBtn.top, self.downBtn.width, self.downBtn.height);
        
        self.upBtn.titleLabel.font = AllFont(12);
        
        [self.upBtn setTitle:@"上移" forState:UIControlStateNormal];
        
        [self.upBtn setTitleColor:kMainColor forState:UIControlStateNormal];
        
        [self.upBtn setTitleColor:[kMainColor colorWithAlphaComponent:0.3] forState:UIControlStateDisabled];
        
        [self.mainView addSubview:self.upBtn];
        
        [self.upBtn addTarget:self action:@selector(up:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.downBtn addTarget:self action:@selector(down:) forControlEvents:UIControlEventTouchUpInside];
        
        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.deleteBtn.frame = CGRectMake(self.upBtn.left-Width320(54), self.downBtn.top,self.downBtn.width, self.downBtn.height);
        
        self.deleteBtn.titleLabel.font = AllFont(12);
        
        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        
        [self.deleteBtn setTitleColor:UIColorFromRGB(0xE29415) forState:UIControlStateNormal];
        
        [self.deleteBtn addTarget:self action:@selector(remove:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.mainView addSubview:self.deleteBtn];

    }
    
    return self;
    
}

-(void)setContent:(NSString *)content andStyle:(IntroStyle)style
{
    
    _style = style;
    
    if (style == contentStyleImg) {
        
        _imgView.hidden = NO;
        
        _contentLabel.hidden = YES;
        
        if (content) {
            
            if ([content rangeOfString:@"!"].length) {
                
                [_imgView sd_setImageWithURL:[NSURL URLWithString:content]];
                
            }else{
                
                if ([content rangeOfString:@"!/watermark/"].length) {
                    
                    [_imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@!small/watermark/%@",[[content componentsSeparatedByString:@"!/watermark/"]firstObject],[[content componentsSeparatedByString:@"!/watermark/"]lastObject]]]];
                    
                }else if ([content rangeOfString:@"/watermark/"].length){
                    
                    [_imgView sd_setImageWithURL:[NSURL URLWithString:content]];
                    
                }else{
                    
                    [_imgView sd_setImageWithURL:[NSURL URLWithString:[content stringByAppendingString:@"!small"]]];
                    
                }
                
            }
            
        }
        
        [_deleteBtn changeTop:_imgView.bottom+Height320(10)];
        
        [_upBtn changeTop:_imgView.bottom+Height320(10)];
        
        [_downBtn changeTop:_imgView.bottom+Height320(10)];
        
        [_mainView changeHeight:_deleteBtn.bottom+Height320(14)];
        
    }else
    {
        
        _imgView.hidden = YES;
        
        _contentLabel.hidden = NO;
        
        _contentLabel.text = content;
        
        [_contentLabel autoHeight];
        
        [_deleteBtn changeTop:_contentLabel.bottom+Height320(11.5)];
        
        [_upBtn changeTop:_contentLabel.bottom+Height320(11.5)];
        
        [_downBtn changeTop:_contentLabel.bottom+Height320(11.5)];
        
        [_mainView changeHeight:_deleteBtn.bottom+Height320(14)];
        
    }
    
}

-(void)setTag:(NSInteger)tag
{
    
    [super setTag:tag];
    
    self.upBtn.tag = tag;
    
    self.downBtn.tag = tag;
    
    self.deleteBtn.tag = tag;
    
}

-(void)setMovemode:(Movemode )movemode
{
    
    if (movemode == moveNoDown) {
        
        _downBtn.enabled = NO;
        
        _upBtn.enabled = YES;
        
    }else if (movemode == moveNoUp)
    {
        _downBtn.enabled = YES;
        
        _upBtn.enabled = NO;
        
    }else if(movemode == moveAll)
    {
        
        _downBtn.enabled = YES;
        
        _upBtn.enabled = YES;
        
    }else
    {
        
        _downBtn.enabled = NO;
        
        _upBtn.enabled = NO;
        
    }
    
}

-(void)up:(UIButton*)btn
{
    
    [self.delegate up:btn];
    
}

-(void)down:(UIButton*)btn
{
    
    [self.delegate down:btn];
    
}

-(void)remove:(UIButton*)btn
{
    
    [self.delegate remove:btn];
    
}



@end
