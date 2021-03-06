//
//  SOSDataViewController.h
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/8/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOSDataViewController : UITableViewController<UISearchBarDelegate>

@property(nonatomic) BOOL isSearching;
@property(nonatomic,strong) NSArray * data;
@property(nonatomic,strong) UIRefreshControl * refreshControl;
@property(nonatomic,strong) NSArray *searchData;
@property(nonatomic,strong) UISearchBar *searchBar;
@property(nonatomic,strong) UISearchDisplayController *searchController;
@property(nonatomic,strong) UIToolbar * blurView;
- (NSURL*) dataUrl;

- (id) objectFromJson:(NSDictionary*)json;

@end
