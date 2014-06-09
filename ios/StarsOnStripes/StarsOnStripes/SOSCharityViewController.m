//
//  SOSCharityViewController.m
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/7/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import "SOSCharityViewController.h"
#import <CoreLocation/CLLocation.h>
#import "SOSAppDelegate.h"
#import "SOSCharity.h"
#import "SOSCharityDetailViewController.h"

@interface SOSCharityViewController ()

@end

@implementation SOSCharityViewController

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
    return [[SOSCharity alloc] initFromJson:json];
}
- (NSString*) dataUrl
{
    CLLocationCoordinate2D coordinate=[((SOSAppDelegate*)[[UIApplication sharedApplication] delegate]) currentCoordinate];
    NSString *urlAsString = [NSString stringWithFormat:@"http://www.starsonstripes.com/vetbiz/api/charities/?lat=%f&lon=%f&radius=%d", coordinate.latitude, coordinate.longitude, 50000000];
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
    
    SOSCharity * charity=[self.data objectAtIndex:indexPath.row];

    cell.textLabel.text = charity.name;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SOSCharity * charity=[self.data objectAtIndex:indexPath.row];
    SOSCharityDetailViewController * offerView=[[SOSCharityDetailViewController alloc] initWithCharity:charity];
    
    [self.navigationController  pushViewController:offerView animated:YES];
}
@end
