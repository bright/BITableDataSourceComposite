#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BITableViewDataSourceInfo : NSObject

@property (nonatomic) NSInteger startSection;
@property (nonatomic) NSInteger endSection;
@property (nonatomic) id<UITableViewDataSource> tableViewDataSource;

- (instancetype)initWithStartSection:(NSInteger)startSection endSection:(NSInteger)endSection tableViewDataSource:(id <UITableViewDataSource>)tableViewDataSource;

+ (instancetype)infoWithStartSection:(NSInteger)startSection endSection:(NSInteger)endSection tableViewDataSource:(id <UITableViewDataSource>)tableViewDataSource;

@end