//
//  ProcessSortViewController.m
//  ActivityMonitor++
//
//  Created by st on 22/05/2013.
//  Copyright (c) 2013 st. All rights reserved.
//

#import "ProcessSort.h"
#import "iPadProcessSortViewController.h"

@interface iPadProcessSortViewController ()
@property (assign, nonatomic) SortFilter_t  currentFilter;
@end

@implementation iPadProcessSortViewController
@synthesize currentFilter;

#pragma mark - override

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        CGFloat rowHeight = [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        self.contentSizeForViewInPopover = CGSizeMake(300.0f, rowHeight * SORT_CHOICE_COUNT - 1); // -1 because for some reason a pixel gap appears.
        
        self.currentFilter = -1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - public

- (void)setFilter:(SortFilter_t)filter
{
    self.currentFilter = filter;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return SORT_CHOICE_COUNT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = nil;//[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == self.currentFilter)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    cell.textLabel.text = [NSString stringWithCString:sortChoices[indexPath.row] encoding:NSASCIIStringEncoding];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentFilter = indexPath.row;
    [self.sortDelegate processSortFilterChanged:self.currentFilter];
    
    // In order to checkmark the cell.
    [self.tableView reloadData];
}

@end