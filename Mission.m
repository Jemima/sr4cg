/*
 *  Mission.c
 *  SR4CG3
 *
 *  Created by David Munro on 21/01/10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

#import "Mission.h"

@implementation Mission
@synthesize name;
@synthesize earnt;
@synthesize spent;
@synthesize description;
@synthesize gained;
@synthesize lost;
@synthesize date;
@synthesize karma;
@synthesize karma_spent;

-(NSXMLElement *)getXML{
    NSXMLElement * base = [[NSXMLElement alloc] initWithName:@"Mission"];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Name" stringValue:self.name]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Earnt" stringValue:[NSString stringWithFormat:@"%d", self.earnt]]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Spent" stringValue:[NSString stringWithFormat:@"%d", self.spent]]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Description" stringValue:self.description]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Gained" stringValue:self.gained]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Lost" stringValue:self.lost]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Date" stringValue:self.date]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Karma" stringValue:[NSString stringWithFormat:@"%d", self.karma]]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"KarmaSpent" stringValue:[NSString stringWithFormat:@"%d", self.karma_spent]]];
    return base;
}
-(id)initFromXML:(NSXMLElement *)data{
    self = [super init];
    [self loadFromXML:data];
    return self;
}
-(void) loadFromXML:(NSXMLElement *)data{
    NSArray * children = [data children];
    for (NSXMLNode * node in children) {
        [self setValue:node];
    }
}
-(void)setValue:(NSXMLNode *) value{
    if([[value name] isEqual:@"Name"])
        self.name = [[value stringValue] retain];
    else if([[value name] isEqual:@"Description"])
        self.description = [[value stringValue] retain];
    else if([[value name] isEqual:@"Gained"])
        self.gained = [[value stringValue] retain];
    else if([[value name] isEqual:@"Lost"])
        self.lost = [[value stringValue] retain];
    else if([[value name] isEqual:@"Date"])
        self.date = [[value stringValue] retain];
    else if([[value name] isEqual:@"Karma"])
        self.karma = [[value stringValue] intValue];
    else if([[value name] isEqual:@"KarmaSpent"])
        self.karma_spent = [[value stringValue] intValue];
    else if([[value name] isEqual:@"Earnt"])
        self.earnt = [[value stringValue] intValue];
    else if([[value name] isEqual:@"Spent"])
        self.spent = [[value stringValue] intValue];
}
@end
