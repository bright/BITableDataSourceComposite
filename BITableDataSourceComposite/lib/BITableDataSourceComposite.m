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
        NSInteger numberOfSections = 1;
        if([tableViewDataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]){
            numberOfSections = [tableViewDataSource numberOfSectionsInTableView:tableView];
        }
        BITableViewDataSourceInfo *info = [BITableViewDataSourceInfo infoWithStartSection:sectionIndex endSection:(sectionIndex + numberOfSections) tableViewDataSource:tableViewDataSource];
        [info setStartsWithDataSourceHeaderSection: [self withHeadersForDataSources]];
        [tableSourcesInfo addObject:info];

        sectionIndex += numberOfSections;
        if([self withHeadersForDataSources]){
            sectionIndex += 1;
        }
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
    if([tableDataSourceInfo getSectionNumberForDataSourceHeader] == section) {
        return nil;
    }
    id <UITableViewDataSource> tableDataSource = tableDataSourceInfo.tableViewDataSource;
    if([tableDataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]){
        NSInteger mappedSection = section - [tableDataSourceInfo getFirstSectionForCell];
        return [tableDataSource tableView: tableView titleForHeaderInSection: mappedSection];
    } else {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BITableViewDataSourceInfo *tableDataSourceInfo = [self dataSourceInfoForSection:section inTableView:tableView];
    BOOL isDataSourceHeaderSection = [tableDataSourceInfo getSectionNumberForDataSourceHeader] == section;
    if(isDataSourceHeaderSection) return 1;
    NSInteger innerSection = section - [tableDataSourceInfo getFirstSectionForCell];
    return [tableDataSourceInfo.tableViewDataSource tableView:tableView numberOfRowsInSection:innerSection];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BITableViewDataSourceInfo *tableDataSourceInfo = [self dataSourceInfoForSection:indexPath.section inTableView:tableView];
    BOOL isDataSourceHeaderSection = [tableDataSourceInfo getSectionNumberForDataSourceHeader] == indexPath.section;
    id <UITableViewDataSource> tableDataSource = tableDataSourceInfo.tableViewDataSource;

    if (isDataSourceHeaderSection) {
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
    NSInteger section = indexPath.section - [tableDataSourceInfo getFirstSectionForCell];
    NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:section];
    return path;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self calculateNumberOfSectionsForTableView: tableView];
}

- (BOOL) withHeadersForDataSources {
    return [_dataSource showHeadersForDataSourcesInTableDataSourceComposite: self];
}

- (id<UITableViewDataSource>)tableView:(UITableView *)tableView innerDataSourceForIndexPath:(NSIndexPath *) indexPath{
    BITableViewDataSourceInfo *tableDataSourceInfo = [self dataSourceInfoForSection:indexPath.section inTableView:tableView];
    BOOL isSectionForDataSourceHeader = indexPath.section < [tableDataSourceInfo getFirstSectionForCell];
    if(isSectionForDataSourceHeader) {
        return nil;
    } else {
        return tableDataSourceInfo.tableViewDataSource;
    }
}

- (NSIndexPath *) tableView:(UITableView *)tableView innerIndexPathForIndexPath:(NSIndexPath *) indexPath {
    BITableViewDataSourceInfo *tableDataSourceInfo = [self dataSourceInfoForSection:indexPath.section inTableView:tableView];
    BOOL isSectionForDataSourceHeader = indexPath.section < [tableDataSourceInfo getFirstSectionForCell];
    if(isSectionForDataSourceHeader) {
        return nil;
    } else {
        return [self mapIndexPath:indexPath toTableDataSourceInfoIndexPath:tableDataSourceInfo];
    }
}

@end
