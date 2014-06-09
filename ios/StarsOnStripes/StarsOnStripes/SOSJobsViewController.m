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
#import "SOSJob.h"
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

- (id) objectFromJson:(NSDictionary *)json
{
    return [[SOSJob alloc] initFromJson:json];
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
    UITableViewCell *cell = nil;//[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
   if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:nil];
    }
    
    SOSJob * job=[self.data objectAtIndex:indexPath.row];

    cell.textLabel.text = job.title;
    
    return cell;
}

@end
