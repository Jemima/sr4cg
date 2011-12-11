//
//  Missions.h
//  SR4CG3
//
//  Created by David Munro on 21/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include "Mission.h"
#import "General.h"


@interface Missions : NSObject{
    NSMutableArray *missions;
    IBOutlet NSTableView* list;
    NSString * name;
    int earnt;
    int spent;
    int karma;
    int karma_spent;
    NSString* gained;
    NSString* lost;
    NSString* description;
    NSString* date;
    int currRow;
    Mission * deleted;
    int deletedIndex;
    IBOutlet NSButton * undoButton;
    NSXMLElement * _data;
    BOOL loaded;
    IBOutlet General * general;
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

-(IBAction) chooseMission:(id)sender;
-(IBAction) newMission:(id)sender;
-(IBAction) deleteMission:(id)sender;
-(IBAction) undoDelete:(id)sender;
-(void) nibLoaded;
-(void) setActive:(Mission*) active;
-(void) clear;

- (int)numberOfRowsInTableView:(NSTableView *)tableView;
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(int)row;

@end
