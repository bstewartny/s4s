//
//  SOSAppDelegate.h
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/6/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocation.h>

@interface SOSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (CLLocationCoordinate2D) currentCoordinate;
- (void) showLoginForm;
- (void) showRegisterForm;
@end
