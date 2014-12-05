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
    UITableView *_tableView;
}

- (void)loadView {
    [super loadView];
    _dataSources = @[[FirstSampleTableViewDataSource new], [SecondSampleTableViewDataSource new]];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    _compositeDataSource = [[BITableDataSourceComposite alloc] initWithDataSource:self];
    _tableView.dataSource = _compositeDataSource;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BITableDataSourceComposite * composite = _tableView.dataSource;
    id dataSource = [composite tableView: _tableView innerDataSourceForIndexPath:indexPath];
    if(dataSource != nil){
        NSIndexPath* dataSourceIndexPath = [composite tableView: _tableView innerIndexPathForIndexPath:indexPath];

        NSUInteger dataSourceIndex = [_dataSources indexOfObject: dataSource];
        NSLog(@"Data source: %@, section: %@, row: %@", @(dataSourceIndex), @(dataSourceIndexPath.section), @(dataSourceIndexPath.row));
    }
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end