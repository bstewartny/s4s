//
//  SOSDataViewController.m
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/8/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import "SOSDataViewController.h"
#import <CoreLocation/CLLocation.h>
#import "SOSAppDelegate.h"

@interface SOSDataViewController ()

@end

@implementation SOSDataViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)objectFromJson:(NSDictionary *)json
{
    return json;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.refreshControl=[[UIRefreshControl alloc] init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTarget) forControlEvents:UIControlEventValueChanged];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
 
    UIBarButtonItem * searchButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search:)];
    self.navigationItem.rightBarButtonItem = searchButton;
    self.searchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 220, 44)];
    self.searchBar.delegate=self;
    [self.searchBar setShowsCancelButton:NO];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self getData];
}

- (void)search:(id)sender
{
    self.navigationItem.title=nil;
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:self.searchBar] animated:YES];
    [self.searchBar becomeFirstResponder];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelSearch:)];
    self.isSearching=YES;
    [self.tableView reloadData];
}

- (void)cancelSearch:(id)sender
{
    [self.searchBar resignFirstResponder];
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    UIBarButtonItem * searchButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search:)];
    self.navigationItem.title=@"Offers";
    self.navigationItem.rightBarButtonItem = searchButton;
    self.searchBar.text=nil;
    self.isSearching=NO;
    self.searchData=nil;
    [self.tableView reloadData];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.isSearching=YES;
    [self.tableView reloadData];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self doSearch:searchText];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self doSearch:searchBar.text];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    self.isSearching=NO;
    self.searchData=nil;
    [self.tableView reloadData];
}

-(void) doSearch:(NSString*)text
{
    self.isSearching=YES;
    self.searchData=[self.data filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name contains[cd] %@",text]];
    [self.tableView reloadData];
}

- (void) refreshTarget
{
    if(!self.isSearching)
    {
        [self getData];
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear");
    [self.tableView reloadData];
}

- (NSString*) dataUrl
{
    CLLocationCoordinate2D coordinate=[((SOSAppDelegate*)[[UIApplication sharedApplication] delegate]) currentCoordinate];
    NSString *urlAsString = [NSString stringWithFormat:@"http://www.starsonstripes.com/vetbiz/api/offers/?lat=%f&lon=%f&radius=%d", coordinate.latitude, coordinate.longitude, 50000000];
    NSLog(@"url: %@",urlAsString);
    return urlAsString;
}
- (void) getData
{
    NSURL *url = [[NSURL alloc] initWithString:[self dataUrl]];
   
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (error) {
            NSLog(@"error: %@",[error description]);
        } else {
            NSError * jsonError=NULL;
            self.data=[self parseJsonResults:data error:&jsonError];
            if(error)
            {
                NSLog(@"json error: %@",[jsonError description]);
            }
            else{
                NSLog(@"Got %d results",[self.data count]);
                dispatch_async(dispatch_get_main_queue(), ^{
                    // do work here
                    [self.refreshControl endRefreshing];
                    [self.tableView reloadData];
                });
            }
        }
    }];
}

- (NSArray*) parseJsonResults:(NSData*)data error:(NSError**)error
{
    NSError *localError = nil;
    
    NSArray *results = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSMutableArray * objects=[[NSMutableArray alloc] init];
    
    for(NSDictionary * json in results)
    {
        [objects addObject:[self objectFromJson:json]];
    }
    return objects;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(self.isSearching)
    {
        return [self.searchData count];
    }
    else
    {
        return [self.data count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
   if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault   reuseIdentifier:CellIdentifier];
    }
    NSDictionary *tempDictionary;
    
    if(self.isSearching)
    {
        tempDictionary= [[self.data objectAtIndex:indexPath.row] objectForKey:@"fields"];
   }
   else
   {
        tempDictionary= [[self.searchData objectAtIndex:indexPath.row] objectForKey:@"fields"];
   }
    cell.textLabel.text = [tempDictionary objectForKey:@"title"];

    return cell;
}

@end
