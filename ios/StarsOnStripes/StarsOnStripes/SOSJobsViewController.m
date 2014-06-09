//
//  SOSJobsViewController.m
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/7/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import "SOSJobsViewController.h"
#import <CoreLocation/CLLocation.h>
#import "SOSAppDelegate.h"
@interface SOSJobsViewController ()

@end

@implementation SOSJobsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (NSString*) dataUrl
{
    CLLocationCoordinate2D coordinate=[((SOSAppDelegate*)[[UIApplication sharedApplication] delegate]) currentCoordinate];
    NSString *urlAsString = [NSString stringWithFormat:@"http://www.starsonstripes.com/vetbiz/api/jobs/?lat=%f&lon=%f&radius=%d", coordinate.latitude, coordinate.longitude, 50000000];
    NSLog(@"url: %@",urlAsString);
    return urlAsString;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
   if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault   reuseIdentifier:CellIdentifier];
    }
    NSDictionary *tempDictionary= [[self.data objectAtIndex:indexPath.row] objectForKey:@"fields"];

    cell.textLabel.text = [tempDictionary objectForKey:@"title"];

    return cell;
}

@end
