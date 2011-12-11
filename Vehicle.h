//
//  Vehicle.h
//  SR4CG3
//
//  Created by David Munro on 18/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Data.h";

@interface Vehicle : NSObject {
    NSString* name;
    NSString* type;
    NSString* subtype;
    int handling;
    int accelWalk;
    int accelRun;
    int speed;
    int pilot;
    int body;
    int armour;
    int sensors;
    NSString* availability;
    int cost;
    NSArray* upgrades;
    NSString* notes;
}
@property (retain) NSString* name;
@property (retain) NSString* type;
@property (retain) NSString* subtype;
@property int handling;
@property int accelWalk;
@property int accelRun;
@property int speed;
@property int pilot;
@property int body;
@property int armour;
@property int sensors;
@property (retain) NSString* availability;
@property int cost;
@property (retain) NSArray* upgrades;
@property (retain) NSString* notes;

-(NSXMLElement *)getXML;
-(void) loadFromXML:(NSXMLElement *)data;
@end
