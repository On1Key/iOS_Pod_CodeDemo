//
//  MainTableController.m
//  iOS_Pod_CodeDemo
//
//  Created by mac book on 16/7/12.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "MainTableController.h"

@interface MainTableController ()
/**所有标题数组*/
@property (nonatomic, strong) NSArray *data;
/**所有vc name数组*/
@property (nonatomic, strong) NSArray *vcClasses;
/**普通控制器name数组*/
@property (nonatomic, strong) NSArray *codeVCS;
/**srotyboard控制的控制器name数组*/
@property (nonatomic, strong) NSArray *storyboardVCs;
/**xib控制器name数组*/
@property (nonatomic, strong) NSArray *xibVCS;
@end

@implementation MainTableController

- (NSArray *)data{
    if (!_data) {
        _data = @[@"GRMustache",
                  @"POP",
                  @"Masonry",
                  @"MJExtension",
                  @"MBProHUD",
                  @"Xib_FDTLayCell"];
    }
    return _data;
}
- (NSArray *)codeVCS{
    if (!_codeVCS) {
        _codeVCS = @[@"GRMustacheController",
                     @"PopViewController",
                     @"ViewController",
                     @"MJExtensionController"];
    }
    return _codeVCS;
}
- (NSArray *)xibVCS{
    if (!_xibVCS) {
        _xibVCS = @[@"XibViewController"];
    }
    return _xibVCS;
}
- (NSArray *)storyboardVCs{
    if (!_storyboardVCs) {
        _storyboardVCs = @[@"MBProHUDController"];
    }
    return _storyboardVCs;
}
- (NSArray *)vcClasses{
    if (!_vcClasses) {
        _vcClasses = [NSArray arrayWithArray:self.codeVCS];
        _vcClasses = [_vcClasses arrayByAddingObjectsFromArray:self.storyboardVCs];
        _vcClasses = [_vcClasses arrayByAddingObjectsFromArray:self.xibVCS];
    }
    return _vcClasses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Main";
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshTextFontName)];
    self.tableView.mj_header = header;
    
//    MJRefreshBackStateFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(addNewNurseList)];
//    self.tableView.mj_footer = footer;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifer = @"reuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifer];
    }
    cell.textLabel.text = self.data[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:[UIFont familyNames][arc4random() % [UIFont familyNames].count] size:14];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *className = self.vcClasses[indexPath.row];
    
    if ([self.codeVCS containsObject:className]) {
        UIViewController *subViewController = [[NSClassFromString(className) alloc] init];
        subViewController.title = self.data[indexPath.row];
        [self.navigationController pushViewController:subViewController animated:YES];
    }else if ([self.storyboardVCs containsObject:className]){
        UIStoryboard *board = [UIStoryboard storyboardWithName:className bundle:nil];
        UIViewController *vc = [board instantiateViewControllerWithIdentifier:className];
        vc.title = self.data[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([self.xibVCS containsObject:className]){
        UIViewController *subVC = [[NSClassFromString(className) alloc] initWithNibName:className bundle:nil];
        subVC.title = self.data[indexPath.row];
        [self.navigationController pushViewController:subVC animated:YES];
    }
}
- (void)refreshTextFontName{
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}

@end
