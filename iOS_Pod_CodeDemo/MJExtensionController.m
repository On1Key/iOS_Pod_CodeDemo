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
#import "MJExtenView.h"

@interface MJExtensionController ()
@property (nonatomic, strong) NSArray *dataArr;
/**内存显示*/
@property (nonatomic, strong) MJExtenView *extenView;
@end

@implementation MJExtensionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpExtebView];
    [self requestAndParseModels];
    
}
- (void)setUpExtebView{
    _extenView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MJExtenView class]) owner:self options:nil][0];
    [self.view addSubview:_extenView];
    [_extenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH * (149.0/412.0)));
        make.center.mas_equalTo(self.view);
    }];
}
/// 请求数据并创建模型数组
- (void)requestAndParseModels{
    NSString *getPath = @"http://www.ehaohugong.com/api/v2/caregiver/detail?access-token=Fuf87lKbh9ya8CoCAD_ZWANNGJORo424&app_id=5555555555";
    
    NSURLSessionDataTask *dataTask = [BaseNetManager GET:getPath parameters:@{@"caregiver_id":@"100000001"} complationHandle:^(id responseObject, NSError *error) {
        self.dataArr = [ServiceModel parseServiceModel:responseObject];
        
        //反转，并保存，自己手动写入缓存
        [self changeModelsToDicArrWriteToPlistFile];
        NSLog(@"%@",self.dataArr);
        
        
    }];
    
    //系统缓存
    NSURLCache *urlCache = [NSURLCache sharedURLCache];
    NSCachedURLResponse *res = [urlCache cachedResponseForRequest:dataTask.currentRequest];
    if (res!=nil) {
        id resRes = [NSJSONSerialization JSONObjectWithData:res.data options:NSJSONReadingMutableLeaves error:nil];
        _extenView.currentContentLabel.text = [[self changeCacheInterToString:urlCache.currentMemoryUsage] stringByAppendingFormat:@"/%@",[self changeCacheInterToString:urlCache.currentDiskUsage]];
        _extenView.maxContentLabel.text = [[self changeCacheInterToString:CACHE_MEMORY_MAX] stringByAppendingFormat:@"/%@",[self changeCacheInterToString:CACHE_DISK_MAX]];
        [_extenView calculateProgress];
        NSLog(@"\n|---system cache---|----->>>>\n\n|---url---|\n%@\n\n|---res---|\n%@",dataTask.currentRequest.URL,resRes);
    }else{
        NSLog(@"cache=====nil");
    }
}
- (NSString *)changeCacheInterToString:(NSInteger)cacheValue{
    return [NSString stringWithFormat:@"%.2f",(cacheValue / (1024.0 * 1024.0))];
}
/// 将模型数组解析为json数据，并写入本地文件
- (void)changeModelsToDicArrWriteToPlistFile{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths  objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:@"test.plist"];
    NSArray *arr = [XibModel mj_keyValuesArrayWithObjectArray:self.dataArr];
    [arr writeToFile:filename atomically:YES];
    
}

@end
