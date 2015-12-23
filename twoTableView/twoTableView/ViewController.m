//
//  ViewController.m
//  twoTableView
//
//  Created by hanhoo on 15/12/23.
//  Copyright © 2015年 hanhoo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *_array;
    NSMutableArray *_tab1_dataArray;
    NSMutableArray *_tab2_dataArray;
    
}
@property (nonatomic, strong) UITableView *tableView_1;
@property (nonatomic, strong) UITableView *tableView_2;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _tab1_dataArray = [NSMutableArray array];
    _tab2_dataArray = [NSMutableArray array];
    
    [self reloadData];
    
    [self createTab1];
    [self createTab2];
    
    
    NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self tableView:_tableView_1 didSelectRowAtIndexPath:firstPath];
}

- (void)reloadData
{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"left.plist" ofType:nil]];
    
    _array = dic[@"content"];
    for (NSDictionary *subDic in _array) {
        
        NSString *code = subDic[@"code"];
        NSString *name = subDic[@"name"];
        
        [_tab1_dataArray addObject:code];
//        [_tab2_dataArray addObject:name];
    }
//    [_tab2_dataArray addObject:_array[0]];
    
    NSLog(@"%@", _tab1_dataArray);
    NSLog(@"%@", _tab2_dataArray);
}

- (void)createTab1
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2, self.view.frame.size.height)];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    self.tableView_1 = tableView;
    [self.view addSubview:tableView];
}
- (void)createTab2
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width/2, self.view.frame.size.height)];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    self.tableView_2 = tableView;
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tableView_1) {
        
        return _tab1_dataArray.count;
    }else if(tableView == _tableView_2){
        
        return _tab2_dataArray.count;
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView_1) {
        static NSString *tab1 = @"tab1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tab1];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tab1];
        }
        cell.textLabel.text = _tab1_dataArray[indexPath.row];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.5];
        return cell;
        
    }else{
        
        static NSString *tab1 = @"tab2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tab1];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tab1];
        }
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
        cell.textLabel.text = _tab2_dataArray[0][@"name"];
        
        cell.backgroundColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:0.5];
        return cell;
    
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView_1) {
        
        [_tab2_dataArray removeAllObjects];
        [_tab2_dataArray addObject:_array[indexPath.row]];
        
        [_tableView_2 reloadData];
        
    }else{
        
        
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
