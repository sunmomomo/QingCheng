//
//  YFSmsRecipentCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSmsRecipentCell.h"

#import "YFBaseRefreshTBVC.h"

@interface YFSmsRecipentCell ()

@property(nonatomic, strong)NSMutableArray *labelsArray;

@end

@implementation YFSmsRecipentCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.nameDesLabel];
        [self.contentView addSubview:self.nameAllLabel];
        [self.contentView addSubview:self.showDetaiButton];
    }
    return self;
}



- (UILabel *)nameDesLabel
{
    if (_nameDesLabel == nil)
    {
        _nameDesLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15.0, 60, 20)];
        _nameDesLabel.textColor = RGB_YF(187, 187, 187);
        _nameDesLabel.font = FontSizeFY(15.0);
        _nameDesLabel.text  =@"收件人:";
    }
    return _nameDesLabel;
}


- (UIButton *)showDetaiButton
{
    if (_showDetaiButton == nil) {
        _showDetaiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _showDetaiButton.frame = CGRectMake(MSW - 52, 0, 47, 50);
        [_showDetaiButton setTitleColor:YFSelectedButtonColor forState:UIControlStateNormal];
        [_showDetaiButton setTitle:@"详情" forState:UIControlStateNormal];
        [_showDetaiButton.titleLabel setFont:FontSizeFY(13)];
//        [_showDetaiButton addTarget:self action:@selector(showDetailAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showDetaiButton;
}

- (UILabel *)nameAllLabel
{
    if (_nameAllLabel == nil)
    {
        _nameAllLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameDesLabel.right + 2, 15.0, MSW - self.nameDesLabel.right - 15.0 - self.showDetaiButton.width, 20)];
        _nameAllLabel.textColor = YFCellTitleColor;
        _nameAllLabel.font = FontSizeFY(15.0);
    }
    return _nameAllLabel;
}

- (void)showDetailAction:(UIButton *)sender
{
    if (sender.selected == NO)
    {// 显示
        [sender setSelected:YES];

        self.nameAllLabel.hidden = YES;
        
        for (UILabel *label in self.labelsArray)
        {
            label.hidden = NO;
        }
        
        UILabel *label = self.labelsArray.lastObject;
        
        self.baseModel.cellHeight = label.bottom + 10;
    }
    else
    {// 隐藏
        sender.selected = NO;
        self.nameAllLabel.hidden = NO;
        
        for (UILabel *label in self.labelsArray)
        {
            label.hidden = YES;
        }
        self.baseModel.cellHeight = 50.0;

    }

    [((YFBaseRefreshTBVC *)self.currentVC).baseTableView reloadData];

//    [((YFBaseRefreshTBVC *)self.currentVC).baseTableView reloadSections:[NSIndexSet indexSetWithIndex:self.indexPath.section] withRowAnimation:UITableViewRowAnimationNone];

    
//    [((YFBaseRefreshTBVC *)self.currentVC).baseTableView beginUpdates];
//    [((YFBaseRefreshTBVC *)self.currentVC).baseTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.indexPath.row inSection:self.indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
//    [((YFBaseRefreshTBVC *)self.currentVC).baseTableView endUpdates];
}

- (NSMutableArray *)labelsArray
{
    if (_labelsArray == nil) {
        _labelsArray = [NSMutableArray array];
        
        UILabel *lastLabel = self.nameAllLabel;
        
        CGFloat nextTop = self.nameAllLabel.top;
        
        for (NSMutableAttributedString *string in self.nameAtriStringArray)
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(lastLabel.mj_x, nextTop, lastLabel.width, lastLabel.height)];
            
            label.attributedText = string;
            
            label.hidden = YES;
            
            lastLabel = label;
            
            [self.contentView addSubview:label];
            [_labelsArray addObject:label];
            nextTop = lastLabel.bottom + 5.0;
        }
        
        
        self.showHeight = lastLabel.bottom + 10.0;
    }
    return _labelsArray;
}

- (void)setSubStyle
{
    self.nameDesLabel.hidden = YES;
    self.showDetaiButton.hidden = YES;
    
    [self.nameAllLabel changeTop:0];
}

@end
