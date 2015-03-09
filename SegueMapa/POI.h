//
//  POI.h
//  SegueMapa
//
//  Created by Rafael Souza Belchior da Silva on 04/03/15.
//  Copyright (c) 2015 Rafael Souza Belchior da Silva. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
@import MapKit;

@interface POI : NSObject

@property NSString *poiName;
@property NSString *poiAddress;
//@property CLLocationCoordinate2D poiCoordinate;
@property CLLocationDegrees poiLatitude;
@property CLLocationDegrees poiLongitude;
@property CLGeocoder *geocoder;

-(id) initWithObjectsName: (NSString *)n andAddress: (NSString *)ad;
@end
