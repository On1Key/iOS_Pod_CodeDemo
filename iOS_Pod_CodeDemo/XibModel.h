//
//  XibModel.h
//  RSA
//
//  Created by mac book on 16/7/14.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XibModel : NSObject
@property (nonatomic, copy) NSString *headerUrl;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *infoUrl;
@property (nonatomic, copy) NSString *arrow;
+ (NSArray *)testModels;
@end
