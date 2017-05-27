//
//  QCTextFieldCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/2.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "QCTextFieldCell.h"

@implementation QCTextFieldCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        self.textField = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
        
        self.textField.backgroundColor = UIColorFromRGB(0xffffff);
        
        self.textField.placeholderColor = UIColorFromRGB(0x666666);
        
        [self.contentView addSubview:self.textField];
        
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
        
        [self.textField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
        
    }
    
    return self;
    
}

-(void)setDelegate:(id<QCTextFieldCellDelegate>)delegate
{
    
    _delegate = delegate;
    
    self.textField.delegate = _delegate;
    
}

-(void)textFieldDidChanged:(UITextField*)textField
{
    
    if ([self.delegate respondsToSelector:@selector(cell:textFieldDidChanged:)]) {
        
        [self.delegate cell:self textFieldDidChanged:textField.text];
        
    }
    
}

-(BOOL)becomeFirstResponder
{
    
    [self.contentView bringSubviewToFront:self.textField];
    
    [self.textField becomeFirstResponder];
    
    return NO;
    
}

-(void)setKeyboardType:(UIKeyboardType)keyboardType
{
    
    _keyboardType = keyboardType;
    
    self.textField.keyboardType = _keyboardType;
    
}
    

@end
