//
//  YFStuDetaiRecoHeaderView.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/24.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFStuDetaiRecoHeaderView.h"

#import "YFThreeLabel.h"

@implementation YFStuDetaiRecoHeaderView
{
    CGFloat _width;
    CGFloat _height;
    CGFloat _yy;
    CGFloat _gap;
    CGFloat _xxFirst;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _yy = Width320(37);
        
        _width = Width320(45);
        _height = Width320(55);
        
        _xxFirst = Width320(25);
        
        _gap = (MSW - _xxFirst * 2 - _width * 4) / 3.0;
        
        [self addSubview:self.outView];
        [self addSubview:self.attandanceView];
        [self addSubview:self.groupView];
        [self addSubview:self.privateView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(Width320(12), Height320(12), Width320(100), Height320(20))];
        label.text = @"累计出勤";
        label.textColor = RGB_YF(204, 204, 204);
        label.font = FontSizeFY(Width320(12));
        [self addSubview:label];
    
        [self addSubview:self.button];
    }
    return self;
}

- (YFThreeLabel *)outView
{
    if (_outView == nil) {
        _outView = [[YFThreeLabel alloc] initWithFrame:CGRectMake(_xxFirst, _yy, _width, _height)];
        _outView.desDownLabel.text = @"出勤";
        _outView.rightTopLabel.text = @"天";
        [self setThreeLabelStyle:_outView];
        [_outView setBottomLineViewWithColor:RGB_YF(249, 148, 78)];
    }
    return _outView;
}

- (YFThreeLabel *)attandanceView
{
    if (_attandanceView == nil) {
        _attandanceView = [[YFThreeLabel alloc] initWithFrame:CGRectMake(_outView.right + _gap, _yy, _width, _height)];
        _attandanceView.desDownLabel.text = @"签到";
        _attandanceView.rightTopLabel.text = @"次";
        [self setThreeLabelStyle:_attandanceView];
        [_attandanceView setBottomLineViewWithColor:RGB_YF(140, 181, 186)];
    }
    return _attandanceView;
}

- (YFThreeLabel *)groupView
{
    if (_groupView == nil) {
        _groupView = [[YFThreeLabel alloc] initWithFrame:CGRectMake(_attandanceView.right + _gap, _yy, _width, _height)];
        _groupView.desDownLabel.text = @"团课";
        _groupView.rightTopLabel.text = @"节";
        [self setThreeLabelStyle:_groupView];
        [_groupView setBottomLineViewWithColor:RGB_YF(28, 165, 230)];
    }
    return _groupView;
}

- (YFThreeLabel *)privateView
{
    if (_privateView == nil) {
        _privateView = [[YFThreeLabel alloc] initWithFrame:CGRectMake(_groupView.right + _gap, _yy, _width, _height)];
        _privateView.desDownLabel.text = @"私教";
        _privateView.rightTopLabel.text = @"节";
        [self setThreeLabelStyle:_privateView];
        [_privateView setBottomLineViewWithColor:RGB_YF(121, 134, 204)];
    }
    return _privateView;
}


- (void)setThreeLabelStyle:(YFThreeLabel *)view
{
    [view setStudenetDetaiStyle];
    [view setBigTextColor];
    view.offsetRightTop = Width320(8);

}


- (YFButton *)button
{
    if (!_button) {
        
        CGFloat buttonWidth = XFrom5YF(180);
        CGFloat cellHeith = 46;
        
        CGFloat   imageWidth = XFrom5To6YF(7);
        CGFloat   labelWidth = buttonWidth - imageWidth - 4;
        CGFloat   labelHeight = cellHeith;
        
        CGFloat   imageHeight = XFrom5To6YF(4);
        
        CGFloat    labelx = 0;
        CGFloat   labely = 0;
        
        CGFloat   imagex = buttonWidth - imageWidth;
        CGFloat   imagey = (cellHeith - imageHeight)/ 2.0;
        
        YFButton *button = [[YFButton alloc] initWithFrame:CGRectMake(MSW - buttonWidth - 18.0, 0, buttonWidth, cellHeith) imageFrame:CGRectMake(imagex, imagey, imageWidth, imageHeight) titleFrame:CGRectMake(labelx, labely, labelWidth, labelHeight)];
        button.titleLabel.textAlignment = NSTextAlignmentRight;
//        [button setTitle:@"全部场馆" forState:UIControlStateNormal];
        [button setTitle:@"全部场馆" forState:UIControlStateNormal];

        [button setImage:[UIImage imageNamed:@"buttonSelectedDown"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"buttonSelectedUp"] forState:UIControlStateSelected];
        
        
        [button.titleLabel setFont:FontSizeFY(XFrom5YF(12.0))];
        button.titleLabel.textAlignment = NSTextAlignmentRight;
        [button setTitleColor:RGB_YF(13, 177, 75) forState:UIControlStateNormal];
        
        _button = button;
    }
    return _button;
}

@end
