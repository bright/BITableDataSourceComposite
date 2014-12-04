#import <Foundation/Foundation.h>
#import "BITableDataSourceComposite.h"


@interface FakeBITableDataSourceCompositeSectionsDataSource : NSObject<BITableDataSourceCompositeSectionsDataSource>

- (void)addTableDataSource:(id <UITableViewDataSource>)tableDataSource;

- (void)showSuperHeaders:(BOOL)show;

- (UITableViewCell *)getDataSourceHeaderByIndex:(NSInteger)index;

@end