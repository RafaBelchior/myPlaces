//
//  MapViewController.m
//  SegueMapa
//
//  Created by Rafael Souza Belchior da Silva on 04/03/15.
//  Copyright (c) 2015 Rafael Souza Belchior da Silva. All rights reserved.
//

#import "MapViewController.h"
#import "POITableViewController.h"
#import "POIData.h"
#import "POI.h"
#import "RoutePOITableViewController.h"


@interface MapViewController ()
{
    POIData *poiMapa;
    MKPointAnnotation *point;
    
    NSMutableArray *stepByStep ;
}
@end

@implementation MapViewController
CLLocationManager *locationManager;
CLGeocoder *geocoder;
CLPlacemark *placemark;
MKRoute *routeDetails;
@synthesize mapView, coordinateAnnotation, nameAnnotation, addressAnnotation;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    locationManager = [[CLLocationManager alloc] init];
    [locationManager requestWhenInUseAuthorization];
    poiMapa = [POIData instance];
    self.mapView.delegate = self;
    stepByStep = [[NSMutableArray alloc] init];
    [self.mapView addAnnotation:[self getAnnotation]];
    [locationManager startUpdatingLocation];
    [self locate];
    
}

-(MKPointAnnotation *) getAnnotation{
    point = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D destLocation;
    destLocation.latitude = [[poiMapa.poidados objectAtIndex:_rowF] poiLatitude];
    destLocation.longitude = [[poiMapa.poidados objectAtIndex:_rowF] poiLongitude];
    point.coordinate = destLocation;
    point.title = [[poiMapa.poidados objectAtIndex:_rowF] poiName];
    point.subtitle = [[poiMapa.poidados objectAtIndex:_rowF] poiAddress];
    
    return point;
}

//-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {

//    MKAnnotationView *av = [[MKAnnotationView alloc] init];
    
        
//        av.image = [UIImage imageNamed:@"icon.png"];
//        av.canShowCallout = YES;
//        av.centerOffset = CGPointMake(0, -27);
//    
//        return av;
//    
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //[self locate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 700, 700);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];

}

-(void) viewWillAppear:(BOOL)animated{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([self getAnnotation].coordinate, 700, 700);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"Route"])
    {
        
        RoutePOITableViewController *RoutePOITableViewController = [segue destinationViewController];
        RoutePOITableViewController.routeArray = [[NSMutableArray alloc] init];
        RoutePOITableViewController.routeArray = stepByStep;

    }
}





-(void)findRoute:(MKPointAnnotation *)p andType:(MKDirectionsTransportType)t{
    MKDirectionsRequest *directionsRequest = [[MKDirectionsRequest alloc] init];
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:p.coordinate addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil]];
    [directionsRequest setSource:[MKMapItem mapItemForCurrentLocation]];
    [directionsRequest setDestination:[[MKMapItem alloc] initWithPlacemark:placemark]];
    directionsRequest.transportType = t;
    MKDirections *directions = [[MKDirections alloc] initWithRequest:directionsRequest];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        [stepByStep removeAllObjects];
        if (error) {
            NSLog(@"Error %@", error.description);
        } else {
            routeDetails = response.routes.lastObject;
            [self.mapView addOverlay:routeDetails.polyline level:MKOverlayLevelAboveRoads];
            //self.destinationLabel.text =
//            NSLog(@"%@",[placemark.addressDictionary objectForKey:@"Street"]);
            [stepByStep addObject:[self getAnnotation].title];
            [stepByStep addObject:[self getAnnotation].subtitle];
            //self.distanceLabel.text =
//            NSLog(@"%@",[NSString stringWithFormat:@"%0.1f kms", routeDetails.distance/100]);
            [stepByStep addObject:[NSString stringWithFormat:@"%0.1f kms", routeDetails.distance/1000]];
            //self.transportLabel.text =
//            NSLog(@"%@",[NSString stringWithFormat:@"%lu" ,routeDetails.transportType]);
//            [stepByStep addObject:[NSString stringWithFormat:@"%lu" ,routeDetails.transportType]];
            self.allSteps = @"";
            for (int i = 0; i < routeDetails.steps.count; i++) {
                MKRouteStep *step = [routeDetails.steps objectAtIndex:i];
                NSString *newStep = step.instructions;
                [stepByStep addObject: [self.allSteps stringByAppendingString:newStep]];
//                self.allSteps = [self.allSteps stringByAppendingString:@"\n\n"];
                //self.steps.text =
//                NSLog(@"%@", self.allSteps);
            }
//            [stepByStep addObject:self.allSteps];
            NSLog(@"%@",stepByStep);
        }
    }];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    MKPolylineRenderer *renderer =
    [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor blueColor];
    renderer.lineWidth = 7.5;
    return renderer;
}

- (IBAction)GoType:(id)sender {
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            [self locate];
            break;
        case 1:
            [self locate];
            break;
            
        default:
            break;
    }
}

-(void) clearRoute{
//    [self.mapView removeOverlay:routeDetails.polyline];
    [[self mapView] removeOverlays: [self mapView].overlays];
}

- (IBAction)locateAgain:(id)sender {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([[self mapView] userLocation].coordinate, 700, 700);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    [self locate];
}

-(void) locate{
    
    [self clearRoute];
//    [[self mapView] removeOverlays: [self mapView].overlays];
    if (self.segmentedControl.selectedSegmentIndex==0) {
        [self findRoute:[self getAnnotation] andType:MKDirectionsTransportTypeAutomobile];
    }else{
        [self findRoute:[self getAnnotation] andType:MKDirectionsTransportTypeWalking];
    }
}

@end
