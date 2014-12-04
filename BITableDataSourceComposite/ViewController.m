//
//  ViewController.m
//  BITableDataSourceComposite
//
//  Created by Daniel Makurat on 04/12/14.
//  Copyright (c) 2014 Bright Inventions. All rights reserved.
//


#import "ViewController.h"
#import "BITableDataSourceComposite.h"
#import "FirstSampleTableViewDataSource.h"
#import "SecondSampleTableViewDataSource.h"


@interface ViewController ()

@end

@implementation ViewController {
    NSArray *_dataSources;
    BITableDataSourceComposite *_compositeDataSource;
}

- (void)loadView {
    [super loadView];
    _dataSources = @[[FirstSampleTableViewDataSource new], [SecondSampleTableViewDataSource new]];

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview: tableView];
    _compositeDataSource = [[BITableDataSourceComposite alloc] initWithDataSource:self];
    tableView.dataSource = _compositeDataSource;
}


- (void)viewDidLoad {
    [super viewDidLoad];


    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)allDataSourcesForTableDataSourceComposite:(BITableDataSourceComposite *)tableDataSourceComposite {
    return _dataSources;
}

- (BOOL)showHeadersForDataSourcesInTableDataSourceComposite:(BITableDataSourceComposite *)tableDataSourceComposite {
    return YES;
}

- (UITableViewCell *)dataSourceHeaderViewForTable:(UITableView *)tableView
                                  tableDataSource:(id <UITableViewDataSource>)source {
    static NSString* headerCellID = @"dataSourceHeaderCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: headerCellID];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: headerCellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"header for source: %@", @([_dataSources indexOfObject: source])];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}


@end