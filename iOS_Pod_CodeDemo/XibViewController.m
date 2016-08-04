//
//  XibViewController.m
//  RSA
//
//  Created by mac book on 16/7/14.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "XibViewController.h"
#import "XibModel.h"
#import "XibCell.h"
//#import "XibFrameCell.h"

#define REUSE @"sdsdsd"

@interface XibViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation XibViewController
- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [XibModel testModels];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.tableView registerClass:[XibCell class] forCellReuseIdentifier:REUSE];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XibCell class]) bundle:nil] forCellReuseIdentifier:REUSE];
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XibCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSE];
//    if (!cell) {
//        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([XibCell class]) owner:nil options:nil] firstObject];
//    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.xibModel = self.dataSource[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [tableView fd_heightForCellWithIdentifier:REUSE configuration:^(XibCell *cell) {
        cell.xibModel = self.dataSource[indexPath.row];
    }];
    NSLog(@"------=%ld==%.f",indexPath.row,height);
    return height;
//    return 400;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"打印==%ld",indexPath.row);
}
@end
