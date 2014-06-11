//
//  SOSOfferViewController.h
//  StarsOnStripes
//
//  Created by Robert Stewart on 6/9/14.
//  Copyright (c) 2014 StarsOnStripes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOSOffer.h"

@interface SOSOfferViewController : UIViewController

@property(nonatomic,strong) IBOutlet UILabel * titleLabel;
@property(nonatomic,strong) IBOutlet UILabel * businessLabel;
@property(nonatomic,strong) IBOutlet UILabel * addressLabel;
@property(nonatomic,strong) IBOutlet UILabel * urlLabel;
@property(nonatomic,strong) IBOutlet UITextView * descriptionTextView;
@property(nonatomic,strong) SOSOffer * offer;
@property(nonatomic,strong) UIToolbar * blurView;
- (id) initWithOffer:(SOSOffer*)offer;

- (IBAction)share:(id)sender;
- (IBAction)getDirections:(id)sender;

@end
