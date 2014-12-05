#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BITableDataSourceCompositeSectionsDataSource;

@interface BITableDataSourceComposite : NSObject<UITableViewDataSource>

@property (weak) id<BITableDataSourceCompositeSectionsDataSource> dataSource;

- (instancetype)initWithDataSource:(id <BITableDataSourceCompositeSectionsDataSource>)dataSource;
- (id)tableView:(UITableView *)tableView innerDataSourceForIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)tableView:(UITableView *)tableView innerIndexPathForIndexPath:(NSIndexPath *)indexPath;

@end

@protocol BITableDataSourceCompositeSectionsDataSource <NSObject>

-(NSArray *) allDataSourcesForTableDataSourceComposite:(BITableDataSourceComposite *) tableDataSourceComposite;
-(BOOL) showHeadersForDataSourcesInTableDataSourceComposite:(BITableDataSourceComposite *) tableDataSourceComposite;

@optional
- (UITableViewCell *)dataSourceHeaderViewForTable:(UITableView *)tableView tableDataSource:(id <UITableViewDataSource>)source;

@end