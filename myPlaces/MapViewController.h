//
//  MapViewController.h
//  SegueMapa
//
//  Created by Rafael Souza Belchior da Silva on 04/03/15.
//  Copyright (c) 2015 Rafael Souza Belchior da Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;
@import CoreLocation;

@interface MapViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property NSString *nameAnnotation;
@property NSString *addressAnnotation;
@property CLLocationCoordinate2D coordinateAnnotation;
@property long rowF;
@property MKPlacemark *thePlacemark;
@property (strong, nonatomic) NSString *allSteps;
- (IBAction)GoType:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
//-(void) findRoute:(MKPointAnnotation *)p;
-(void) clearRoute;
- (IBAction)locateAgain:(id)sender;



@end
