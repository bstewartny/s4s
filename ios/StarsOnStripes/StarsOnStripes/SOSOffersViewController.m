//
//  SOSOffersViewController.m
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/7/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import "SOSOffersViewController.h"
#import <CoreLocation/CLLocation.h>
#import "SOSAppDelegate.h"
#import "SOSOfferViewController.h"
#import "SOSOffer.h"
#import "NSDictionary+NSDictionary_NSNullHandling.h"
#import "SOSUrlBuilder.h"

@interface SOSOffersViewController ()

@end

@implementation SOSOffersViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (NSString*) backgroundImage
{
    return @"Jets.jpg";
}
- (NSURL*) dataUrl
{
    CLLocationCoordinate2D coordinate=[((SOSAppDelegate*)[[UIApplication sharedApplication] delegate]) currentCoordinate];
    
    return [SOSUrlBuilder buildUrlWithCommand:[NSString stringWithFormat:@"offers/?lat=%f&lon=%f&radius=%d", coordinate.latitude, coordinate.longitude, 50000000]];

}
- (id) objectFromJson:(NSDictionary *)json
{
    SOSOffer * offer=[[SOSOffer alloc] initFromJson:json];
    return offer;
}
-(void) doSearch:(NSString*)text
{
    self.isSearching=YES;
    self.searchData=[self.data filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(title contains[cd] %@) or (business.name contains[cd] %@)",text,text]];
    [self.tableView reloadData];
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
    
    NSMutableDictionary * businesses=[[NSMutableDictionary alloc] init];
    for(NSDictionary * json in results)
    {
        if([[json objectForKey:@"model"] isEqualToString:@"vetbiz.business"])
        {
            [businesses setObject:[[SOSPlace alloc] initFromJson:json] forKey:[json objectForKey:@"pk"]];
        }
    }
    for(NSDictionary * json in results)
    {
        if([[json objectForKey:@"model"] isEqualToString:@"vetbiz.offer"])
        {
            SOSOffer * offer=[self objectFromJson:json];
        
            offer.business=[businesses objectForKey:[[json objectForKey:@"fields"] objectForKey:@"business" ]];
        
            if(offer.business==nil)
            {
                NSLog(@"Failed to find business for key: %@",[[json objectForKey:@"fields"] objectForKey:@"business" ]);
            }
            [objects addObject:offer];
        }
    }
    return objects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell * cell=nil;//[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
   if (cell == nil) {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle   reuseIdentifier:nil];
     cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
     cell.backgroundColor=[UIColor clearColor];
      
        cell.textLabel.textColor=[UIColor whiteColor];
        cell.textLabel.font=[UIFont boldSystemFontOfSize:18.0];
        cell.detailTextLabel.textColor=[UIColor whiteColor];
        cell.detailTextLabel.font=[UIFont boldSystemFontOfSize:14.0];
    }
    SOSOffer * offer;
    if(self.isSearching)
    {
        offer=[self.searchData objectAtIndex:indexPath.row];
    }
    else
    {
        offer=[self.data objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = offer.business.name;
    
    cell.detailTextLabel.text=offer.title;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SOSOffer * offer;
    
    if(self.isSearching)
    {
        offer=[self.searchData objectAtIndex:indexPath.row];
    }
    else
    {
        offer=[self.data objectAtIndex:indexPath.row];
    }
    SOSOfferViewController * offerView=[[SOSOfferViewController alloc] initWithOffer:offer];
    
    [self.navigationController  pushViewController:offerView animated:YES];
}

@end
