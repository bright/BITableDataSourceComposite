#import "FakeBITableDataSourceCompositeSectionsDataSource.h"


@implementation FakeBITableDataSourceCompositeSectionsDataSource {
    NSMutableArray *_dataSources;
    NSMutableArray * _headersForDataSource;
    BOOL _showSuperHeaders;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _dataSources = [NSMutableArray new];
        _headersForDataSource = [NSMutableArray new];
    }
    return self;
}

-(void) addTableDataSource:(id<UITableViewDataSource>) tableDataSource {
    [_dataSources addObject: tableDataSource];
    UITableViewCell *headerCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    headerCell.textLabel.text = [NSString stringWithFormat:@"header: %@", @([_headersForDataSource count] + 1)];
    [_headersForDataSource addObject:headerCell];
}

-(void) showSuperHeaders:(BOOL) show {
    _showSuperHeaders = show;
}

- (NSArray *)allDataSourcesForTableDataSourceComposite:(BITableDataSourceComposite *)tableDataSourceComposite {
    return _dataSources;
}

- (BOOL)showHeadersForDataSourcesInTableDataSourceComposite:(BITableDataSourceComposite *)tableDataSourceComposite {
    return _showSuperHeaders;
}

-(UITableViewCell *)getDataSourceHeaderByIndex:(NSInteger) index {
    return _headersForDataSource[(NSUInteger) index];
}

- (UITableViewCell *)dataSourceHeaderViewForTable:(UITableView *)tableView tableDataSource:(id <UITableViewDataSource>)tableDataSource {
    NSInteger index = [_dataSources indexOfObject: tableDataSource];
    return _headersForDataSource[(NSUInteger) index];
}



@end