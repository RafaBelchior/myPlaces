//
//  AddPOIViewController.m
//  SegueMapa
//
//  Created by Rafael Souza Belchior da Silva on 04/03/15.
//  Copyright (c) 2015 Rafael Souza Belchior da Silva. All rights reserved.
//

#import "AddPOIViewController.h"

@interface AddPOIViewController ()
{
    POIData *poiAdd;
}
@end

@implementation AddPOIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    poiAdd = [POIData instance];
    [self.nameLabel becomeFirstResponder];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)save:(id)sender {
    POI *p = [[POI alloc] initWithObjectsName:_nameLabel.text andAddress:_addressLabel.text];
    [poiAdd.poidados addObject:p];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
