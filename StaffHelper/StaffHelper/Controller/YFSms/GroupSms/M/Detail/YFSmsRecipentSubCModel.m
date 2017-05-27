//
//  YFSmsRecipentSubCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/17.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSmsRecipentSubCModel.h"

#import "YFSmsRecipentCell.h"

static NSString *yFSmsRecipentCell = @"YFSmsRecipentCell00";

@implementation YFSmsRecipentSubCModel

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFSmsRecipentCell;
        self.cellClass = [YFSmsRecipentCell class];
        self.cellHeight = 35;
        self.edgeInsets = UIEdgeInsetsMake(0, MSW, 0, 0);
        //        self.o_id = [self.o_id guardStringYF];
    }
    return self;
}
-(instancetype)init
{
    if (self= [super init])
    {
        self.cellIdentifier = yFSmsRecipentCell;
        self.cellClass = [YFSmsRecipentCell class];
        self.cellHeight = 35;
        self.edgeInsets = UIEdgeInsetsMake(0, MSW, 0, 0);
    }
    return self;
}

- (void)setCell:(YFSmsRecipentCell *)baseCell toObjectFY:(NSObject *)object
{
    [baseCell setSubStyle];
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)bindCell:(YFSmsRecipentCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    self.weakCell.indexPath = indexPath;
    
    baseCell.baseModel = self;
 
    if (self.notBelongName.length) {
        baseCell.nameAllLabel.text = self.notBelongName;
    }else
    {
    baseCell.nameAllLabel.attributedText = self.atriFirstNameString;
    }
}

- (NSMutableAttributedString *)atriFirstNameString
{
    if (!_atriFirstNameString) {
        
        YFSmsRecipentCell *weakCell = (YFSmsRecipentCell *)self.weakCell;
        NSMutableAttributedString *atriString = [[NSMutableAttributedString alloc] initWithString:self.allNameTitle];
        
        [atriString addAttribute:NSFontAttributeName value:weakCell.nameAllLabel.font range:NSMakeRange(0, atriString.length)];
        [atriString addAttribute:NSForegroundColorAttributeName value:RGB_YF(51, 51, 51) range:NSMakeRange(0, atriString.length)];
        if (atriString.length >= 13)
        {
            [atriString addAttribute:NSForegroundColorAttributeName value:RGB_YF(199, 199, 199) range:NSMakeRange(atriString.length - 13, 13)];
        }
        
        _atriFirstNameString = atriString;
    }
    return _atriFirstNameString;
}

- (NSString *)allNameTitle
{
    if (!_allNameTitle)
    {
        _allNameTitle = [NSString stringWithFormat:@"%@    %@",self.name,self.phone];
    }
    return _allNameTitle;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    
}


@end
