//
//  Vehicles.h
//  SR4CG3
//
//  Created by David Munro on 18/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Vehicle.h";

@interface Vehicles : NSObject {
    IBOutlet NSTableView* table;
    NSMutableArray* vehicles;
    NSMutableArray* ownVehicles;
    IBOutlet NSComboBox* vehicleList;
    IBOutlet NSButton * undoButton;
    Vehicle* deleted;
    Vehicle* old;
    int currRow;
    NSString* notes;
    NSArray* ownUpgrades;
    NSArray* upgrades;
    IBOutlet NSTableView* upgradeTable;
    IBOutlet NSTextField* notesField;
    IBOutlet NSComboBox* upgradeList;
}
@property (retain) NSString* notes;
-(NSXMLElement *)getXML;
-(void) loadFromXML:(NSXMLElement *)data;

-(IBAction) chooseVehicle:(id)sender;
-(IBAction) newVehicle:(id)sender;
-(IBAction) deleteVehicle:(id)sender;
-(IBAction) undoDelete:(id)sender;
-(IBAction) addVehicle:(id)sender;
-(IBAction) addUpgrade:(id)sender;
-(IBAction) deleteUpgrade:(id)sender;
-(void) awakeFromNib;
-(void) setActive:(Vehicle*) active;
-(void) clear;

- (int)numberOfRowsInTableView:(NSTableView *)tableView;
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(int)row;
- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex;



@end
