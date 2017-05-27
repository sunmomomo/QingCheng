//
//  ChestAreaListCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChestAreaListCell.h"

@interface ChestAreaListCell ()

{
    
    UILabel *_addLabel;
    
    UILabel *_nameLabel;
    
    UIImageView *_editImg;
    
}

@end

@implementation ChestAreaListCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        self.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        self.layer.borderWidth = OnePX;
        
        self.layer.cornerRadius = Width320(2);
        
        self.layer.masksToBounds = YES;
        
        _addLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        _addLabel.text = @"+  添加新区域";
        
        _addLabel.textColor = kMainColor;
        
        _addLabel.textAlignment = NSTextAlignmentCenter;
        
        _addLabel.font = AllFont(13);
        
        [self addSubview:_addLabel];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(22), Height320(7), Width320(92), Height320(40))];
        
        _nameLabel.textColor = UIColorFromRGB(0x333333);
        
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        
        _nameLabel.numberOfLines = 2;
        
        _nameLabel.font = AllFont(13);
        
        [self addSubview:_nameLabel];
        
        _editImg = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-Width320(20), Height320(6), Width320(12), Height320(12))];
        
        _editImg.image = [UIImage imageNamed:@"chest_area_edit"];
        
        [self addSubview:_editImg];
        
    }
    return self;
}

-(void)setIsAdd:(BOOL)isAdd
{
    
    _isAdd = isAdd;
    
    _addLabel.hidden = !_isAdd;
    
    _nameLabel.hidden = _editImg.hidden = _isAdd;
    
}

-(void)setName:(NSString *)name
{
    
    _name = name;
    
    _nameLabel.text = _name;
    
}

@end
