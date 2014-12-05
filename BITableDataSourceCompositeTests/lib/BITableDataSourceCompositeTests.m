//
//  BITableDataSourceCompositeTests.m
//  BITableDataSourceCompositeTests
//
//  Created by Daniel Makurat on 04/12/14.
//  Copyright (c) 2014 Bright Inventions. All rights reserved.
//

#import <Specta/Specta.h>
#import "BITableDataSourceComposite.h"
#import "FakeTableDataSource.h"

#define EXP_SHORTHAND

#import "Expecta.h"
#import "FakeBITableDataSourceCompositeSectionsDataSource.h"

SpecBegin(BITableDataSourceComposite)

        __block FakeTableDataSource *firstDataSource = nil;
        __block FakeTableDataSource *secondDataSource = nil;
        __block FakeBITableDataSourceCompositeSectionsDataSource *compositeDataSource = nil;
        __block BITableDataSourceComposite *sut = nil;
        __block UITableView *tableView = nil;

        void (^expectCellWithIndexPathIsAHeaderForDataSourceWithNumber)(NSIndexPath *, NSInteger) = ^(NSIndexPath *indexPath, NSInteger sectionNumber) {
            UITableViewCell *cell = [sut tableView:tableView cellForRowAtIndexPath:indexPath];
            expect(cell).to.beIdenticalTo([compositeDataSource getDataSourceHeaderByIndex:sectionNumber]);
        };

        void (^expectCellFromCompositeTableToEqualCellFromTableDataSourceWithIndex)(NSIndexPath *, id <UITableViewDataSource>, NSIndexPath *) = ^(NSIndexPath *compositeTableCellIndexPath, id <UITableViewDataSource> dataSource, NSIndexPath *tableDataSourceCellIndexPath) {
            UITableViewCell *cell = [sut tableView:tableView cellForRowAtIndexPath:compositeTableCellIndexPath];
            UITableViewCell *cellFromTableDataSource = [dataSource tableView:tableView cellForRowAtIndexPath:tableDataSourceCellIndexPath];
            expect(cell).to.beIdenticalTo(cellFromTableDataSource);
        };

        describe(@"when init with one data source with 0 sections without superheader", ^{

            beforeEach(^{
                firstDataSource = [FakeTableDataSource new];
                compositeDataSource = [FakeBITableDataSourceCompositeSectionsDataSource new];
                [compositeDataSource showSuperHeaders:NO];
                [compositeDataSource addTableDataSource:firstDataSource];

                sut = [[BITableDataSourceComposite alloc] initWithDataSource:compositeDataSource];
                tableView = nil;
            });

            it(@"number of sections should be 0, one for first superheader", ^{
                expect([sut numberOfSectionsInTableView:tableView]).to.equal(0);
            });
        });

        describe(@"when init with two data source with 0 sections each without superheader", ^{

            beforeEach(^{
                firstDataSource = [FakeTableDataSource new];
                compositeDataSource = [FakeBITableDataSourceCompositeSectionsDataSource new];
                [compositeDataSource showSuperHeaders:NO];
                [compositeDataSource addTableDataSource:firstDataSource];

                sut = [[BITableDataSourceComposite alloc] initWithDataSource:compositeDataSource];
                tableView = nil;
            });

            it(@"number of sections should be 0, one for first superheader", ^{
                expect([sut numberOfSectionsInTableView:tableView]).to.equal(0);
            });
        });

        describe(@"when init with one data source with 0 sections with superheader", ^{

            beforeEach(^{
                firstDataSource = [FakeTableDataSource new];
                compositeDataSource = [FakeBITableDataSourceCompositeSectionsDataSource new];
                [compositeDataSource showSuperHeaders:YES];
                [compositeDataSource addTableDataSource:firstDataSource];

                sut = [[BITableDataSourceComposite alloc] initWithDataSource:compositeDataSource];
                tableView = nil;
            });

            it(@"number of sections should be 1, one for first superheader", ^{
                expect([sut numberOfSectionsInTableView:tableView]).to.equal(1);
            });

            it(@"title for section:0 should be nil", ^{
                expect([sut tableView:tableView titleForHeaderInSection:0]).to.equal(nil);
            });

            it(@"cell:0 from section:0 should be the header from data source:0", ^{
                expectCellWithIndexPathIsAHeaderForDataSourceWithNumber([NSIndexPath indexPathForRow:0 inSection:0], 0);
            });
        });

        describe(@"when init with one data source with one section with 0 rows without superheader", ^{

            beforeEach(^{
                firstDataSource = [FakeTableDataSource new];
                [firstDataSource addSectionWithTitle:@"first section" numberOfRows:0];
                compositeDataSource = [FakeBITableDataSourceCompositeSectionsDataSource new];
                [compositeDataSource showSuperHeaders:NO];
                [compositeDataSource addTableDataSource:firstDataSource];

                sut = [[BITableDataSourceComposite alloc] initWithDataSource:compositeDataSource];
                tableView = nil;
            });

            it(@"number of sections should be 1, one for first superheader", ^{
                expect([sut numberOfSectionsInTableView:tableView]).to.equal(1);
            });

            it(@"title for section:0 should be nil", ^{
                expect([sut tableView:tableView titleForHeaderInSection:0]).to.equal(@"first section");
            });
        });

        describe(@"when init with one data source with one section with 0 rows with superheader", ^{

            beforeEach(^{
                firstDataSource = [FakeTableDataSource new];
                [firstDataSource addSectionWithTitle:@"first section" numberOfRows:0];
                compositeDataSource = [FakeBITableDataSourceCompositeSectionsDataSource new];
                [compositeDataSource showSuperHeaders:YES];
                [compositeDataSource addTableDataSource:firstDataSource];

                sut = [[BITableDataSourceComposite alloc] initWithDataSource:compositeDataSource];
                tableView = nil;
            });

            it(@"number of sections should be 2, one for first superheader", ^{
                expect([sut numberOfSectionsInTableView:tableView]).to.equal(2);
            });

            it(@"title for section:0 should be nil", ^{
                expect([sut tableView:tableView titleForHeaderInSection:0]).to.equal(nil);
            });

            it(@"title for section:1 should be nil", ^{
                expect([sut tableView:tableView titleForHeaderInSection:1]).to.equal(@"first section");
            });

            it(@"cell:0 from section:0 should be the header from data source:0", ^{
                expectCellWithIndexPathIsAHeaderForDataSourceWithNumber([NSIndexPath indexPathForRow:0 inSection:0], 0);
            });
        });

        describe(@"when init with one data source with one row with superheader", ^{

            beforeEach(^{
                firstDataSource = [FakeTableDataSource new];
                [firstDataSource addSectionWithTitle:@"first section" numberOfRows:1];
                compositeDataSource = [FakeBITableDataSourceCompositeSectionsDataSource new];
                [compositeDataSource showSuperHeaders:YES];
                [compositeDataSource addTableDataSource:firstDataSource];

                sut = [[BITableDataSourceComposite alloc] initWithDataSource:compositeDataSource];
                tableView = nil;
            });

            it(@"number of sections should be 2, one for first superheader and one for first row", ^{
                expect([sut numberOfSectionsInTableView:tableView]).to.equal(2);
            });

            it(@"title for section:0 should be nil", ^{
                expect([sut tableView:tableView titleForHeaderInSection:0]).to.equal(nil);
            });

            it(@"title for section:1 should be 'first section'", ^{
                expect([sut tableView:tableView titleForHeaderInSection:1]).to.equal(@"first section");
            });

            it(@"cell:0 from section:0 should be the header from data source:0", ^{
                expectCellWithIndexPathIsAHeaderForDataSourceWithNumber([NSIndexPath indexPathForRow:0 inSection:0], 0);
            });

            it(@"cell: 0 for section:1 should equal cell:0 for table data source:0", ^{
                expectCellFromCompositeTableToEqualCellFromTableDataSourceWithIndex(
                        [NSIndexPath indexPathForRow:0 inSection:1],
                        firstDataSource,
                        [NSIndexPath indexPathForRow:0 inSection:0]
                );
            });
        });

        describe(@"when init with one data source with one row without superheader", ^{

            beforeEach(^{
                firstDataSource = [FakeTableDataSource new];
                [firstDataSource addSectionWithTitle:@"first section" numberOfRows:1];
                compositeDataSource = [FakeBITableDataSourceCompositeSectionsDataSource new];
                [compositeDataSource showSuperHeaders:NO];
                [compositeDataSource addTableDataSource:firstDataSource];

                sut = [[BITableDataSourceComposite alloc] initWithDataSource:compositeDataSource];
                tableView = nil;
            });

            it(@"number of sections should be 1, one for first superheader and one for first row", ^{
                expect([sut numberOfSectionsInTableView:tableView]).to.equal(1);
            });

            it(@"title for first section should be nil", ^{
                expect([sut tableView:tableView titleForHeaderInSection:0]).to.equal(@"first section");
            });

            it(@"first cell from first section should be first cell for first table data source", ^{
                expectCellFromCompositeTableToEqualCellFromTableDataSourceWithIndex(
                        [NSIndexPath indexPathForRow:0 inSection:0],
                        firstDataSource,
                        [NSIndexPath indexPathForRow:0 inSection:0]
                );
            });
        });

        describe(@"when init with two data sources first (with 2 sections and 2 rows for each section), second data source with (3 rows), with headers for data sources", ^{

            beforeEach(^{
                firstDataSource = [FakeTableDataSource new];
                [firstDataSource addSectionWithTitle:@"1: first section" numberOfRows:2];
                [firstDataSource addSectionWithTitle:@"1: second section" numberOfRows:2];

                secondDataSource = [FakeTableDataSource new];
                [secondDataSource addSectionWithTitle:@"2: first section" numberOfRows:3];

                compositeDataSource = [FakeBITableDataSourceCompositeSectionsDataSource new];
                [compositeDataSource showSuperHeaders:YES];
                [compositeDataSource addTableDataSource:firstDataSource];
                [compositeDataSource addTableDataSource:secondDataSource];

                sut = [[BITableDataSourceComposite alloc] initWithDataSource:compositeDataSource];
                tableView = nil;
            });

            it(@"number of sections should be 5, 3 real sections, 2 invisible for data source headers", ^{
                expect([sut numberOfSectionsInTableView:tableView]).to.equal(5);
            });

            it(@"title for section:0 should be nil", ^{
                expect([sut tableView:tableView titleForHeaderInSection:0]).to.equal(nil);
            });

            it(@"title for section:1 should be '1: first section'", ^{
                expect([sut tableView:tableView titleForHeaderInSection:1]).to.equal(@"1: first section");
            });

            it(@"title for section:2 should be '1: second section'", ^{
                expect([sut tableView:tableView titleForHeaderInSection:2]).to.equal(@"1: second section");
            });

            it(@"title for section:3 should be nil", ^{
                expect([sut tableView:tableView titleForHeaderInSection:3]).to.equal(nil);
            });

            it(@"title for section:4 should be '2: first section'", ^{
                expect([sut tableView:tableView titleForHeaderInSection:4]).to.equal(@"2: first section");
            });

            it(@"cell:0 from section:0 should be header for data source:0", ^{
                expectCellWithIndexPathIsAHeaderForDataSourceWithNumber([NSIndexPath indexPathForRow:0 inSection:0], 0);
            });

            it(@"cell:0 from section:3 section should be header for data source:1", ^{
                expectCellWithIndexPathIsAHeaderForDataSourceWithNumber([NSIndexPath indexPathForRow:0 inSection:3], 1);
            });

            it(@"cell:0 for section:1 should equal cell:0 section:0 for table data source:0", ^{
                expectCellFromCompositeTableToEqualCellFromTableDataSourceWithIndex(
                        [NSIndexPath indexPathForRow:0 inSection:1],
                        firstDataSource,
                        [NSIndexPath indexPathForRow:0 inSection:0]
                );
            });

            it(@"cell:1 for section:1 should equal cell:1 section:0 for table data source:0", ^{
                expectCellFromCompositeTableToEqualCellFromTableDataSourceWithIndex(
                        [NSIndexPath indexPathForRow:1 inSection:1],
                        firstDataSource,
                        [NSIndexPath indexPathForRow:1 inSection:0]
                );
            });

            it(@"cell:0 for section:2 should equal cell:0 section:1 for table data source:0", ^{
                expectCellFromCompositeTableToEqualCellFromTableDataSourceWithIndex(
                        [NSIndexPath indexPathForRow:0 inSection:2],
                        firstDataSource,
                        [NSIndexPath indexPathForRow:0 inSection:1]
                );
            });

            it(@"cell:0 for section:4 should equal cell:0 section:0 for table data source:1", ^{
                expectCellFromCompositeTableToEqualCellFromTableDataSourceWithIndex(
                        [NSIndexPath indexPathForRow:0 inSection:4],
                        secondDataSource,
                        [NSIndexPath indexPathForRow:0 inSection:0]
                );
            });

            it(@"cell:1 for section:4 should equal cell:1 section:0 for table data source:1", ^{
                expectCellFromCompositeTableToEqualCellFromTableDataSourceWithIndex(
                        [NSIndexPath indexPathForRow:1 inSection:4],
                        secondDataSource,
                        [NSIndexPath indexPathForRow:1 inSection:0]
                );
            });

            it(@"cell:2 for section:4 should equal cell:2 section:0 for table data source:1", ^{
                expectCellFromCompositeTableToEqualCellFromTableDataSourceWithIndex(
                        [NSIndexPath indexPathForRow:2 inSection:4],
                        secondDataSource,
                        [NSIndexPath indexPathForRow:2 inSection:0]
                );
            });

            it(@"tableView:innerIndexPathForIndexPath: S:0 R:0 is nil", ^{
                NSIndexPath *indexPath = [sut tableView:tableView innerIndexPathForIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                expect(indexPath).to.beNil();
            });

            it(@"tableView:innerIndexPathForIndexPath: S:1 R:0 is S:0 R:0", ^{
                NSIndexPath *indexPath = [sut tableView:tableView innerIndexPathForIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
                expect(indexPath.section).to.equal(0);
                expect(indexPath.row).to.equal(0);
            });

            it(@"tableView:innerIndexPathForIndexPath: S:1 R:1 is S:0 R:1", ^{
                NSIndexPath *indexPath = [sut tableView:tableView innerIndexPathForIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
                expect(indexPath.section).to.equal(0);
                expect(indexPath.row).to.equal(1);
            });

            it(@"tableView:innerIndexPathForIndexPath: S:2 R:0 is S:1 R:0", ^{
                NSIndexPath *indexPath = [sut tableView:tableView innerIndexPathForIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
                expect(indexPath.section).to.equal(1);
                expect(indexPath.row).to.equal(0);
            });

            it(@"tableView:innerIndexPathForIndexPath: S:2 R:1 is S:1 R:1", ^{
                NSIndexPath *indexPath = [sut tableView:tableView innerIndexPathForIndexPath:[NSIndexPath indexPathForRow:1 inSection:2]];
                expect(indexPath.section).to.equal(1);
                expect(indexPath.row).to.equal(1);
            });

            it(@"tableView:innerIndexPathForIndexPath: S:3 R:0 is nil", ^{
                NSIndexPath *indexPath = [sut tableView:tableView innerIndexPathForIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
                expect(indexPath).to.beNil();
            });

            it(@"tableView:innerIndexPathForIndexPath: S:4 R:0 is S:0 R:0", ^{
                NSIndexPath *indexPath = [sut tableView:tableView innerIndexPathForIndexPath:[NSIndexPath indexPathForRow:0 inSection:4]];
                expect(indexPath.section).to.equal(0);
                expect(indexPath.row).to.equal(0);
            });

            it(@"tableView:innerIndexPathForIndexPath: S:4 R:1 is S:0 R:1", ^{
                NSIndexPath *indexPath = [sut tableView:tableView innerIndexPathForIndexPath:[NSIndexPath indexPathForRow:1 inSection:4]];
                expect(indexPath.section).to.equal(0);
                expect(indexPath.row).to.equal(1);
            });

            //
            it(@"tableView:innerDataSourceForIndexPath: S:0 R:0 is nil", ^{
                id<UITableViewDataSource> dataSource = [sut tableView:tableView innerDataSourceForIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                expect(dataSource).to.beNil();
            });

            it(@"tableView:innerDataSourceForIndexPath: S:1 R:0 is DS:0", ^{
                id<UITableViewDataSource> dataSource = [sut tableView:tableView innerDataSourceForIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
                expect(dataSource).to.beIdenticalTo(firstDataSource);
            });

            it(@"tableView:innerDataSourceForIndexPath: S:1 R:1 is S:0 R:1", ^{
                id<UITableViewDataSource> dataSource = [sut tableView:tableView innerDataSourceForIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
                expect(dataSource).to.beIdenticalTo(firstDataSource);
            });

            it(@"tableView:innerDataSourceForIndexPath: S:2 R:0 is S:1 R:0", ^{
                id<UITableViewDataSource> dataSource = [sut tableView:tableView innerDataSourceForIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
                expect(dataSource).to.beIdenticalTo(firstDataSource);
            });

            it(@"tableView:innerDataSourceForIndexPath: S:2 R:1 is S:1 R:1", ^{
                id<UITableViewDataSource> dataSource = [sut tableView:tableView innerDataSourceForIndexPath:[NSIndexPath indexPathForRow:1 inSection:2]];
                expect(dataSource).to.beIdenticalTo(firstDataSource);
            });

            it(@"tableView:innerIndexPathForIndexPath: S:3 R:0 is nil", ^{
                id<UITableViewDataSource> dataSource = [sut tableView:tableView innerDataSourceForIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
                expect(dataSource).to.beNil();
            });

            it(@"tableView:innerDataSourceForIndexPath: S:4 R:0 is S:0 R:0", ^{
                id<UITableViewDataSource> dataSource = [sut tableView:tableView innerDataSourceForIndexPath:[NSIndexPath indexPathForRow:0 inSection:4]];
                expect(dataSource).to.beIdenticalTo(secondDataSource);
            });

            it(@"tableView:innerDataSourceForIndexPath: S:4 R:1 is S:0 R:1", ^{
                id<UITableViewDataSource> dataSource = [sut tableView:tableView innerDataSourceForIndexPath:[NSIndexPath indexPathForRow:1 inSection:4]];
                expect(dataSource).to.beIdenticalTo(secondDataSource);
            });

        });

SpecEnd