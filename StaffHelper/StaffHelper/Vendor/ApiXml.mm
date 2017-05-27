
#import <Foundation/Foundation.h>
#import "ApiXml.h"
/*
 XML 解析库
 */
@implementation XMLHelper
-(void) startParse:(NSData *)data{

    dictionary =[NSMutableDictionary dictionary];
    contentString=[NSMutableString string];
    
    //Demo XML解析实例
    xmlElements = [[NSMutableArray alloc] init];
    
    xmlParser = [[NSXMLParser alloc] initWithData:data];

    [xmlParser setDelegate:self];
    [xmlParser parse];
    
}
-(NSMutableDictionary*) getDict{
    return dictionary;
}
//解析文档开始
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    //解析文档开始
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    //"遇到启始标签:
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    //遇到内容
    [contentString setString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    //遇到结束标签
    
    if( ![contentString isEqualToString:@"\n"] && ![elementName isEqualToString:@"root"]){
        [dictionary setObject: [contentString copy] forKey:elementName];
        
    }
}

//解析文档结束
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    //文档解析结束
    [xmlElements release];
    [xmlParser release];
}

@end
