/*
 *  Mission.h
 *  SR4CG3
 *
 *  Created by David Munro on 21/01/10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */
@interface Mission : NSObject
{
    NSString * name;
    int earnt;
    int spent;
    int karma;
    int karma_spent;
    NSString* gained;
    NSString* lost;
    NSString* description;
    NSString* date;
}
@property (retain) NSString* name;
@property int earnt;
@property int spent;
@property int karma;
@property int karma_spent;
@property (retain) NSString* gained;
@property (retain) NSString* lost;
@property (retain) NSString* description;
@property (retain) NSString* date;

-(NSXMLElement *)getXML;
-(void) loadFromXML:(NSXMLElement *)data;
-(id)initFromXML:(NSXMLElement *)data;

@end