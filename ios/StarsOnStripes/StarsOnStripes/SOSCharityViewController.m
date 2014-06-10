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
- (NSString*) backgroundImage
{
    return @"FemaleSoldier.jpg";
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
    UITableViewCell *cell = nil; //[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
   if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault   reuseIdentifier:nil];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
     cell.backgroundColor=[UIColor clearColor];
      
        cell.textLabel.textColor=[UIColor whiteColor];
        cell.textLabel.font=[UIFont boldSystemFontOfSize:18.0];
        cell.detailTextLabel.textColor=[UIColor whiteColor];
        cell.detailTextLabel.font=[UIFont boldSystemFontOfSize:14.0];
    }
    
    SOSCharity * charity;
    if(self.isSearching)
    {
        charity=[self.searchData objectAtIndex:indexPath.row];
    }
    else
    {
        charity=[self.data objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = charity.name;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SOSCharity * charity;
    if(self.isSearching)
    {
        charity=[self.searchData objectAtIndex:indexPath.row];
    }
    else
    {
        charity=[self.data objectAtIndex:indexPath.row];
    }
    SOSCharityDetailViewController * offerView=[[SOSCharityDetailViewController alloc] initWithCharity:charity];
    
    [self.navigationController  pushViewController:offerView animated:YES];
}
@end
