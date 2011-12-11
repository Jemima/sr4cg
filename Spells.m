//
//  Spells.m
//  SR4CG3
//
//  Created by David Munro on 7/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Spells.h"


@implementation Spells

-(id)init{
    spells = [[NSMutableArray alloc] init];
    spellsList = [[NSMutableArray alloc] init];
    self = [super init];
    Data *data = [[Data alloc] init];
    [data loadFromFile:@"spells"];
    NSMutableDictionary * dt = [data data];
    dt = [dt objectForKey:@"Spells"];
    for (NSMutableDictionary* sp in [dt objectForKey:@"Spell"]) {
        Spell * temp = [[Spell alloc] init];
        temp.name = [sp objectForKey:@"Name"];
        temp.type = [sp objectForKey:@"Type"];
        temp.range = [sp objectForKey:@"Range"];
        temp.damage = [sp objectForKey:@"Damage"];
        temp.duration = [sp objectForKey:@"Duration"];
        temp.target = [sp objectForKey:@"Target"];
        temp.spellType = [sp objectForKey:@"SpellType"];
        temp.drainValue = [[sp objectForKey:@"DrainModifier"] intValue];
        [spellsList addObject:temp];
    }
    
    return self;
}

-(void)awakeFromNib{
    NSTableColumn * name = [[NSTableColumn alloc] initWithIdentifier:@"name"];
    NSTableColumn * spellType = [[NSTableColumn alloc] initWithIdentifier:@"spellType"];
    NSTableColumn * range = [[NSTableColumn alloc] initWithIdentifier:@"range"];
    NSTableColumn * damage = [[NSTableColumn alloc] initWithIdentifier:@"damage"];
    NSTableColumn * duration = [[NSTableColumn alloc] initWithIdentifier:@"duration"];
    NSTableColumn * drain = [[NSTableColumn alloc] initWithIdentifier:@"drain"];
    NSTableColumn * type = [[NSTableColumn alloc] initWithIdentifier:@"type"];
    NSArray * columns = [table tableColumns];
    [table removeTableColumn:[columns objectAtIndex:0]];
    [table addTableColumn:name];
    [[name headerCell] setStringValue:@"Name"];
    [table addTableColumn:spellType];
    [[spellType headerCell] setStringValue:@"Type"];
    [table addTableColumn:range];
    [[range headerCell] setStringValue:@"Range"];
    [table addTableColumn:damage];
    [[damage headerCell] setStringValue:@"Damage"];
    [table addTableColumn:duration];
    [[duration headerCell] setStringValue:@"Duration"];
    [table addTableColumn:drain];
    [[drain headerCell] setStringValue:@"Drain"];
    [table addTableColumn:type];
    [[type headerCell] setStringValue:@"Class"];
    
    [name setTableView:table];
    [spellType setTableView:table];
    [range setTableView:table];
    [damage setTableView:table];
    [duration setTableView:table];
    [drain setTableView:table];
    [type setTableView:table];
    [table setDataSource:self];
    [table reloadData];
    for (Spell* temp in spellsList) {
        [spellList addItemWithObjectValue:temp.name];
    }
}
-(NSXMLElement *)getXML{
    NSXMLElement * spellsNode = [[NSXMLElement alloc] initWithName:@"Spells"];
    for (Spell* sp in spells) {
        [spellsNode addChild:[sp getXML]]; 
    }
    return spellsNode;
}
-(void) loadFromXML:(NSXMLElement *)data{    
    NSArray* children = [data children];
    for (NSXMLElement* node in children) {
        Spell* temp = [[Spell alloc] init];
        [temp loadFromXML:node];
        [spells addObject:temp];
    }
    [table reloadData];
}

- (int)numberOfRowsInTableView:(NSTableView *)tableView{
    return [spells count];
}
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(int)row{
    Spell * temp = [spells objectAtIndex:row];
    if([[tableColumn identifier] isEqual:@"name"])
        return temp.name;
    else if([[tableColumn identifier] isEqual:@"type"])
        return temp.type;
    else if([[tableColumn identifier] isEqual:@"range"]){
        if([temp.target isEqual:@"Area"])
            return [NSString stringWithFormat:@"%@ (Area)", temp.range];
        else return temp.range;
    }
    else if([[tableColumn identifier] isEqual:@"damage"])
        return temp.damage;
    else if([[tableColumn identifier] isEqual:@"duration"])
        return temp.duration;
    else if([[tableColumn identifier] isEqual:@"spellType"])
        return temp.spellType;
    else if([[tableColumn identifier] isEqual:@"drain"]){
        if(temp.drainValue < 0)
            return [NSString stringWithFormat:@"(F / 2) - %d", abs(temp.drainValue)];
        else if(temp.drainValue > 0)
            return [NSString stringWithFormat:@"(F / 2) + %d", temp.drainValue];
        else return [NSString stringWithFormat:@"(F / 2)"];
    }
    return @"Blah";
}
/*- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex{
    Spell * temp = [spells objectAtIndex:rowIndex];
    if([[aTableColumn identifier] isEqual:@"name"])
        temp.name = (NSString*)anObject;
    else if([[aTableColumn identifier] isEqual:@"type"])
        temp.spec = (NSString*)anObject;
    else if([[aTableColumn identifier] isEqual:@"rank"]){
        if([(NSString*)anObject isEqual:@"N"] && temp.type == @"Language Spell")
            temp.rank = -255;
        else
            temp.rank = [anObject intValue];
    }
    else if([[aTableColumn identifier] isEqual:@"modified"])
        temp.modified = [anObject intValue];
}*/
-(IBAction)addSpell:(id)sender{
    int index = [spellList indexOfSelectedItem];
    if(index < 0)
        return;
    Spell * temp = [[Spell alloc] init];
    temp.name = [[spellsList objectAtIndex:index] name];
    temp.type = [[spellsList objectAtIndex:index] type];
    temp.spellType = [[spellsList objectAtIndex:index] spellType];
    temp.damage = [[spellsList objectAtIndex:index] damage];
    temp.duration = [(Spell*)[spellsList objectAtIndex:index] duration];
    temp.target = [[spellsList objectAtIndex:index] target];
    temp.drainValue = [[spellsList objectAtIndex:index] drainValue];
    temp.range = [[spellsList objectAtIndex:index] range];
    
    [spells addObject:temp];
    [table reloadData];
}

-(IBAction)rollCheck:(id)sender{
    
}

@end
