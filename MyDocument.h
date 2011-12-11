//
//  MyDocument.h
//  SR4CG3
//
//  Created by David Munro on 21/01/10.
//  Copyright __MyCompanyName__ 2010 . All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import "Missions.h"
#import "General.h"
#import "Skills.h"
#import "Spells.h"
#import "Vehicles.h";

@interface MyDocument : NSDocument
{
    IBOutlet Missions * missions;
    IBOutlet General * general;
    IBOutlet Skills * skills;
    IBOutlet Spells * spells;
    IBOutlet Vehicles * vehicles;
    NSData* loading;
    NSString* loadType;
}
-(void)actualLoad:(NSData *)data ofType:(NSString *)typeName;
@end
