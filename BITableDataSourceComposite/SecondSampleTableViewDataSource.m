#import "SecondSampleTableViewDataSource.h"
#import <UIKit/UIKit.h>

@implementation SecondSampleTableViewDataSource {}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 8;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"second sample header section:%@", @(section)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert(indexPath.row <  5, @"number of rows is max 5");
    NSAssert(indexPath.section <  8, @"number of sections is max 8");
    static NSString* cellId = @"secondSampleCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"first sample DS %@ %@", @(indexPath.section), @(indexPath.row)];
    cell.backgroundColor = [UIColor greenColor];
    return cell;
}

@end