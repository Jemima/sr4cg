//
//  Vehicle.m
//  SR4CG3
//
//  Created by David Munro on 18/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Vehicle.h"


@implementation Vehicle
@synthesize name;
@synthesize type;
@synthesize subtype;
@synthesize handling;
@synthesize accelWalk;
@synthesize accelRun;
@synthesize speed;
@synthesize pilot;
@synthesize body;
@synthesize armour;
@synthesize sensors;
@synthesize availability;
@synthesize cost;
@synthesize upgrades;
@synthesize notes;

-(NSXMLElement*) getXML{
    NSXMLElement * base = [[NSXMLElement alloc] initWithName:@"Vehicle"];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Name" stringValue:self.name]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Type" stringValue:self.type]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Subtype" stringValue:self.subtype]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Notes" stringValue:self.notes]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Availability" stringValue:self.availability]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Handling" stringValue:[NSString stringWithFormat:@"%d", self.handling]]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"AccelWalk" stringValue:[NSString stringWithFormat:@"%d", self.accelWalk]]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"AccelRun" stringValue:[NSString stringWithFormat:@"%d", self.accelRun]]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Speed" stringValue:[NSString stringWithFormat:@"%d", self.speed]]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Pilot" stringValue:[NSString stringWithFormat:@"%d", self.pilot]]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Body" stringValue:[NSString stringWithFormat:@"%d", self.body]]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Armour" stringValue:[NSString stringWithFormat:@"%d", self.armour]]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Sensors" stringValue:[NSString stringWithFormat:@"%d", self.sensors]]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Cost" stringValue:[NSString stringWithFormat:@"%d", self.cost]]];
    return base;
}
-(void) loadFromXML:(NSXMLElement *)node{
    NSArray* children = [node children];
    for (NSXMLElement* value in children) {
        if([[value name] isEqual:@"Name"])
            self.name = [value stringValue];
        if([[value name] isEqual:@"Type"])
            self.type = [value stringValue];
        if([[value name] isEqual:@"Subtype"])
            self.subtype = [value stringValue];
        if([[value name] isEqual:@"Notes"])
            self.notes = [value stringValue];
        if([[value name] isEqual:@"Availability"])
            self.availability = [value stringValue];
        else if([[value name] isEqual:@"Handling"])
            self.handling = [[value stringValue] intValue];
        else if([[value name] isEqual:@"AccelWalk"])
            self.accelWalk = [[value stringValue] intValue];
        else if([[value name] isEqual:@"AccelRun"])
            self.accelRun = [[value stringValue] intValue];
        else if([[value name] isEqual:@"Speed"])
            self.speed = [[value stringValue] intValue];
        else if([[value name] isEqual:@"Pilot"])
            self.pilot = [[value stringValue] intValue];
        else if([[value name] isEqual:@"Body"])
            self.body = [[value stringValue] intValue];
        else if([[value name] isEqual:@"Armour"])
            self.armour = [[value stringValue] intValue];
        else if([[value name] isEqual:@"Sensors"])
            self.sensors = [[value stringValue] intValue];
        else if([[value name] isEqual:@"Cost"])
            self.cost = [[value stringValue] intValue];
    }
}

@end
