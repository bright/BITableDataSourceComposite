#import "FakeTableDataSource.h"

@implementation FakeTableDataSource {
    NSMutableArray *_sectionsRows;
    NSMutableArray *_sectionsTitles;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _sectionsRows = [NSMutableArray new];
        _sectionsTitles = [NSMutableArray new];
    }
    return self;
}

-(void) addSectionWithTitle: (NSString *) title numberOfRows:(NSInteger)numberOfRows {
    [_sectionsTitles addObject:title];
    NSMutableArray *rows = [NSMutableArray new];
    [_sectionsRows addObject: rows];

    for(NSInteger i = 0; i < numberOfRows; i++){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text = [NSString stringWithFormat:@"%@:%@", title, @(i)];
        [rows addObject:cell];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_sectionsRows[(NSUInteger) section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _sectionsRows[(NSUInteger) indexPath.section][(NSUInteger) indexPath.row];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _sectionsTitles[(NSUInteger) section];
}

- (UITableViewCell *)getCellForSection:(NSInteger)section row:(NSInteger)row {
    return _sectionsRows[(NSUInteger) section][(NSUInteger) row];
}

- (NSString *)titleForSection:(NSInteger)section {
    return _sectionsTitles[(NSUInteger) section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_sectionsTitles count];
}


@end