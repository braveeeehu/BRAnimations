//
//  ViewController.m
//  BRAnimations
//
//  Created by 1234 on 2016/10/4.
//  Copyright © 2016年 brave_hu. All rights reserved.
//

#import "ViewController.h"
#import "BRWaveView.h"
//#import <Foundation/Foundation.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)BRWaveView *tableHeaderView;
@property (nonatomic, strong)UIImageView *headImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *str = [NSString stringWithFormat:@"adf"];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.tableHeaderView;
    [self.tableHeaderView startWaveAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tab delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"第%ld行  开始动画",indexPath.row];
    }else {
        cell.textLabel.text = [NSString stringWithFormat:@"第%ld行   停止动画",indexPath.row];

    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        //start
        [self.tableHeaderView startWaveAnimation];
    }else {
        [self.tableHeaderView stopWaveAnimation];
    }
}

#pragma mark - lazy load
- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [UIImageView new];
        _headImageView.image = [UIImage imageNamed:@"image"];
        _headImageView.layer.cornerRadius = 13;
        _headImageView.layer.borderWidth = 2;
        _headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _headImageView.layer.masksToBounds = YES;
    }
    return _headImageView;
}

- (BRWaveView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [[BRWaveView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 120)];
        _tableHeaderView.backgroundColor = [UIColor redColor];
        __weak ViewController *weakSelf = self;
        NSInteger imageWidth = 50;
        _tableHeaderView.block = ^(CGPoint point ){
            weakSelf.headImageView.frame = CGRectMake(point.x - imageWidth/ 2, point.y - imageWidth, imageWidth, imageWidth) ;
        };
        [_tableHeaderView addSubview:self.headImageView];
    }
    return _tableHeaderView;
}

@end
