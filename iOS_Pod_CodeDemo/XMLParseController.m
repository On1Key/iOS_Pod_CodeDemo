//
//  XMLParseController.m
//  iOS_Pod_CodeDemo
//
//  Created by mac book on 16/9/18.
//  Copyright © 2016年 mac book. All rights reserved.
//



#import "XMLParseController.h"
#import "XMLModel.h"
#import "XMLCell.h"
#import <WebKit/WebKit.h>

@interface XMLParseController ()<UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate>
/**列表*/
@property (nonatomic, strong) UITableView *xmlTable;
/**数据源*/
@property (nonatomic, strong) NSMutableArray *xmlModels;

@end

@implementation XMLParseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    [self requestData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receive:) name:@"123" object:nil];
}
- (void)receive:(NSNotification *)noti{
    _xmlModels = noti.object;
    [_xmlTable reloadData];
}
#pragma mark - 界面
- (void)setUpUI{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableHeaderView = nil;
    [self.view addSubview:tableView];
    _xmlTable = tableView;
    _xmlModels = [NSMutableArray array];
}
#pragma mark - 请求
- (void)requestData{
    NSString *csdn = @"http://geek.csdn.net/admin/news_service/rss";
    NSString *cnblogs = @"http://feed.cnblogs.com/blog/sitehome/rss";
    [BaseNetManager XML_GET:cnblogs complationHandle:^(id responseObject, NSError *error) {
        NSLog(@"====res>>>%@",responseObject );
        if (responseObject) {
            
            [[XMLModel new] parseXMLDataByXMLParser:responseObject];
        }
    }];
}



#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _xmlModels.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"cell";
    XMLCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XMLCell class]) owner:self options:nil][0];
    }
    XMLModel *model = _xmlModels[indexPath.section];
    cell.titleLabel.text = model.title;
    cell.contentLabel.text = model.summary;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 200;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s",__func__);
    XMLModel *model = _xmlModels[indexPath.section];
    UIViewController *vc = [[UIViewController alloc] init];
    WKWebView *web = [[WKWebView alloc] initWithFrame:vc.view.bounds];
    [vc.view addSubview:web];
    
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.idUrl]]];
    [self.navigationController pushViewController:vc animated:YES];
    
}





@end
