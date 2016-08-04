//
//  ServiceModel.h
//  iOS_Pod_CodeDemo
//
//  Created by mac book on 16/7/12.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceModel : NSObject
@property (nonatomic, assign) NSInteger caregiver_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *nation;
@property (nonatomic, copy) NSString *is_married;
@property (nonatomic, copy) NSString *urgent_contact_phone;
@property (nonatomic, copy) NSString *urgent_contact_name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *service_price;
@property (nonatomic, copy) NSString *age;
/**解析*/
+ (NSArray<ServiceModel *> *)parseServiceModel:(id)object;
@end
