//
//  BaseNetManager.m
//  喜马拉雅FM(高仿品)
//
//  Created by apple-jd33 on 15/11/9.
//  Copyright © 2015年 HansRove. All rights reserved.
//

#import "BaseNetManager.h"

@interface BaseNetManager()<UIAlertViewDelegate>

@end

static AFHTTPSessionManager *manager = nil;
@implementation BaseNetManager


/** 单例AFHTTPSessionManager */
+ (AFHTTPSessionManager *)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        // 设置请求失效的时长
        manager.requestSerializer.timeoutInterval = 5;
        // 设置接受解析的内容类型
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"text/plain",@"text/javascript",@"application/json", nil];
    });
    
    return manager;
}

/**
 * 普通的GET方法
 */
+ (id)GET:(NSString *)path parameters:(NSDictionary *)params complationHandle:(void (^)(id, NSError *))completed {
    
    NSLog(@"Request Path: \n%@, params %@", path, params);
    return [[self defaultManager] GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completed) {
            completed(responseObject,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"GET ERROR: %@",error.userInfo);
        if (completed) {
            completed(nil,error);
        }
    }];
}

/**
 * 普通的POST方法
 */
+ (id)POST:(NSString *)path parameters:(NSDictionary *)params complationHandle:(void (^)(id, NSError *))completed {


    NSLog(@"Request Path: %@, \nparams %@", path, params);
   return [[self defaultManager] POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
       if (completed) {
           completed(responseObject,nil);
       }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"POST ERROR: %@",error.userInfo);
        if (completed) {
            completed(nil,error);
        }
    }];
}



@end
