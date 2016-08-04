//
//  MBProHUDController.m
//  iOS_Pod_CodeDemo
//
//  Created by mac book on 16/7/13.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "MBProHUDController.h"

@interface MBProHUDController ()
@property (nonatomic, strong) MBProgressHUD *HUD;
@end

@implementation MBProHUDController

@synthesize HUD;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)showTextDialog:(id)sender {
    //初始化进度框，置于当前的View当中
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    //如果设置此属性则当前的view置于后台
    HUD.dimBackground = YES;
    
    //设置对话框文字
    HUD.labelText = @"请稍等";
    
    //显示对话框
    [HUD showAnimated:YES whileExecutingBlock:^{
        //对话框显示时需要执行的操作
        sleep(3);
    } completionBlock:^{
        //操作执行完后取消对话框
        [HUD removeFromSuperview];
        HUD = nil;
    }];
}

- (IBAction)showProgressDialog:(id)sender {
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"正在加载";
    
    //设置模式为进度框形的
    HUD.mode = MBProgressHUDModeDeterminate;
    [HUD showAnimated:YES whileExecutingBlock:^{
        float progress = 0.0f;
        while (progress < 1.0f) {
            progress += 0.01f;
            HUD.progress = progress;
            usleep(50000);
        }
    } completionBlock:^{
        [HUD removeFromSuperview];
        HUD = nil;
    }];
}

- (IBAction)showProgressDialog2:(id)sender {
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"正在加载";
    HUD.mode = MBProgressHUDModeAnnularDeterminate;
    
    [HUD showAnimated:YES whileExecutingBlock:^{
        float progress = 0.0f;
        while (progress < 1.0f) {
            progress += 0.01f;
            HUD.progress = progress;
            usleep(50000);
        }
    } completionBlock:^{
        [HUD removeFromSuperview];
        HUD = nil;
    }];
}

- (IBAction)showCustomDialog:(id)sender {
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"自定义操作成功";
    HUD.mode = MBProgressHUDModeCustomView;
    NSString *str = @"box";
    NSMutableArray *gifArray = [NSMutableArray array];
    for (int i = 1; i < 14; i ++) {
        NSString *sss = [@"" stringByAppendingFormat:@"%@%d.tiff",str,i];
        [gifArray addObject:[UIImage imageNamed:sss]];
    }
    UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 10)];
    gifImageView.animationImages = gifArray; //动画图片数组
    gifImageView.animationDuration = 2; //执行一次完整动画所需的时长
    gifImageView.animationRepeatCount = 1;  //动画重复次数
    [gifImageView startAnimating];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"circleBox" ofType:@"gif"];
    HUD.customView = gifImageView;//[[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:path]];
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [HUD removeFromSuperview];
        HUD = nil;
    }];
    
}

- (IBAction)showAllTextDialog:(id)sender {
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"文本提示";
    HUD.mode = MBProgressHUDModeText;
    
    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
    //    HUD.yOffset = 150.0f;
    //    HUD.xOffset = 100.0f;
    
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [HUD removeFromSuperview];
        HUD = nil;
    }];
}


@end
