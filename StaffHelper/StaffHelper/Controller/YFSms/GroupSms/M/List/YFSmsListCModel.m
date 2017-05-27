//
//  YFSmsListCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSmsListCModel.h"

#import "YFSmsListCell.h"

#import "YFSmsDetailVC.h"

#import "YYModel.h"

#import "YFSmsListVC.h"

#import "YFSmsRecipentSubCModel.h"

static NSString *yFSmsListCell = @"YFSmsListCell";

@interface YFSmsListCModel ()<YYModel>

@property(nonatomic, assign)CGFloat desHeight;

@end

@implementation YFSmsListCModel
{
    
}
- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFSmsListCell;
        self.cellClass = [YFSmsListCell class];
        self.cellHeight = 121.0f;
        //        self.o_id = [self.o_id guardStringYF];
        
        if (self.created_at.length > 7)
        {
            self.created_at = [self.created_at stringByReplacingOccurrencesOfString:@"T" withString:@" "];
            
            self.created_at = [self.created_at stringByReplacingCharactersInRange:NSMakeRange(self.created_at.length - 3, 3) withString:@""];
        }
    }
    return self;
}


- (void)bindCell:(YFSmsListCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    if (self.smsType == YFSmsTypeDraft) {
        baseCell.indicDraftButton.hidden = NO;
        baseCell.indicSenedButton.hidden = YES;
        
    }else
    {
        baseCell.indicDraftButton.hidden = YES;
        baseCell.indicSenedButton.hidden = NO;
    }
    
    if (self.attriTitleString)
    {
        baseCell.nameLabel.attributedText = self.attriTitleString;
    }
    else
    {
        if (self.title.length)
        {
        baseCell.nameLabel.text = self.title;
        }else
        {
        baseCell.nameLabel.text = @"(未填写收件人)";
        }
        
    }
    
    if (self.attriContentString)
    {
        baseCell.desLabel.attributedText = self.attriContentString;
    }else
    {
        if (self.content.length)
        {
        baseCell.desLabel.text = self.content;
        }else
        {
            baseCell.desLabel.text = [self showContent];
        }
    }


    [baseCell.desLabel changeHeight:self.desHeight];
    
    self.cellHeight = 121 - 38 + baseCell.desLabel.height;
    
    baseCell.timeLabel.text = self.created_at;
    
    [baseCell fitFrame];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath onVC:viewC];
    
    YFSmsDetailVC *deailVC = [[YFSmsDetailVC alloc] init];
    
    deailVC.message_id = self.sms_id;
    
    deailVC.smsType = self.smsType;
    
    [self.weakCell.currentVC.navigationController pushViewController:deailVC animated:YES];
}


- (YFSmsType)smsType
{
    if (_smsType == YFSmsTypeNone)
    {
        _smsType = self.status.integerValue;
    }
    return _smsType;
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"sms_id":@"id"};
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
    @"users":YFSmsRecipentSubCModel.class,
    };
}

- (NSMutableAttributedString *)attriContentString
{
    YFSmsListVC *listVC = (YFSmsListVC *)self.weakCell.currentVC;
    
    if (listVC.searchStr.length && self.content.length)
    {
        if (!_attriContentString)
        {
            _attriContentString = [self attriString:self.content searchStr:listVC.searchStr];
        }
    }
    else
    {
        _attriContentString = nil;
    }
    return _attriContentString;
}

- (NSMutableAttributedString *)attriTitleString
{
    YFSmsListVC *listVC = (YFSmsListVC *)self.weakCell.currentVC;
    
    if (listVC.searchStr.length && self.content.length)
    {
        if (!_attriTitleString)
        {
        _attriTitleString = [self attriString:self.title searchStr:listVC.searchStr];
        }
    }
    else
    {
        _attriTitleString = nil;
    }
    return _attriTitleString;
}

- (NSMutableAttributedString *)attriString:(NSString *)allString searchStr:(NSString *)searchStr
{
    YFSmsListCell *cell = (YFSmsListCell *)self.weakCell;

    NSRange range = [[allString lowercaseString] rangeOfString:[searchStr lowercaseString]];
    
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:allString];
    
    [attriString addAttribute:NSFontAttributeName value:cell.desLabel.font range:NSMakeRange(0, attriString.length)];
    
    [attriString addAttribute:NSForegroundColorAttributeName value:YFCellSubGrayTitleColor range:NSMakeRange(0, attriString.length)];
    
    if (range.location != NSNotFound)
    {
        [attriString addAttribute:NSForegroundColorAttributeName value:RGB_YF(234, 97, 97) range:range];
    }

    return attriString;
}

- (CGFloat)desHeight
{
    if (_desHeight == 0) {
        
        YFSmsListCell *cell = (YFSmsListCell *)self.weakCell;

        
        CGSize size = YF_MULTILINE_TEXTSIZE([self showContent], cell.desLabel.font, CGSizeMake(cell.desLabel.width, 38), 0);
        
        _desHeight =ceil(size.height);
        
        
    }
    return _desHeight;
}

- (NSString *)showContent
{
    if (self.content.length) {
        return self.content;
    }
    return @"(未填写短信内容)";
}

- (NSMutableArray *)showUsers
{
    return self.users;
}


@end


