#import "BITableViewDataSourceInfo.h"


@implementation BITableViewDataSourceInfo
- (instancetype)initWithStartSection:(NSInteger)startSection endSection:(NSInteger)endSection tableViewDataSource:(id <UITableViewDataSource>)tableViewDataSource {
    self = [super init];
    if (self) {
        self.startSection = startSection;
        self.endSection = endSection;
        self.tableViewDataSource = tableViewDataSource;
    }
    return self;
}

+ (instancetype)infoWithStartSection:(NSInteger)startSection endSection:(NSInteger)endSection tableViewDataSource:(id <UITableViewDataSource>)tableViewDataSource {
    return [[self alloc] initWithStartSection:startSection endSection:endSection tableViewDataSource:tableViewDataSource];
}

@end