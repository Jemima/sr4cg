//
//  General.h
//  SR4CG3
//
//  Created by David Munro on 24/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface General : NSObject {
    @public
    int money_earnt;
    int money_spent;
    int money_current;
    int money_starting;
    int karma_current;
    int karma_total;
    NSString* name;
    NSString* metatype;
    int health_total;
    int health_current;
    int health_penalty;
    int stun_total;
    int stun_current;
    int stun_penalty;
}

@property int money_earnt; 
@property int money_spent; 
@property int money_current; 
@property int money_starting; 
@property int karma_current; 
@property int karma_total; 
@property (retain) NSString* name; 
@property (retain) NSString* metatype; 
@property int health_total; 
@property int health_current; 
@property int health_penalty; 
@property int stun_total; 
@property int stun_current; 
@property int stun_penalty;

-(NSXMLElement *)getXML;
-(void) loadFromXML:(NSXMLElement *)data;


@end
