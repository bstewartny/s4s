//
//  SOSAppDelegate.m
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/6/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import "SOSAppDelegate.h"
#import <MapKit/MapKit.h>
#import "SOSOffersViewController.h"
#import "SOSJobsViewController.h"
#import "SOSCharityViewController.h"
#import "SOSPlacesViewController.h"


@implementation SOSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UITabBarController * rootController=[[UITabBarController alloc] init];

    SOSPlacesViewController * mapView=[[SOSPlacesViewController alloc] init];
    [mapView setTitle:@"Places"];
    UINavigationController * mapsView=[[UINavigationController alloc] initWithRootViewController:mapView];
    mapsView.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"Places" image:Nil tag:0];
   
    SOSOffersViewController * offersTable=[[SOSOffersViewController alloc] initWithStyle:UITableViewStylePlain];
    [offersTable setTitle:@"Offers"];
    UINavigationController * offersView=[[UINavigationController alloc] initWithRootViewController:offersTable];
    offersView.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"Offers" image:Nil tag:0];

    SOSJobsViewController * jobsTable=[[SOSJobsViewController alloc] initWithStyle:UITableViewStylePlain];
    [jobsTable setTitle:@"Jobs"];
    UINavigationController * jobsView=[[UINavigationController alloc] initWithRootViewController:jobsTable];
    jobsView.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"Jobs" image:Nil tag:0];

    SOSCharityViewController * charityTable=[[SOSCharityViewController alloc] initWithStyle:UITableViewStylePlain];
    [charityTable setTitle:@"Charities"];
    UINavigationController * charityView=[[UINavigationController alloc] initWithRootViewController:charityTable];
    charityView.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"Charity" image:Nil tag:0];
    
    rootController.viewControllers=@[mapsView,offersView,jobsView,charityView ];
    
    [self.window setRootViewController:rootController];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (CLLocationCoordinate2D) currentCoordinate
{
    CLLocationCoordinate2D coord;
    coord.latitude=40.440807;
    coord.longitude=-80.006561;
    return coord;
}

@end
