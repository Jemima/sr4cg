//
//  Spell.m
//  SR4CG3
//
//  Created by David Munro on 16/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Spell.h"


@implementation Spell

@synthesize name;
@synthesize type;
@synthesize spellType;
@synthesize range;
@synthesize target;
@synthesize damage;
@synthesize duration;
@synthesize drainValue;


-(NSXMLElement *)getXML{
    NSXMLElement * base = [[NSXMLElement alloc] initWithName:@"Skill"];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Name" stringValue:self.name]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Type" stringValue:self.type]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"DrainModifier" stringValue:[NSString stringWithFormat:@"%d", self.drainValue]]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"SpellType" stringValue:self.spellType]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Range" stringValue:self.range]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Target" stringValue:self.target]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Damage" stringValue:self.damage]];
    [base addChild:[[NSXMLElement alloc] initWithName:@"Duration" stringValue:self.duration]];
    return base;
    
}
-(void) loadFromXML:(NSXMLElement *)node{
    NSArray* children = [node children];
    for (NSXMLElement* value in children) {
        if([[value name] isEqual:@"Name"])
            self.name = [value stringValue];
        else if([[value name] isEqual:@"Type"])
            self.type = [value stringValue];
        else if([[value name] isEqual:@"SpellType"])
            self.spellType = [value stringValue];
        else if([[value name] isEqual:@"Range"])
            self.range = [value stringValue];
        else if([[value name] isEqual:@"Target"])
            self.target = [value stringValue];
        else if([[value name] isEqual:@"Damage"])
            self.damage = [value stringValue];
        else if([[value name] isEqual:@"Duration"])
            self.duration = [value stringValue];
        else if([[value name] isEqual:@"DrainModifier"])
            self.drainValue = [[value stringValue] intValue];
    }
}


@end
