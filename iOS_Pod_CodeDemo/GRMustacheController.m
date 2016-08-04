//
//  GRMustacheController.m
//  iOS_Pod_CodeDemo
//
//  Created by mac book on 16/7/12.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "GRMustacheController.h"

@interface GRMustacheController ()<UIWebViewDelegate>

@end

@implementation GRMustacheController

- (void)viewDidLoad {
    [super viewDidLoad];
    //测试GRMustache框架，使用字典改变html文件的内容
    [self testOf_GRMustache_changeWebViewTextByTitle:@"title名称" info:@"文本内容"];
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
