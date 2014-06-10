//
//  SOSDataViewController.h
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/8/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOSDataViewController : UITableViewController<UISearchBarDelegate, UISearchDisplayDelegate>

@property(nonatomic,strong) NSArray * data;
@property(nonatomic,strong) UIRefreshControl * refreshControl;
@property(nonatomic,strong) NSMutableArray *searchData;
@property(nonatomic,strong) UISearchBar *searchBar;
@property(nonatomic,strong) UISearchDisplayController *searchController;

- (NSString*) dataUrl;

- (id) objectFromJson:(NSDictionary*)json;

@end
