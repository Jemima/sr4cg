//
//  General.m
//  SR4CG3
//
//  Created by David Munro on 24/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "General.h"


@implementation General
@synthesize money_earnt;
@synthesize money_starting;
@synthesize money_spent;
@synthesize money_current;
-(int)moneyCurrent{
    return self.money_starting+self.money_earnt-self.money_spent;
}
@synthesize karma_current;
@synthesize karma_total;
@synthesize name;
@synthesize metatype;
@synthesize health_total;
@synthesize health_current;
@synthesize health_penalty;
@synthesize stun_total;
@synthesize stun_current;
@synthesize stun_penalty;

-(NSXMLElement *)getXML{
    NSXMLElement * base = [[NSXMLElement alloc] initWithName:@"General"];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Name" stringValue:self.name]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Metatype" stringValue:self.metatype]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"MoneyStarting" stringValue:[NSString stringWithFormat:@"%d", self.money_starting]]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"HealthCurrent" stringValue:[NSString stringWithFormat:@"%d", self.health_current]]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"StunCurrent" stringValue:[NSString stringWithFormat:@"%d", self.stun_current]]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"KarmaCurrent" stringValue:[NSString stringWithFormat:@"%d", self.karma_current]]];
    
    return base;
}
-(void) loadFromXML:(NSXMLElement *)data{
    NSArray * children = [data children];
    for (NSXMLNode * node in children) {
        [self setValue:node];
    }
}
-(void)setValue:(NSXMLNode *) value{
    if([[value name] isEqual:@"Name"])
        self.name = [value stringValue];
    else if([[value name] isEqual:@"Metatype"])
        self.metatype = [value stringValue];
    else if([[value name] isEqual:@"MoneyStarting"])
        self.money_starting = [[value stringValue] intValue];
    else if([[value name] isEqual:@"HealthCurrent"])
        self.health_current = [[value stringValue] intValue];
    else if([[value name] isEqual:@"StunCurrent"])
        self.stun_current = [[value stringValue] intValue];
    else if([[value name] isEqual:@"KarmaCurrent"])
        self.karma_current = [[value stringValue] intValue];
}
@end
