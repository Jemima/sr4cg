//
//  Dice.h
//  SR4CG3
//
//  Created by David Munro on 29/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include "stdlib.h"
#include "math.h"

@interface Dice : NSObject {
    IBOutlet NSTextField* result;
    IBOutlet NSTextField* number_dice;
    IBOutlet NSTextField* limit;
    IBOutlet NSTextField* intervals;
}
-(IBAction) roll:(id)sender;
-(IBAction) rollBlind:(id)sender;
-(IBAction) rollThreshold:(id)sender;
+(int)doRoll;
+(int)doRolls:(int)number: (int *)rolls;
+(int)roll:(int)nDice: (NSString**)str;
@end
