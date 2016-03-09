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



@interface ViewController ()<UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    测试GRMustache框架，使用字典改变html文件的内容
//    [self testOf_GRMustache_changeWebViewTextByTitle:@"title名称" info:@"文本内容"];
//    测试pop用法
    [self popAnimationTest];
}
#pragma mark - pop简单用法
/**
 *  ------------------------------------------------------------------
 *  pop简单用法
 */
- (void)popAnimationTest{
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(100, 300, 100, 100);
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitle:@"button" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setImage:nil forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)buttonAction:(UIButton *)btn{
//    [self spring:btn];
//    [self basic:btn];
//    [self decay:btn];
    [self group:btn];
}
//弹性动画
- (void)spring:(UIView *)view{
    POPSpringAnimation* framePOP = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBackgroundColor];
    
    framePOP.springSpeed = 20.f;
    
    framePOP.springBounciness = 40.f;
    
    framePOP.toValue = COLOR_RANDOM;
    
    [framePOP setCompletionBlock:^(POPAnimation * anim , BOOL finsih) {
        
        if (finsih) {
            
            NSLog(@"view.frame = %@",NSStringFromCGRect(view.frame));
            
        }
        
    }];
    
    [view pop_addAnimation:framePOP forKey:@"go"];
}
//减缓动画
- (void)decay:(UIView *)view{
    POPDecayAnimation* decay = [POPDecayAnimation animationWithPropertyNamed:kPOPViewFrame];
    
    //    decay.toValue = [NSValue valueWithCGRect:CGRectMake(200, 400, 100, 100)];
    
    decay.velocity = [NSValue valueWithCGRect:CGRectMake(200, 300, 100, 100)];
    
    [view pop_addAnimation:decay forKey:@"go"];
}
/**
 *  基本动画
 */
-(void)basic:(UIView *)view{
    
    POPBasicAnimation* basicAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerCornerRadius];
    
    static int num = 0;
    //ziji jia
    num++;
    if (num>=4) {
        num=2;
    }
    
    
    basicAnimation.toValue = [NSNumber numberWithFloat:CGRectGetHeight(view.frame)/num];
    
    basicAnimation.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    //    basicAnimation.duration = 3.f;
    
    [basicAnimation setCompletionBlock:^(POPAnimation * ani, BOOL fin) {
        
        if (fin) {
            
            NSLog(@"view.frame = %@",NSStringFromCGRect(view.frame));
            
            //            POPBasicAnimation* newBasic = [POPBasicAnimation easeInEaseOutAnimation];
            
            //            newBasic.property = [POPAnimatableProperty propertyWithName:kPOPLayerCornerRadius];
            
            //            newBasic.toValue = [NSNumber numberWithFloat:0];
            
            //            [view.layer pop_addAnimation:newBasic forKey:@"go"];
            
        }
        
    }];
    
    [view.layer pop_addAnimation:basicAnimation forKey:@"frameChange"];
}


//组合动画

-(void)group:(UIView *)view

{
    
    view.transform = CGAffineTransformMakeRotation(M_PI_2/3);
    
    
    
    
    
    POPBasicAnimation* spring = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    
    spring.beginTime = CACurrentMediaTime();
    
    spring.duration = .4f;
    
    spring.fromValue = [NSNumber numberWithFloat:-100.f];
    
    spring.toValue = [NSNumber numberWithFloat:CGRectGetMinY(view.frame) + 10];
    
    [spring setCompletionBlock:^(POPAnimation * ani, BOOL fin) {
        
    }];
    
    
    
    
    
    POPBasicAnimation* basic = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    
    basic.beginTime = CACurrentMediaTime();
    
    basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    basic.toValue = [NSNumber numberWithFloat:-M_PI_4];
    
    basic.duration = .4f;
    
    
    
    
    
    POPBasicAnimation* rotation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    
    rotation.beginTime = CACurrentMediaTime() + .4f;
    
    rotation.toValue = [NSNumber numberWithFloat:0.f];
    
    rotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    rotation.duration = .25f;
    
    
    
    
    
    POPBasicAnimation* donw = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    
    donw.beginTime = CACurrentMediaTime() + 0.4f;
    
    donw.toValue = [NSNumber numberWithFloat:CGRectGetMinY(view.frame)];
    
    donw.duration = .25f;
    
    donw.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    
    
    
    
    
    
    [view.layer pop_addAnimation:spring forKey:@"spring"];
    
    [view.layer pop_addAnimation:basic forKey:@"basic"];
    
    [view.layer pop_addAnimation:donw forKey:@"down"];
    
    [view.layer pop_addAnimation:rotation forKey:@"rotation"];
    
}
#pragma mark - GRMustache框架，html修改
/**
 *  ------------------------------------------------------------------
 *  测试GRMustache框架，使用字典改变html文件的内容
 */
- (void)testOf_GRMustache_changeWebViewTextByTitle:(NSString *)title info:(NSString *)info{
    //这个htmlString用来和字典改变html文件内容比较
    //可通过打开下面的注释作对比
    NSString *htmlString = @"<html>"
    "<head>"
    "<h1>title名称ss</h1>"
    "</head>"
    "<body>"
    "<p>文本内容ss</p>"
    "</body>"
    "</html>";
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(50, 100, SCREEN_WIDTH - 100, 300)];
    webview.delegate = self;
    webview.backgroundColor = COLOR_RANDOM;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"customer" ofType:@"html"];
    NSString *pathString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *dic = @{@"name": @"title名称",@"content":@"文本内容"};
    NSString *content = [GRMustacheTemplate renderObject:dic fromString:pathString error:nil];
    [self.view addSubview:webview];
//    [webview loadHTMLString:htmlString baseURL:nil];
    [webview loadHTMLString:content baseURL:[NSURL URLWithString:path]];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"%s\n%@\n%@",__func__,request,request.URL.scheme);
    return YES;
}




















@end
