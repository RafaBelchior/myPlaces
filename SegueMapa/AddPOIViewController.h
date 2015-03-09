//
//  AddPOIViewController.h
//  SegueMapa
//
//  Created by Rafael Souza Belchior da Silva on 04/03/15.
//  Copyright (c) 2015 Rafael Souza Belchior da Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "POI.h"
#import "POIData.h"

@interface AddPOIViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressLabel;
- (IBAction)save:(id)sender;

@end
