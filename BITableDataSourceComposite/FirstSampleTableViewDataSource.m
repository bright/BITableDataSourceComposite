#import "FirstSampleTableViewDataSource.h"


@implementation FirstSampleTableViewDataSource {

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"first sample header section:%@", @(section)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert(indexPath.row <  10, @"number of rows is max 10");
    NSAssert(indexPath.section <  3, @"number of sections is max 3");

    static NSString* cellId = @"firstSampleCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"first sample DS %@ %@", @(indexPath.section), @(indexPath.row)];
    return cell;
}

@end