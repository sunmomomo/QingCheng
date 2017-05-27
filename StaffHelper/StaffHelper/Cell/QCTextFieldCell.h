//
//  QCTextFieldCell.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/2.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "QCTextField.h"

@protocol QCTextFieldCellDelegate;

@interface QCTextFieldCell : UITableViewCell

@property(nonatomic,strong)QCTextField *textField;

@property(nonatomic,strong)NSIndexPath *indexPath;

@property(nonatomic,assign)UIKeyboardType keyboardType;

@property(nonatomic,assign)id<QCTextFieldCellDelegate> delegate;

@end

@protocol QCTextFieldCellDelegate <UITextFieldDelegate>

-(void)cell:(QCTextFieldCell*)cell textFieldDidChanged:(NSString *)string;

@end
