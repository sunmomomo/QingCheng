//
//  YFAddTagCViewCell.m
//  YFTagView
//
//  Created by FYWCQ on 17/3/20.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

#import "YFAddTagCViewCell.h"

@implementation YFAddTagCViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.addImageView];
        self.clipsToBounds = YES;
    }
    return self;
}

- (UIImageView *)addImageView
{
    if (!_addImageView)
    {
        _addImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 22.0, self.frame.size.height / 2.0 - 11, 22, 22)];
        _addImageView.image = [UIImage imageNamed:@"AddSmsPeo"];
    }
    return _addImageView;
}

//- (UILabel *)nameLabel
//{
//    if (!_nameLabel)
//    {
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.addImageView.frame.origin.x - 4, self.frame.size.height)];
//        
//        label.font = [UIFont systemFontOfSize:13.0];
//        
//        label.textColor = RGB_YF(106, 127, 164);
//        
//        _nameLabel = label;
//    }
//    return _nameLabel;
//}

@end
