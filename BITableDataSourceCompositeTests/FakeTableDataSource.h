#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FakeTableDataSource : NSObject<UITableViewDataSource>

- (void)addSectionWithTitle:(NSString *)title numberOfRows:(NSInteger)numberOfRows;

-(UITableViewCell *) getCellForSection:(NSInteger) section row:(NSInteger) row;
-(NSString *) titleForSection:(NSInteger) section;

@end