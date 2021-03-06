//
//  SOSPlaceViewController.h
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/9/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOSPlace.h"

@interface SOSPlaceViewController : UIViewController

@property(nonatomic,strong) IBOutlet UILabel * nameLabel;
@property(nonatomic,strong) IBOutlet UILabel * addressLabel;
@property(nonatomic,strong) IBOutlet UILabel * phoneLabel;
@property(nonatomic,strong) IBOutlet UILabel * urlLabel;
@property(nonatomic,strong) IBOutlet UITextView * descriptionTextView;
@property(nonatomic,strong) SOSPlace * place;
@property(nonatomic,strong) UIToolbar * blurView;
- (id) initWithPlace:(SOSPlace*)place;

- (IBAction)getDirections:(id)sender;

@end
