//
//  MJExtensionController.m
//  iOS_Pod_CodeDemo
//
//  Created by mac book on 16/7/12.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "MJExtensionController.h"
#import "ServiceModel.h"
#import "XibModel.h"

@interface MJExtensionController ()
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation MJExtensionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestAndParseModels];
    
}
/// 请求数据并创建模型数组
- (void)requestAndParseModels{
    [BaseNetManager GET:@"http://www.ehaohugong.com/api/v2/caregiver/detail?access-token=Fuf87lKbh9ya8CoCAD_ZWANNGJORo424&app_id=5555555555" parameters:@{@"caregiver_id":@"100000001"} complationHandle:^(id responseObject, NSError *error) {
        self.dataArr = [ServiceModel parseServiceModel:responseObject];
        
        //反转，并保存
        [self changeModelsToDicArrWriteToPlistFile];
        NSLog(@"%@",self.dataArr);
    }];
}
/// 将模型数组解析为json数据，并写入本地文件
- (void)changeModelsToDicArrWriteToPlistFile{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths  objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:@"test.plist"];
    NSArray *arr = [XibModel mj_keyValuesArrayWithObjectArray:self.dataArr];
    [arr writeToFile:filename atomically:YES];
    
    NSLog(@"===\n%@\n========\n",filename);
}

@end
