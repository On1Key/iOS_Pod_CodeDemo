//
//  XMLModel.m
//  iOS_Pod_CodeDemo
//
//  Created by mac book on 16/9/18.
//  Copyright © 2016年 mac book. All rights reserved.
//

/**cnblogs*/
#define XML_ID @"id"
#define XML_TITLE @"title"
#define XML_SUMMARY @"summary"
#define XML_ENTRY @"entry"
#define XML_FEED @"feed"

/**csdn*/

#import "XMLModel.h"

@interface XMLModel ()<NSXMLParserDelegate>
/***/
@property (nonatomic, strong) NSMutableArray *xmlModels;
/**临时属性保存*/
@property (nonatomic, copy) NSString *xmlTmpProperty;
@end


/**===========================*/
//完整数据结构查看对应的cnblogs_rss.xml文件
/**===========================*/


@implementation XMLModel
/**解析，返回xml模型*/
//+ (id)parseXMLModel:(XMLModel *)model dataByElementName:(NSString *)elementName value:(NSString *)value{
//    [model setValue:value forKey:elementName];
//    return model;
//}
- (void)parseXMLDataByXMLParser:(NSXMLParser *)parser{
//    NSXMLParser *parser = responseObject;
    
    parser.delegate = self;
    [parser parse];
    
}
#pragma mark - NSXMLParser代理

//第一个代理方法：
- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    //判断是否是entry节点，即一个新的
    //        if ([elementName isEqualToString:@"entry"]) {
    //判断属性节点
    //            if ([attributeDict objectForKey:@"addr"]) {
    //                //获取属性节点中的值
    //                NSString *addr=[attributeDict objectForKey:@"addr"];
    //            }
    if ([elementName isEqualToString:XML_ENTRY]) {
        XMLModel *model = [XMLModel new];
        
        //初始化数组
        if (!_xmlModels) {
            _xmlModels = [NSMutableArray array];
        }
        [_xmlModels addObject:model];
    }
    
//    if ([[NSString stringWithString:elementName] isEqualToString:XML_TITLE]) {
//        _xmlTmpProperty = elementName;
//    }else if ([[NSString stringWithString:elementName] isEqualToString:XML_SUMMARY]) {
//        _xmlTmpProperty = elementName;
//    }
    NSLog(@"-1---1----1---1-属性节点==\n%@\nname==%@\nqual==%@\n属性内属性==%@\n",elementName,namespaceURI,qualifiedName,attributeDict);
}

//第二个代理方法：
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //获取文本节点中的数据，因为下面的方法要保存这里获取的数据，所以要定义一个全局变量(可修改的字符串)
    //string是获取到的文本节点的值，只要是文本节点都会获取(包括换行)，然后到下个方法中进行判断区分
//    if (string && ![string isEqualToString:@""] && ![string isEqualToString:@"\n "] && [_xmlTmpProperty isEqualToString:XML_TITLE]) {
//        _xmlTmpProperty = string;
//    }else if (string && ![string isEqualToString:@""] && [_xmlTmpProperty isEqualToString:XML_SUMMARY]){
        _xmlTmpProperty = string;
//    }
    NSLog(@"-2---2----2---2-节点数据==\n%@",string);
}

//第三个代理方法：
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:XML_ID]) {
        XMLModel *model = [_xmlModels lastObject];
        model.idUrl = _xmlTmpProperty ;
//        [model setValue:_xmlTmpProperty forKey:model.idUrl];
    }
    if ([elementName isEqualToString:XML_TITLE]) {
        XMLModel *model = [_xmlModels lastObject];
//        model.title = _xmlTmpProperty;
        [model setValue:_xmlTmpProperty forKey:elementName];
//        NSLog(@"===0000>>>>>>>>>==%@",[model valueForKey:elementName]);
    }
    if ([elementName isEqualToString:XML_SUMMARY]) {
        XMLModel *model = [_xmlModels lastObject];
        model.summary = _xmlTmpProperty;
    }
    if ([elementName isEqualToString:XML_ENTRY]) {
        _xmlTmpProperty = nil;
    }
    //结束的节点
    if ([elementName isEqualToString:XML_FEED]){
//        [_xmlTable reloadData];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"123" object:_xmlModels];
    }
    NSLog(@"-3---3----3---3-\nele==%@\nname==%@\nqnam==%@",elementName,namespaceURI,qName);
    
}
@end
