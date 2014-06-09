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
#import "SOSJobViewController.h"

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
        if([[json objectForKey:@"model"] isEqualToString:@"vetbiz.job"])
        {
            SOSJob * job=[self objectFromJson:json];
        
            job.business=[businesses objectForKey:[[json objectForKey:@"fields"] objectForKey:@"business" ]];
        
            if(job.business==nil)
            {
                NSLog(@"Failed to find business for key: %@",[[json objectForKey:@"fields"] objectForKey:@"business" ]);
            }
            [objects addObject:job];
        }
    }
    return objects;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = nil;//[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
   if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:nil];
    }
    
    SOSJob * job=[self.data objectAtIndex:indexPath.row];

    cell.textLabel.text=job.business.name;
    cell.detailTextLabel.text = job.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SOSJob * job=[self.data objectAtIndex:indexPath.row];
    SOSJobViewController * offerView=[[SOSJobViewController alloc] initWithJob:job];
    
    [self.navigationController  pushViewController:offerView animated:YES];
}

@end
