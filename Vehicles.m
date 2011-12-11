//
//  Vehicles.m
//  SR4CG3
//
//  Created by David Munro on 18/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Vehicles.h"


@implementation Vehicles
@synthesize notes;
-(id)init{
    self = [super init];
    vehicles = [[NSMutableArray alloc] init];
    ownVehicles = [[NSMutableArray alloc] init];
    Data* data = [[Data alloc] init];
    [data loadFromFile:@"vehicles"];
    NSMutableDictionary * dt = [data data];
    dt = [dt objectForKey:@"Vehicles"];
    for (NSMutableDictionary* vh in [dt objectForKey:@"Vehicle"]) {
        Vehicle* temp = [[Vehicle alloc] init];
        temp.name = [vh objectForKey:@"Name"];
        temp.type = [vh objectForKey:@"Type"];
        temp.subtype = [vh objectForKey:@"Subtype"];
        temp.handling = [[vh objectForKey:@"Handling"] intValue];
        temp.accelWalk = [[vh objectForKey:@"AccelerationWalk"] intValue];
        temp.accelRun = [[vh objectForKey:@"AccelerationRun"] intValue];
        temp.pilot = [[vh objectForKey:@"Pilot"] intValue];
        temp.body = [[vh objectForKey:@"Body"] intValue];
        temp.armour = [[vh objectForKey:@"Armour"] intValue];
        temp.sensors = [[vh objectForKey:@"Sensors"] intValue];
        temp.cost = [[vh objectForKey:@"Cost"] intValue];
        temp.speed = [[vh objectForKey:@"Speed"] intValue];
        temp.availability = [vh objectForKey:@"Availability"];
        [vehicles addObject:temp];
    }
    
    /*
    upgrades = [[NSMutableArray alloc] init];
    ownUpgrades = [[NSMutableArray alloc] init];
    dt = [[data data] objectForKey:@"Upgrades"];
    for (NSMutableDictionary* vh in [dt objectForKey:@"Upgrade"]) {
        Vehicle* temp = [[Vehicle alloc] init];
        temp.name = [vh objectForKey:@"Name"];
        temp.type = [vh objectForKey:@"Type"];
        temp.subtype = [vh objectForKey:@"Subtype"];
        temp.handling = [[vh objectForKey:@"Handling"] intValue];
        temp.accelWalk = [[vh objectForKey:@"AccelerationWalk"] intValue];
        temp.accelRun = [[vh objectForKey:@"AccelerationRun"] intValue];
        temp.pilot = [[vh objectForKey:@"Pilot"] intValue];
        temp.body = [[vh objectForKey:@"Body"] intValue];
        temp.armour = [[vh objectForKey:@"Armour"] intValue];
        temp.sensors = [[vh objectForKey:@"Sensors"] intValue];
        temp.cost = [[vh objectForKey:@"Cost"] intValue];
        temp.speed = [[vh objectForKey:@"Speed"] intValue];
        temp.availability = [vh objectForKey:@"Availability"];
        [vehicles addObject:temp];
    }
    */
    
    return self;
}

-(void) awakeFromNib{
    //[table setDataSource:self];
    for (Vehicle* v in vehicles) {
        [vehicleList addItemWithObjectValue:v.name];
    }
    NSTableColumn* name = [[NSTableColumn alloc] initWithIdentifier:@"name"];
    NSTableColumn* type = [[NSTableColumn alloc] initWithIdentifier:@"type"];
    NSTableColumn* subtype = [[NSTableColumn alloc] initWithIdentifier:@"subtype"];
    NSTableColumn* handling = [[NSTableColumn alloc] initWithIdentifier:@"handling"];
    NSTableColumn* accel = [[NSTableColumn alloc] initWithIdentifier:@"accel"];
    NSTableColumn* speed = [[NSTableColumn alloc] initWithIdentifier:@"speed"];
    NSTableColumn* pilot = [[NSTableColumn alloc] initWithIdentifier:@"pilot"];
    NSTableColumn* body = [[NSTableColumn alloc] initWithIdentifier:@"body"];
    NSTableColumn* armour = [[NSTableColumn alloc] initWithIdentifier:@"armour"];
    NSTableColumn* sensors = [[NSTableColumn alloc] initWithIdentifier:@"sensors"];
    NSTableColumn* cost = [[NSTableColumn alloc] initWithIdentifier:@"cost"];
    NSTableColumn* avail = [[NSTableColumn alloc] initWithIdentifier:@"avail"];
    
    NSArray* columns = [table tableColumns];
    [table removeTableColumn:[columns objectAtIndex:0]];
    [table addTableColumn:name];
    [table addTableColumn:type];
    [table addTableColumn:subtype];
    [table addTableColumn:handling];
    [table addTableColumn:accel];
    [table addTableColumn:speed];
    [table addTableColumn:pilot];
    [table addTableColumn:body];
    [table addTableColumn:armour];
    [table addTableColumn:sensors];
    [table addTableColumn:avail];
    [table addTableColumn:cost];
    [[name headerCell] setStringValue:@"Name"];
    [[type headerCell] setStringValue:@"Type"];
    [[subtype headerCell] setStringValue:@"Subtype"];
    [[handling headerCell] setStringValue:@"Handling"];
    [[accel headerCell] setStringValue:@"Acceleration"];
    [[speed headerCell] setStringValue:@"Speed"];
    [[pilot headerCell] setStringValue:@"Pilot"];
    [[body headerCell] setStringValue:@"Body"];
    [[armour headerCell] setStringValue:@"Armour"];
    [[sensors headerCell] setStringValue:@"Sensors"];
    [[avail headerCell] setStringValue:@"Availability"];
    [[cost headerCell] setStringValue:@"Cost"];
    [cost sizeToFit];
}


-(NSXMLElement *)getXML{
    NSXMLElement* base = [[NSXMLElement alloc] initWithName:@"Vehicles"];
    if(currRow != -1){
        Vehicle* temp = [ownVehicles objectAtIndex:currRow];
        temp.notes = self.notes;
    }
    for (Vehicle* v in ownVehicles) {
        [base addChild:[v getXML]];
    }
    return base;
}
-(void) loadFromXML:(NSXMLElement *)data{
    for (NSXMLElement* node in [data children]) {
        Vehicle* temp = [[Vehicle alloc] init];
        [temp loadFromXML:node];
        [ownVehicles addObject:temp];
    }
    [table reloadData];
}

-(IBAction) chooseVehicle:(id)sender{
    int row = [table selectedRow];
    if(row == -1)
        return;
    Vehicle* temp;
    if(currRow != -1){
        temp = [ownVehicles objectAtIndex:currRow];
        temp.notes = self.notes;
    }
    temp = [ownVehicles objectAtIndex:row];
    self.notes = temp.notes;
    currRow = row;
    old = temp;
}
-(IBAction) newVehicle:(id)sender{
    Vehicle* temp = [[Vehicle alloc] init];
    temp.name = @"New Vehicle";
    [ownVehicles addObject:temp];
    [table reloadData];
}
-(IBAction) deleteVehicle:(id)sender{
    int row = [table selectedRow];
    if(deleted != nil)
        [deleted release];
    deleted = [ownVehicles objectAtIndex:row];
    [ownVehicles removeObjectAtIndex:row];
    [undoButton setEnabled:YES];
    [table reloadData];
    currRow = -1;
    [self chooseVehicle:nil];
}
-(IBAction) undoDelete:(id)sender{
    if(deleted == nil)
        return;
    [ownVehicles addObject:deleted];
    [table reloadData];
    [undoButton setEnabled:NO];
    deleted = nil;
}
-(IBAction) addVehicle:(id)sender{
    int row = [vehicleList indexOfSelectedItem];
    Vehicle* temp = [[Vehicle alloc] init];
    Vehicle* temp2 = [vehicles objectAtIndex:row];
    temp.name = temp2.name;
    temp.accelRun = temp2.accelRun;
    temp.accelWalk = temp2.accelWalk;
    temp.armour = temp2.armour;
    temp.availability =  temp2.availability;
    temp.body = temp2.body;
    temp.cost = temp2.cost;
    temp.handling = temp2.handling; 
    temp.notes = temp2.notes; 
    temp.pilot = temp2.pilot;
    temp.sensors = temp2.sensors;
    temp.speed = temp2.speed;
    temp.subtype = temp2.subtype;
    temp.type = temp2.type;
    temp.upgrades = temp2.upgrades;
    
    [ownVehicles addObject:temp];
    [table reloadData];
}
- (int)numberOfRowsInTableView:(NSTableView *)tableView{
    return [ownVehicles count];
}
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(int)row{
    Vehicle* temp = [ownVehicles objectAtIndex:row];
    if([[tableColumn identifier] isEqual:@"name"]){
        return temp.name;
    }
    if([[tableColumn identifier] isEqual:@"type"]){
        return temp.type;
    }
    if([[tableColumn identifier] isEqual:@"subtype"]){
        return temp.subtype;
    }
    if([[tableColumn identifier] isEqual:@"accel"]){
        return [NSString stringWithFormat:@"%d/%d", temp.accelWalk, temp.accelRun];;
    }
    if([[tableColumn identifier] isEqual:@"handling"]){
        return [NSNumber numberWithInt:temp.handling];
    }
    if([[tableColumn identifier] isEqual:@"speed"]){
        return [NSNumber numberWithInt:temp.speed];
    }
    if([[tableColumn identifier] isEqual:@"body"]){
        return [NSNumber numberWithInt:temp.body];
    }
    if([[tableColumn identifier] isEqual:@"armour"]){
        return [NSNumber numberWithInt:temp.armour];
    }
    if([[tableColumn identifier] isEqual:@"sensors"]){
        return [NSNumber numberWithInt:temp.sensors];
    }
    if([[tableColumn identifier] isEqual:@"pilot"]){
        return [NSNumber numberWithInt:temp.pilot];
    }
    if([[tableColumn identifier] isEqual:@"cost"]){
        return [NSNumber numberWithInt:temp.cost];
    }
    if([[tableColumn identifier] isEqual:@"avail"]){
        return temp.availability;
    }
    return @"Blah";
}

- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex{
    Vehicle * temp = [ownVehicles objectAtIndex:rowIndex];
    if([[aTableColumn identifier] isEqual:@"name"]){
        temp.name = (NSString*)anObject;
    }
    else if([[aTableColumn identifier] isEqual:@"type"]){
        temp.type = (NSString*)anObject;
    }
    else if([[aTableColumn identifier] isEqual:@"subtype"]){
        temp.subtype = (NSString*)anObject;
    }
    else if([[aTableColumn identifier] isEqual:@"avail"]){
        temp.availability = (NSString*)anObject;
    }
    else if([[aTableColumn identifier] isEqual:@"handling"]){
        temp.handling = [anObject intValue];
    }
    else if([[aTableColumn identifier] isEqual:@"pilot"]){
        temp.pilot = [anObject intValue];
    }
    else if([[aTableColumn identifier] isEqual:@"body"]){
        temp.body = [anObject intValue];
    }
    else if([[aTableColumn identifier] isEqual:@"armour"]){
        temp.armour = [anObject intValue];
    }
    else if([[aTableColumn identifier] isEqual:@"cost"]){
        temp.cost = [anObject intValue];
    }
    else if([[aTableColumn identifier] isEqual:@"sensors"]){
        temp.sensors = [anObject intValue];
    }
    else if([[aTableColumn identifier] isEqual:@"accel"]){
        NSArray* bits = [(NSString*)anObject componentsSeparatedByString: @"/"];
        if([bits count] < 2)
            return;
        temp.accelWalk = [[bits objectAtIndex:0] intValue];
        temp.accelRun = [[bits objectAtIndex:1] intValue];
    }
    [table reloadData];
}

-(IBAction) addUpgrade:(id)sender{
    
}
-(IBAction) deleteUpgrade:(id)sender{
    
}
@end
