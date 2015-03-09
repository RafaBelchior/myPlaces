//
//  POIData.m
//  SegueMapa
//
//  Created by Rafael Souza Belchior da Silva on 04/03/15.
//  Copyright (c) 2015 Rafael Souza Belchior da Silva. All rights reserved.
//

#import "POIData.h"

@implementation POIData
@synthesize poidados;
static POIData * instance = nil;
+(POIData *) instance{
    if (instance == nil){
        instance = [[POIData alloc] init];
    }
    return instance;
}
-(id)init{
    poidados = [[NSMutableArray alloc]init];
    return self;
}
@end
