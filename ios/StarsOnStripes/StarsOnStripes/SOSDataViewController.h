//
//  SOSDataViewController.h
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/8/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOSDataViewController : UITableViewController

@property(nonatomic,strong) NSArray * data;
@property(nonatomic,strong) UIRefreshControl * refreshControl;
- (NSString*) dataUrl;

- (id) objectFromJson:(NSDictionary*)json;

@end
