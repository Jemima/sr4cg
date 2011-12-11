//
//  Skills.h
//  SR4CG3
//
//  Created by David Munro on 7/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Skill.h"
#import "Data.h"
#import "Dice.h"

@interface Skills : NSObject {
    IBOutlet NSTableView* table;
    NSMutableArray* skills;
    IBOutlet NSComboBox* skillList;
    NSMutableArray* skillsList;
}

-(IBAction)addSkill:(id)sender;
-(IBAction)addKnowledge:(id)sender;
-(IBAction)addLanguage:(id)sender;
-(IBAction)rollCheck:(id)sender;
-(NSXMLElement *)getXML;
-(void) loadFromXML:(NSXMLElement *)data;

-(void) awakeFromNib;
- (int)numberOfRowsInTableView:(NSTableView *)tableView;
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(int)row;
- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex;
@end
