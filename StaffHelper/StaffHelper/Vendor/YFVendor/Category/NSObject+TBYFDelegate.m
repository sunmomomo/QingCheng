//
//  NSObject+TBYFDelegate.m
//  OCTBLogical
//
//  Created by YFWCQ on 16/12/15.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "NSObject+TBYFDelegate.h"
#import "NSObject+RuntimeYF.h"


static const void *TBYFDataArrayKeyYF = @"TBYFDataArrayKeyYF";

static const void *TBYFCurrentVCYF = @"TBYFCurrentVCYF";
#pragma mark - single Section
static const void *TBYFDelegateKeyYF = @"TBYFDelegateKeyYF";
static const void *TBYFDatasourceKeyYF = @"TBYFDatasourceKeyYF";

#pragma mark - Sections
static const void *TBYFDelegateSectionKeyYF = @"TBYFDelegateSectionKeyYF";
static const void *TBYFDatasourceSectionKeyYF = @"TBYFDatasourceSectionKeyYF";

@implementation NSObject (TBYFDelegate)

-(void)setDataArrayYF:(DataArrayBLock)dataArrayYF
{
    [self yf_setCopyValueToObject:self key:&TBYFDataArrayKeyYF value:dataArrayYF];
}
-(DataArrayBLock)dataArrayYF
{
    return [self yf_getValueFromObject:self key:&TBYFDataArrayKeyYF];
}

-(void)setCurrentVCYF:(YFBaseVC *)currentVCYF
{
    [self yf_setRetainValueToObject:self key:&TBYFCurrentVCYF value:currentVCYF];
}

-(YFBaseVC *)currentVCYF
{
    return [self yf_getValueFromObject:self key:&TBYFCurrentVCYF];
}


#pragma mark - Singgle Section
-(YFTBBaseDelegate *)delegateSiTBYF
{
    YFTBBaseDelegate *delegateTBYF = [self yf_getValueFromObject:self key:&TBYFDelegateKeyYF];
    if (delegateTBYF == nil) {
        delegateTBYF = [YFTBBaseDelegate tableDelegeteWithArray:self.dataArrayYF currentVC:self.currentVCYF];
        [self setDelegateSiTBYF:delegateTBYF];
    }
    return delegateTBYF;
}

-(void)setDelegateSiTBYF:(YFTBBaseDelegate *)delegateSiTBYF
{
    [self yf_setRetainValueToObject:self key:&TBYFDelegateKeyYF value:delegateSiTBYF];
}


-(YFTBBaseDatasource *)dataSourceSiTBYF
{
    YFTBBaseDatasource *datasourceTBYF = [self yf_getValueFromObject:self key:&TBYFDatasourceKeyYF];
    if (datasourceTBYF == nil) {
        datasourceTBYF = [YFTBBaseDatasource tableDelegeteWithArray:self.dataArrayYF currentVC:self.currentVCYF];
        [self setDataSourceSiTBYF:datasourceTBYF];
    }
    return datasourceTBYF;
}
-(void)setDataSourceSiTBYF:(YFTBBaseDatasource *)dataSourceSiTBYF
{
    [self yf_setRetainValueToObject:self key:&TBYFDatasourceKeyYF value:dataSourceSiTBYF];
    
}



#pragma mark - Section s
-(YFTBBaseDelegate *)delegateSectionsTBYF
{
    YFTBBaseDelegate *delegateTBYF = [self yf_getValueFromObject:self key:&TBYFDelegateSectionKeyYF];
    if (delegateTBYF == nil) {
        delegateTBYF = [YFTBSectionsDelegate tableDelegeteWithArray:self.dataArrayYF currentVC:self.currentVCYF];
        [self setDelegateSectionsTBYF:delegateTBYF];
    }
    return delegateTBYF;
}


-(void)setDelegateSectionsTBYF:(YFTBBaseDelegate *)delegateSectionsTBYF
{
    [self yf_setRetainValueToObject:self key:&TBYFDelegateSectionKeyYF value:delegateSectionsTBYF];
    
}

-(YFTBBaseDatasource *)dataSourceSectionsTBYF
{
    YFTBSectionsDataSource *datasourceTBYF = [self yf_getValueFromObject:self key:&TBYFDatasourceSectionKeyYF];
    if (datasourceTBYF == nil) {
        datasourceTBYF = [YFTBSectionsDataSource tableDelegeteWithArray:self.dataArrayYF currentVC:self.currentVCYF];
        [self setDataSourceSectionsTBYF:datasourceTBYF];
    }
    return datasourceTBYF;
}

-(void)setDataSourceSectionsTBYF:(YFTBBaseDatasource *)dataSourceSectionsTBYF
{
    [self yf_setRetainValueToObject:self key:&TBYFDatasourceSectionKeyYF value:dataSourceSectionsTBYF];
}


@end
