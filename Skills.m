//
//  Skills.m
//  SR4CG3
//
//  Created by David Munro on 7/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Skills.h"


@implementation Skills

-(id)init{
    skills = [[NSMutableArray alloc] init];
    skillsList = [[NSMutableArray alloc] init];
    self = [super init];
    Data *data = [[Data alloc] init];
    [data loadFromFile:@"skills"];
    NSMutableDictionary * dt = [data data];
    dt = [dt objectForKey:@"Skills"];
    for (NSMutableDictionary* sk in [dt objectForKey:@"Skill"]) {
        Skill * temp = [[Skill alloc] init];
        temp.name = [sk objectForKey:@"Name"];
        temp.type = [sk objectForKey:@"Type"];
        [skillsList addObject:temp];
    }
    
    return self;
}

-(void)awakeFromNib{
    NSTableColumn * skill = [[NSTableColumn alloc] initWithIdentifier:@"name"];
    NSTableColumn * spec = [[NSTableColumn alloc] initWithIdentifier:@"spec"];
    NSTableColumn * rank = [[NSTableColumn alloc] initWithIdentifier:@"rank"];
    NSTableColumn * modified = [[NSTableColumn alloc] initWithIdentifier:@"modified"];
    NSTableColumn * type = [[NSTableColumn alloc] initWithIdentifier:@"type"];
    NSArray * columns = [table tableColumns];
    [table removeTableColumn:[columns objectAtIndex:0]];
    [table addTableColumn:skill];
    [[skill headerCell] setStringValue:@"Name"];
    [table addTableColumn:spec];
    [[spec headerCell] setStringValue:@"Specialisation"];
    [table addTableColumn:rank];
    [[rank headerCell] setStringValue:@"Rank"];
    [table addTableColumn:modified];
    [[modified headerCell] setStringValue:@"Modified Skill"];
    [table addTableColumn:type];
    [[type headerCell] setStringValue:@"Type"];
    
    [skill setTableView:table];
    [spec setTableView:table];
    [rank setTableView:table];
    [table setDataSource:self];
    [table reloadData];
    for (Skill* temp in skillsList) {
        [skillList addItemWithObjectValue:temp.name];
    }
}
-(NSXMLElement *)getXML{
    NSXMLElement * skillsNode = [[NSXMLElement alloc] initWithName:@"Skills"];
    for (Skill* sk in skills) {
        [skillsNode addChild:[sk getXML]]; 
    }
    return skillsNode;
}
-(void) loadFromXML:(NSXMLElement *)data{
    
    NSArray* children = [data children];
    for (NSXMLElement* node in children) {
        Skill* temp = [[Skill alloc] init];
        [temp loadFromXML:node];
        [skills addObject:temp];
    }
    [table reloadData];
    
}

- (int)numberOfRowsInTableView:(NSTableView *)tableView{
    return [skills count];
}
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(int)row{
    Skill * temp = [skills objectAtIndex:row];
    if([[tableColumn identifier] isEqual:@"name"])
        return temp.name;
    else if([[tableColumn identifier] isEqual:@"spec"])
        return temp.spec;
    else if([[tableColumn identifier] isEqual:@"type"])
        return temp.type;
    else if([[tableColumn identifier] isEqual:@"rank"]){
        if(temp.type == @"Language Skill" && temp.rank == -255)
            return @"N";
        return [NSNumber numberWithInt:temp.rank];
    }
    else if([[tableColumn identifier] isEqual:@"modified"])
        return [NSNumber numberWithInt:temp.modified];
    return @"Blah";
}
- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex{
    Skill * temp = [skills objectAtIndex:rowIndex];
    if([[aTableColumn identifier] isEqual:@"name"]){
        temp.name = (NSString*)anObject;
    }
    else if([[aTableColumn identifier] isEqual:@"spec"])
        temp.spec = (NSString*)anObject;
    else if([[aTableColumn identifier] isEqual:@"rank"]){
        if([(NSString*)anObject isEqual:@"N"] && temp.type == @"Language Skill")
            temp.rank = -255;
        else
            temp.rank = [anObject intValue];
    }
    else if([[aTableColumn identifier] isEqual:@"modified"])
        temp.modified = [anObject intValue];
    
}
-(IBAction)addSkill:(id)sender{
    int index = [skillList indexOfSelectedItem];
    if(index < 0)
        return;
    Skill * temp = [[Skill alloc] init];
    temp.name = [[skillsList objectAtIndex:index] name];
    temp.type = [[skillsList objectAtIndex:index] type];
    [skills addObject:temp];
    [table reloadData];
}
-(IBAction)addKnowledge:(id)sender{
    Skill * temp = [[Skill alloc] init];
    temp.name = @"New Knowledge Skill";
    temp.type = @"Knowledge Skill";
    [skills addObject:temp];
    [table reloadData];
    
}
-(IBAction)addLanguage:(id)sender{
    Skill * temp = [[Skill alloc] init];
    temp.name = @"New Language";
    temp.type = @"Language Skill";
    [skills addObject:temp];
    [table reloadData];
}
-(IBAction)rollCheck:(id)sender{
    if([table selectedRow] == -1)
        return;
    Skill * temp = [skills objectAtIndex:[table selectedRow]];
    int dice = temp.modified;
    if(dice == 0)
        dice = temp.rank;
    if(dice == 0){
        NSRunAlertPanel(@"Result of Skill Check", @"No dice to roll", @"Ok", nil, nil);
        return;
    }
    //Once we keep track of abilities, add that in too.
    NSString* result;
    [Dice roll:dice: &result];
    NSRunAlertPanel(@"Result of Skill Check", result, @"Ok", nil, nil);
}
@end
