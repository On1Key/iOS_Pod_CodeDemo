//
//  ServiceModel.m
//  iOS_Pod_CodeDemo
//
//  Created by mac book on 16/7/12.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "ServiceModel.h"

@implementation ServiceModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"sex":@"gender"};
}
/**解析*/
+ (NSArray<ServiceModel *> *)parseServiceModel:(id)object{
    if (![object isKindOfClass:[NSDictionary class]]) {
        return @[];
    }
    NSDictionary *res = object;
    NSArray *arr = res[@"data"][@"caregiver"];
    NSArray *models = [ServiceModel mj_objectArrayWithKeyValuesArray:arr];
//    ServiceModel *mo = models[0];
//    NSMutableArray *models = [NSMutableArray array];
//    for (NSDictionary *dict in arr) {
//        ServiceModel *model = [ServiceModel mj_objectWithKeyValues:dict];
//        [models addObject:model];
//    }
    return models;
}
@end
