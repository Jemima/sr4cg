//
//  Skill.h
//  SR4CG3
//
//  Created by David Munro on 7/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Skill : NSObject {
    NSString* name;
    int rank;
    int skillID;
    NSString* spec;
    NSString* group;
    NSString* type;
    int modified;
}

@property (copy) NSString* name;
@property (retain) NSString *spec;
@property (retain) NSString* group;
@property (retain) NSString* type;
@property int rank;
@property int modified;
@property int skillID;

-(NSXMLElement *)getXML;
-(void) loadFromXML:(NSXMLElement *)node;
@end
