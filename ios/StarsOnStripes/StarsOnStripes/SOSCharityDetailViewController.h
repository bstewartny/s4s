//
//  SOSCharityDetailViewController.h
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/9/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOSCharity.h"

@interface SOSCharityDetailViewController : UIViewController

@property(nonatomic,strong) IBOutlet UILabel * nameLabel;
@property(nonatomic,strong) IBOutlet UILabel * pointsLabel;

@property(nonatomic,strong) IBOutlet UITextView * descriptionTextView;
@property(nonatomic,strong) SOSCharity * charity;

- (id) initWithCharity:(SOSCharity*)charity;

@end
