//
//  POIData.h
//  SegueMapa
//
//  Created by Rafael Souza Belchior da Silva on 04/03/15.
//  Copyright (c) 2015 Rafael Souza Belchior da Silva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "POI.h"
@interface POIData : NSObject
@property NSMutableArray *poidados;
+(POIData *) instance;
-(id)init;
@end
