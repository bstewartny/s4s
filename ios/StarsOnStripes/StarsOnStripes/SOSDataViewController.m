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
#import "ProgressHUD.h"
#import "SOSUrlBuilder.h"
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
- (NSString*) backgroundImage
{
    return @"Jets.png";
}
- (void) viewWillDisappear:(BOOL)animated
{
    self.blurView.alpha=0.0;
}
- (void) viewDidAppear:(BOOL)animated
{
    if([self.data count]>0)
    {
        if(self.blurView.alpha==0.0)
        {
        [UIView animateWithDuration:0.7 animations:^{
                            [self.blurView setAlpha:1.0];
                        }];
        }
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    //self.tableView.separatorColor=[UIColor clearColor];
    self.tableView.separatorInset=UIEdgeInsetsMake(0, 20, 0, 20);
   
    UIImageView * iv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:[self backgroundImage]]];
    self.tableView.backgroundView=iv;
    self.refreshControl=[[UIRefreshControl alloc] init];
   self.refreshControl.tintColor=[UIColor whiteColor];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTarget) forControlEvents:UIControlEventValueChanged];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.backgroundView.layer.zPosition -= 1;
    
    self.blurView=[[UIToolbar alloc] initWithFrame:CGRectMake(10, 0, 300, 1136)];
    self.blurView.barStyle=UIBarStyleBlackTranslucent;
    self.blurView.alpha=0.0;
    self.blurView.hidden=NO;
    [self.tableView.backgroundView addSubview:self.blurView];
    //[self.tableView addSubview:self.blurView];
    //self.blurView.layer.zPosition-=1;
    
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
        //self.data=nil;
        //[self.tableView reloadData];
        [self getData];
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear");
    [self.tableView reloadData];
}

- (NSURL*) dataUrl
{
    CLLocationCoordinate2D coordinate=[((SOSAppDelegate*)[[UIApplication sharedApplication] delegate]) currentCoordinate];
   
    return [SOSUrlBuilder buildUrlWithCommand:[NSString stringWithFormat:@"offers/?lat=%f&lon=%f&radius=%d", coordinate.latitude, coordinate.longitude, 50000000]];
}
- (void) getData
{
    //self.blurView.alpha=0.0;
    [ProgressHUD show:@"Loading..."];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:[self dataUrl]] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ProgressHUD dismiss];
        });
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (error) {
            NSLog(@"error: %@",[error description]);
            dispatch_async(dispatch_get_main_queue(), ^{
                [ProgressHUD showError:[error description]];
            });
        } else {
            NSError * jsonError=NULL;
            self.data=[self parseJsonResults:data error:&jsonError];
            if(error)
            {
                NSLog(@"json error: %@",[jsonError description]);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [ProgressHUD showError:[jsonError description]];
                });
            }
            else{
                NSLog(@"Got %d results",[self.data count]);
                dispatch_async(dispatch_get_main_queue(), ^{
                    // do work here
                    [self.refreshControl endRefreshing];
                    
                    [self.tableView reloadData];
                    
                    if(self.blurView.alpha==0.0)
                    {
                        [UIView animateWithDuration:0.3 animations:^{
                            [self.blurView setAlpha:1.0];
                        }];
                    }
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
    cell.backgroundColor=[UIColor clearColor];
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
