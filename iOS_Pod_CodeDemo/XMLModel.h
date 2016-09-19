//
//  XMLModel.h
//  iOS_Pod_CodeDemo
//
//  Created by mac book on 16/9/18.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLModel : NSObject
/**id==url*/
@property (nonatomic, copy) NSString *idUrl;
/**标题*/
@property (nonatomic, copy) NSString *title;
/**内容*/
@property (nonatomic, copy) NSString *summary;
//+ (id)parseXMLModel:(XMLModel *)model dataByElementName:(NSString *)elementName;
/**解析数据，通过通知返回结果*/
- (void)parseXMLDataByXMLParser:(NSXMLParser *)parser;
@end
