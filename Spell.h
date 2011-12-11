//
//  Spell.h
//  SR4CG3
//
//  Created by David Munro on 16/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Spell : NSObject {
    NSString* name;
    NSString* type;
    NSString* spellType;
    NSString* range;
    NSString* target;
    NSString* damage;
    NSString* duration;
    int drainValue;
}
@property (retain)  NSString* name;
@property (retain) NSString* type;
@property (retain) NSString* spellType;
@property (retain) NSString* range;
@property (retain) NSString* target;
@property (retain) NSString* damage;
@property (retain) NSString* duration;
@property int drainValue;
-(NSXMLElement *)getXML;
-(void) loadFromXML:(NSXMLElement *)node;
@end
