//
//  ViewController.m
//  iOS_Pod_CodeDemo
//
//  Created by mac book on 16/3/9.
//  Copyright © 2016年 mac book. All rights reserved.
//
//
//iOS开发之AFNetworking 3.0.4使用
//http://www.jianshu.com/p/11bb0d4dc649
//
//

#pragma mark - 添加规范注释
/**
 *  ------------------------------------------------------------------
 *  添加规范注释
 */

#import "ViewController.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    layout布局集成
    [self autoMasonryLayOutTest];
}
#pragma mark - Masonry框架，layout布局集成
/**
 *  ------------------------------------------------------------------
 *  Masonry框架，layout布局集成
 *  原文地址如下：
 *  http://www.cocoachina.com/ios/20141219/10702.html
 *  - (NSArray *)mas_makeConstraints:(void(^)(MASConstraintMaker *make))block;
 *  - (NSArray *)mas_updateConstraints:(void(^)(MASConstraintMaker *make))block;
 *  - (NSArray *)mas_remakeConstraints:(void(^)(MASConstraintMaker *make))block;
 *  mas_makeConstraints 只负责新增约束 Autolayout不能同时存在两条针对于同一对象的约束 否则会报错
 *  mas_updateConstraints 针对上面的情况 会更新在block中出现的约束 不会导致出现两个相同约束的情况
 *  mas_remakeConstraints 则会清除之前的所有约束 仅保留最新的约束
 *  三种函数善加利用 就可以应对各种情况了
 */
- (void)autoMasonryLayOutTest{
    
    
//    头文件定义了一个MACRO,用法是这样的
//    WS(weakSelf);
//    weakSelf就是这个弱引用
    
    if (arc4random()%2 == 0) {
        [self scrollviewTest01];
    }else{
        [self scrollviewTest02];
    }
    
    UIView *sv11 = [UIView new];
    UIView *sv12 = [UIView new];
    UIView *sv13 = [UIView new];
    UIView *sv21 = [UIView new];
    UIView *sv31 = [UIView new];
    
    sv11.backgroundColor = [UIColor redColor];
    sv12.backgroundColor = [UIColor redColor];
    sv13.backgroundColor = [UIColor redColor];
    sv21.backgroundColor = [UIColor redColor];
    sv31.backgroundColor = [UIColor redColor];
    
    //在做autoLayout之前 一定要先将view添加到superview上 否则会报错
    [self.view addSubview:sv11];
    [self.view addSubview:sv12];
    [self.view addSubview:sv13];
    [self.view addSubview:sv21];
    [self.view addSubview:sv31];
    
    //给予不同的大小 测试效果
    
    //mas_makeConstraints就是Masonry的autolayout添加函数 将所需的约束添加到block中行了
    [sv11 mas_makeConstraints:^(MASConstraintMaker *make) {
        //设置sv11的中心xy
        make.centerY.equalTo(@[sv12,sv13]);
        make.centerX.equalTo(@[sv21,sv31]);
        //设置sv11的size大小
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [sv12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    
    [sv13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [sv21 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    
    [sv31 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 60));
    }];
    
    [self distributeSpacingHorizontallyWith:@[sv11,sv12,sv13]];
    [self distributeSpacingVerticallyWith:@[sv11,sv21,sv31]];
    
    //    [self showPlaceHolderWithAllSubviews];
    //    [self hidePlaceHolder];
    
}
- (void)scrollviewTest02{
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = COLOR_RGB(244, 237, 234, 1);
    [self.view addSubview:scrollView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(10 + 64, 10, 10, 10));
    }];
    
    
    for (int i = 0; i < 10; i ++) {
        UIView *view = [UIView new];
        view.backgroundColor = COLOR_RANDOM;
        [scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(scrollView);
            make.height.equalTo(@(100));
            make.centerX.equalTo(scrollView);
            make.centerY.equalTo(@(100 * i));
            
        }];
        
    }
    
    scrollView.contentSize = CGSizeMake(0, 100*10 + 800);
}
- (void)scrollviewTest01{
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = COLOR_RGB(244, 237, 234, 1);
    [self.view addSubview:scrollView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(10 + 64, 10, 10, 10));
    }];
    
    UIView *container = [UIView new];
    [scrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    UIView *lastView = nil;
    for (int i = 0; i < 10; i ++) {
        UIView *view = [UIView new];
        view.backgroundColor = COLOR_RANDOM;
        [scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(container);
            if (lastView) {
                make.top.mas_equalTo(lastView.mas_bottom);
            }else{
                make.top.mas_equalTo(scrollView.mas_top);
            }
            make.height.mas_equalTo(@(i * 30));
        }];
        lastView = view;
    }
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];
    scrollView.contentSize = CGSizeMake(0, lastView.mas_bottom.view.frame.origin.y);
}
- (void) distributeSpacingHorizontallyWith:(NSArray*)views
{
    NSMutableArray *spaces = [NSMutableArray arrayWithCapacity:views.count+1];
    
    for ( int i = 0 ; i < views.count+1 ; ++i )
    {
        UIView *v = [UIView new];
        [spaces addObject:v];
        [self.view addSubview:v];
        
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(v.mas_height);
        }];
    }
    
    UIView *v0 = spaces[0];
    
    [v0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.centerY.equalTo(((UIView*)views[0]).mas_centerY);
    }];
    
    UIView *lastSpace = v0;
    for ( int i = 0 ; i < views.count; ++i )
    {
        UIView *obj = views[i];
        UIView *space = spaces[i+1];
        
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lastSpace.mas_right);
        }];
        
        [space mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(obj.mas_right);
            make.centerY.equalTo(obj.mas_centerY);
            make.width.equalTo(v0);
        }];
        
        lastSpace = space;
    }
    
    [lastSpace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right);
    }];
    
}

- (void) distributeSpacingVerticallyWith:(NSArray*)views
{
    NSMutableArray *spaces = [NSMutableArray arrayWithCapacity:views.count+1];
    
    for ( int i = 0 ; i < views.count+1 ; ++i )
    {
        UIView *v = [UIView new];
        [spaces addObject:v];
        [self.view addSubview:v];
        
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(v.mas_height);
        }];
    }
    
    
    UIView *v0 = spaces[0];
    
    [v0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.centerX.equalTo(((UIView*)views[0]).mas_centerX);
    }];
    
    UIView *lastSpace = v0;
    for ( int i = 0 ; i < views.count; ++i )
    {
        UIView *obj = views[i];
        UIView *space = spaces[i+1];
        
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastSpace.mas_bottom);
        }];
        
        [space mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(obj.mas_bottom);
            make.centerX.equalTo(obj.mas_centerX);
            make.height.equalTo(v0);
        }];
        
        lastSpace = space;
    }
    
    [lastSpace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
}


@end
