/*
 * Copyright (c) 2012 Mario Negro. All Rights Reserved
 *
 * This software is the confidential and proprietary information of
 * Mario Negro ("Confidential Information"). You shall not disclose such
 * Confidential Information and shall use it only in accordance with
 * the terms of the license agreement you entered into with Mario Negro.
 */

#import "ViewController.h"

@interface ViewController()

/**
 * Table view
 */
@property (nonatomic, readwrite, weak) IBOutlet UITableView *table;

/**
 * PTR manager
 */
@property (nonatomic, readwrite, strong) MNMPullToRefreshManager *pullToRefreshManager;

/**
 * Reloads (for testing purposes)
 */
@property (nonatomic, readwrite, assign) NSUInteger reloads;

/**
 * Loads the table and restores the PTR view to its initial state
 *
 * @private
 */
- (void)loadTable;

@end

@implementation ViewController

@synthesize table = table_;
@synthesize pullToRefreshManager = pullToRefreshManager_;
@synthesize reloads = reloads_;

#pragma mark -
#pragma mark View lifecycle

/**
 * Called after the controller’s view is loaded into memory.
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [table_ setBackgroundColor:[UIColor grayColor]];
    
    pullToRefreshManager_ = [[MNMPullToRefreshManager alloc] initWithPullToRefreshViewHeight:60.0f
                                                                                   tableView:table_
                                                                                  withClient:self];
}

#pragma mark -
#pragma mark Aux view methods

/*
 * Loads the table and restores the PTR view to its initial state
 */
- (void)loadTable {
    
    [table_ reloadData];
    
    [pullToRefreshManager_ tableViewReloadFinishedAnimated:YES];
}

#pragma mark -
#pragma mark UITableViewDelegate

/**
 * Asks the delegate for the height to use for a row in a specified location.
 *
 * @param tableView: The table-view object requesting this information.
 * @param indexPath: An index path that locates a row in tableView.
 * @return A floating-point value that specifies the height (in points) that row should be.
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [tableView rowHeight];
}

#pragma mark -
#pragma mark UITableViewDataSource

/**
 * Asks the data source to return the number of sections in the table view
 *
 * @param An object representing the table view requesting this information.
 * @return The number of sections in tableView.
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
	return 1;
}

/**
 * Asks the data source for a cell to insert in a particular location of the table view
 *
 * @param tableView: A table-view object requesting the cell.
 * @param indexPath: An index path locating a row in tableView.
 * @return An object inheriting from UITableViewCellthat the table view can use for the specified row.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	
	if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [[cell textLabel] setBackgroundColor:[UIColor clearColor]];
    }
    
    [[cell textLabel] setText:[NSString stringWithFormat:@"Row %i", indexPath.row]];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth( [cell frame]), CGRectGetHeight( [cell frame]))];
    
    if ([indexPath row] % 2 == 0) {
        
        [backgroundView setBackgroundColor:[UIColor colorWithWhite:0.8f alpha:1.0f]];
        
    } else {
        
        [backgroundView setBackgroundColor:[UIColor colorWithWhite:0.9f alpha:1.0f]];
    }
    
    [cell setBackgroundView:backgroundView];
    
    return cell;
}

/**
 * Tells the data source to return the number of rows in a given section of a table view
 *
 * @param tableView: The table-view object requesting this information.
 * @param section: An index number identifying a section in tableView.
 * @return The number of rows in section.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5 + (5 * reloads_);
}

#pragma mark -
#pragma mark MNMBottomPullToRefreshManagerClient

/**
 * This is the same delegate method as UIScrollView but required in MNMBottomPullToRefreshManagerClient protocol
 * to warn about its implementation. Here you have to call [MNMBottomPullToRefreshManager tableViewScrolled]
 *
 * Tells the delegate when the user scrolls the content view within the receiver.
 *
 * @param scrollView: The scroll-view object in which the scrolling occurred.
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [pullToRefreshManager_ tableViewScrolled];
}

/**
 * This is the same delegate method as UIScrollView but required in MNMBottomPullToRefreshClient protocol
 * to warn about its implementation. Here you have to call [MNMBottomPullToRefreshManager tableViewReleased]
 *
 * Tells the delegate when dragging ended in the scroll view.
 *
 * @param scrollView: The scroll-view object that finished scrolling the content view.
 * @param decelerate: YES if the scrolling movement will continue, but decelerate, after a touch-up gesture during a dragging operation.
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

    [pullToRefreshManager_ tableViewReleased];
}

/**
 * Tells client that refresh has been triggered
 * After reloading is completed must call [MNMPullToRefreshManager tableViewReloadFinishedAnimated:]
 *
 * @param manager PTR manager
 */
- (void)pullToRefreshTriggered:(MNMPullToRefreshManager *)manager {
    
    reloads_++;
    
    [self performSelector:@selector(loadTable) withObject:nil afterDelay:1.0f];
}

@end
