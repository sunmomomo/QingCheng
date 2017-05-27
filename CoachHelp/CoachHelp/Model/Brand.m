//
//  Brand.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "Brand.h"

@implementation Brand

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super init]) {
        
        self.name = [aDecoder decodeObjectForKey:@"name"];
        
        self.brandId = [aDecoder decodeIntegerForKey:@"brandId"];
        
        self.imgURL = [aDecoder decodeObjectForKey:@"imgURL"];
        
    }
    
    return self;
    
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.name forKey:@"name"];
    
    [aCoder encodeInteger:self.brandId forKey:@"brandId"];
    
    [aCoder encodeObject:self.imgURL forKey:@"imgURL"];
    
}

-(id)copy
{
    
    Brand *brand = [[Brand alloc]init];
    
    brand.brandId = self.brandId;
    
    brand.name = self.name;
    
    brand.imgURL = self.imgURL;
    
    brand.image = self.image;
    
    brand.havePower = self.havePower;
    
    brand.owner = self.owner;
    
    brand.cname = self.cname;
    
    brand.gymCount = self.gymCount;
    
    brand.createTime = self.createTime;
    
    return brand;
    
}

@end
