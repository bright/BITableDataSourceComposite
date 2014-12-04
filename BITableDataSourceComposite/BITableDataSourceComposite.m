#import <Foundation/Foundation.h>
#import "BITableDataSourceComposite.h"
#import "BITableViewDataSourceInfo.h"

@class BITableViewDataSourceInfo;

@implementation BITableDataSourceComposite {
    NSArray *_tableViewsDataSources;
}

- (instancetype)initWithDataSource:(id <BITableDataSourceCompositeSectionsDataSource>) dataSource {
    self = [super init];
    if (self) {
        _tableViewsDataSources = [dataSource allDataSourcesForTableDataSourceComposite: self];
        _dataSource = dataSource;
    }
    return self;
}

-(NSArray *) createTableDataSourceInfoForTable:(UITableView *) tableView {
    NSMutableArray *tableSourcesInfo = [NSMutableArray new];
    int sectionIndex = 0;
    for (id <UITableViewDataSource> tableViewDataSource in _tableViewsDataSources) {
        if([self withHeadersForDataSources]){
            sectionIndex += 1;
        }
        NSInteger numberOfSections = 1;
        if([tableViewDataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]){
            numberOfSections = [tableViewDataSource numberOfSectionsInTableView:tableView];
        }
        BITableViewDataSourceInfo *info = [BITableViewDataSourceInfo infoWithStartSection:sectionIndex endSection:(sectionIndex + numberOfSections - 1) tableViewDataSource:tableViewDataSource];
        sectionIndex += numberOfSections;
        [tableSourcesInfo addObject:info];
    }
    return tableSourcesInfo;
}

- (NSInteger)calculateNumberOfSectionsForTableView:(UITableView *)tableView {
    int numberOfSections = 0;

    for (id <UITableViewDataSource> tableViewDataSource in _tableViewsDataSources) {
        if([tableViewDataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]){
            numberOfSections += [tableViewDataSource numberOfSectionsInTableView:tableView];
        } else {
            numberOfSections += 1;
        }
    }
    numberOfSections += [_dataSource showHeadersForDataSourcesInTableDataSourceComposite: self] ? 1 * [_tableViewsDataSources count] : 0;
    return numberOfSections;
}

- (BITableViewDataSourceInfo *)dataSourceInfoForSection:(NSInteger)section inTableView:(UITableView *) tableView {
    NSArray *infos = [self createTableDataSourceInfoForTable: tableView];
    for(BITableViewDataSourceInfo *info in infos){
        if(section >= info.startSection && section <= info.endSection){
            return info;
        }
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    BITableViewDataSourceInfo *tableDataSourceInfo = [self dataSourceInfoForSection:section inTableView:tableView];
    if(tableDataSourceInfo == nil) return nil;
    id <UITableViewDataSource> tableDataSource = tableDataSourceInfo.tableViewDataSource;
    if([tableDataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]){
        return [tableDataSource tableView: tableView titleForHeaderInSection: (section - tableDataSourceInfo.startSection)];
    } else {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BITableViewDataSourceInfo *tableDataSourceInfo = [self dataSourceInfoForSection:section inTableView:tableView];
    if(tableDataSourceInfo == nil) return 1;
    return [tableDataSourceInfo.tableViewDataSource tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BITableViewDataSourceInfo *tableDataSourceInfo = [self dataSourceInfoForSection:indexPath.section inTableView:tableView];
    BOOL isDataSourceHeader = tableDataSourceInfo == nil;
    if(isDataSourceHeader) {
        tableDataSourceInfo = [self dataSourceInfoForSection:indexPath.section + 1 inTableView:tableView];
    }
    id <UITableViewDataSource> tableDataSource = tableDataSourceInfo.tableViewDataSource;

    if (isDataSourceHeader) {
        if([_dataSource respondsToSelector:@selector(dataSourceHeaderViewForTable:tableDataSource:)]){
            return [_dataSource dataSourceHeaderViewForTable:tableView tableDataSource:tableDataSource];
        } else {
            return [UITableViewCell new];
        }
    } else {
        NSIndexPath *newIndexPath = [self mapIndexPath:indexPath toTableDataSourceInfoIndexPath:tableDataSourceInfo];
        return [tableDataSource tableView:tableView cellForRowAtIndexPath:newIndexPath];
    }
}

- (NSIndexPath *)mapIndexPath:(NSIndexPath *)indexPath toTableDataSourceInfoIndexPath:(BITableViewDataSourceInfo *)tableDataSourceInfo {
    return [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section - tableDataSourceInfo.startSection];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self calculateNumberOfSectionsForTableView: tableView];
}

- (BOOL) withHeadersForDataSources {
    return [_dataSource showHeadersForDataSourcesInTableDataSourceComposite: self];
}

@end
