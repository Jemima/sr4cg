//
//  Missions.m
//  SR4CG3
//
//  Created by David Munro on 21/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Missions.h"


@implementation Missions
-(void)setName:(NSString*)value{
    name = value;
    if(currRow == -1)
        return;
    Missions * temp = [missions objectAtIndex:currRow];
    temp.name = name;
    [list reloadData];
}
@synthesize name;
@synthesize earnt;
@synthesize spent;
@synthesize description;
@synthesize gained;
@synthesize lost;
@synthesize date;
@synthesize karma;
@synthesize karma_spent;
-(void)setKarma:(int)value{
    karma = value;
    int sumKarma = 0;
    for (Mission * m in missions) {
        sumKarma += m.karma;
    }
    general.karma_current += sumKarma-general.karma_total;
    general.karma_total = sumKarma;
}
-(void)setKarma_spent:(int)value{
    karma_spent = value;
    int sumKarmaSpent = 0;
    for (Mission * m in missions) {
        sumKarmaSpent += m.karma_spent;
    }
    general.karma_current = general.karma_total-sumKarmaSpent;
}
-(void)setEarnt:(int)value{
    earnt = value;
    int sumEarnt = 0;
    for (Mission * m in missions) {
        sumEarnt += m.earnt;
    }
    general.money_earnt = sumEarnt;
    general.money_current = general.money_starting+general.money_earnt-general.money_spent;
}
-(void)setSpent:(int)value{
    spent = value;
    int sumSpent = 0;
    for (Mission * m in missions) {
        sumSpent += m.spent;
    }
    general.money_spent = sumSpent;
    general.money_current = general.money_starting+general.money_earnt-general.money_spent;
}
-(id)init{
    self = [super init];
    missions = [[NSMutableArray alloc] init];
    loaded = NO;
    return self;
}

-(void)nibLoaded{
    loaded = YES;
    [list setDataSource:self];
    if(_data != nil){
        [self loadFromXML:_data];
    }
    [list reloadData];
    if([missions count] == 0)
        return;
    NSIndexSet * index = [NSIndexSet indexSetWithIndex:0];
    [list selectRowIndexes:index byExtendingSelection:NO];
    [self setActive:[missions objectAtIndex:0]];
    
    int sumEarnt = 0;
    int sumSpent = 0;
    int sumKarma = 0;
    int sumKarmaSpent = 0;
    for (Mission * m in missions) {
        sumEarnt += m.earnt;
        sumSpent += m.spent;
        sumKarma += m.karma;
        sumKarmaSpent += m.karma_spent;
    }
    general.money_earnt = sumEarnt;
    general.money_spent = sumSpent;
    general.karma_total = sumKarma;
    general.karma_current = sumKarmaSpent;
    
}
-(void)setActive:(Mission*) active{
    self.name = active.name;
    self.description = active.description;
    self.earnt = active.earnt;
    self.spent = active.spent;
    self.gained = active.gained;
    self.lost = active.lost;
    self.date = active.date;
    self.karma = active.karma;
    self.karma_spent = active.karma_spent;
}

- (int)numberOfRowsInTableView:(NSTableView *)tableView{
    return [missions count];
}
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(int)row{
    Mission* temp = [missions objectAtIndex:row];
    return temp.name;
}
-(IBAction)chooseMission:(id)sender{
    int row = [list selectedRow];
    if(row == -1)
        return;
    if(currRow != -1){
        Missions * old = [missions objectAtIndex:currRow];
        //old.name = self.name;
        old.description = self.description;
        old.earnt = self.earnt;
        old.spent = self.spent;
        old.gained = self.gained;
        old.lost = self.lost;
        old.date = self.date;
        old.karma = self.karma;
        old.karma_spent = self.karma_spent;
        [list reloadData];
    }
    Mission * temp = [missions objectAtIndex:row];
    currRow = row;
    [self setActive:temp];
}
-(IBAction) newMission:(id)sender{
    Mission *row = [[Mission alloc] init];
    row.name = @"New Mission";
    [missions addObject:row];
    [list reloadData];
}
-(IBAction) deleteMission:(id)sender{
    int row = [list selectedRow];
    deleted = [missions objectAtIndex:row];
    [missions removeObjectAtIndex:row];
    [undoButton setEnabled:YES];
    [list reloadData];
    currRow = -1;
    [self chooseMission:nil];
}
-(IBAction) undoDelete:(id)sender{
    if(deleted == nil)
        return;
    [missions addObject:deleted];
    [list reloadData];
    [undoButton setEnabled:NO];
    deleted = nil;
}

-(NSXMLElement *)getXML{
    //Write all the currently being edited values to the array before saving the array, so they don't lose most recent changes.
    if([missions count] > 0){
        Missions * old = [missions objectAtIndex:currRow];
        old.description = self.description;
        old.earnt = self.earnt;
        old.spent = self.spent;
        old.gained = self.gained;
        old.lost = self.lost;
        old.date = self.date;
        old.karma = self.karma;    
        old.karma_spent = self.karma_spent;    
    }
    NSXMLElement * base = [[NSXMLElement alloc] initWithName:@"Missions"];
    for (Mission * m in missions) {
        [base addChild:[m getXML]];
    }
    return base;
}
-(void) loadFromXML:(NSXMLElement *)data{
    if(!loaded)
        _data = [data retain];
    else {
        [self clear];
        NSArray * children = [data children];
        for (NSXMLElement * node in children) {
            Mission * temp = [[Mission alloc] initFromXML:node];
            [missions addObject:temp];
        }
        [list reloadData];
        
        
        int sumKarma = 0;
        for (Mission * m in missions) {
            sumKarma += m.karma;
        }
        general.karma_total = sumKarma;
        
        int sumKarmaSpent = 0;
        for (Mission * m in missions) {
            sumKarmaSpent += m.karma_spent;
        }
        general.karma_current = sumKarma-sumKarma;
        
        int sumEarnt = 0;
        for (Mission * m in missions) {
            sumEarnt += m.earnt;
        }
        general.money_earnt = sumEarnt;
        
        int sumSpent = 0;
        for (Mission * m in missions) {
            sumSpent += m.spent;
        }
        general.money_spent = sumSpent;
        general.money_current = general.money_starting+general.money_earnt-general.money_spent;
    }
}
-(void) clear{
    for (Mission * m in missions) {
        [m release];
    }
    [missions removeAllObjects];
}


@end
