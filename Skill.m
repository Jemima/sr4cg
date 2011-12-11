//
//  Skill.m
//  SR4CG3
//
//  Created by David Munro on 7/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Skill.h"


@implementation Skill
@synthesize name;
@synthesize spec;
@synthesize group;
@synthesize rank;
@synthesize skillID;
@synthesize type;
@synthesize modified;


-(NSXMLElement *)getXML{
    NSXMLElement * base = [[NSXMLElement alloc] initWithName:@"Skill"];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Name" stringValue:self.name]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Spec" stringValue:self.spec]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Rank" stringValue:[NSString stringWithFormat:@"%d", self.rank]]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Modified" stringValue:[NSString stringWithFormat:@"%d", self.modified]]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"ID" stringValue:[NSString stringWithFormat:@"%d", self.skillID]]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Group" stringValue:self.group]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Type" stringValue:self.type]];
    return base;
    
}
-(void) loadFromXML:(NSXMLElement *)node{
    NSArray* children = [node children];
    for (NSXMLElement* value in children) {
        if([[value name] isEqual:@"Name"])
            self.name = [value stringValue];
        else if([[value name] isEqual:@"Spec"])
            self.spec = [value stringValue];
        else if([[value name] isEqual:@"Group"])
            self.group = [value stringValue];
        else if([[value name] isEqual:@"Type"])
            self.type = [value stringValue];
        else if([[value name] isEqual:@"Rank"])
            self.rank = [[value stringValue] intValue];
        else if([[value name] isEqual:@"Modified"])
            self.modified = [[value stringValue] intValue];
        else if([[value name] isEqual:@"ID"])
            self.skillID = [[value stringValue] intValue];
    }
}
@end
