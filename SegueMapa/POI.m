//
//  POI.m
//  SegueMapa
//
//  Created by Rafael Souza Belchior da Silva on 04/03/15.
//  Copyright (c) 2015 Rafael Souza Belchior da Silva. All rights reserved.
//

#import "POI.h"
#import "AddPOIViewController.h"

@implementation POI
@synthesize poiAddress,poiName, poiLongitude, poiLatitude;


-(id) initWithObjectsName: (NSString *)n andAddress: (NSString *)ad{
    self = [super init];
    if (self) {
        poiName = n;
        poiAddress = ad;
        
        if(self.geocoder == nil)
        {
            self.geocoder = [[CLGeocoder alloc] init];
        }
        
        [self.geocoder geocodeAddressString:ad completionHandler:^(NSArray *placemarks, NSError *error) {
            
            if(placemarks.count > 0)
            {
                CLPlacemark *placemark = [placemarks objectAtIndex:0];
                poiLatitude = placemark.location.coordinate.latitude;
                poiLongitude = placemark.location.coordinate.longitude;
                
            }
        }
         ];

    }
    return self;
}

@end
