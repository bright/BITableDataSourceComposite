#import "BITableViewDataSourceInfo.h"


@implementation BITableViewDataSourceInfo {
    BOOL _startsWithDataSourceHeaderSection;
}
- (instancetype)initWithStartSection:(NSInteger)startSection endSection:(NSInteger)endSection tableViewDataSource:(id <UITableViewDataSource>)tableViewDataSource {
    self = [super init];
    if (self) {
        self.startSection = startSection;
        self.endSection = endSection;
        self.tableViewDataSource = tableViewDataSource;
    }
    return self;
}

-(void) setStartsWithDataSourceHeaderSection:(BOOL) startsWithDataSourceHeaderSection {
    _startsWithDataSourceHeaderSection = startsWithDataSourceHeaderSection;
}

+ (instancetype)infoWithStartSection:(NSInteger)startSection endSection:(NSInteger)endSection tableViewDataSource:(id <UITableViewDataSource>)tableViewDataSource {
    return [[self alloc] initWithStartSection:startSection endSection:endSection tableViewDataSource:tableViewDataSource];
}

- (NSInteger)getSectionNumberForDataSourceHeader {
    return _startsWithDataSourceHeaderSection ? self.startSection : -1;
}

-(NSInteger) getFirstSectionForCell {
    return _startsWithDataSourceHeaderSection ? self.startSection + 1 : self.startSection;
}

@end