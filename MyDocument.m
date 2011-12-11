//
//  MyDocument.m
//  SR4CG3
//
//  Created by David Munro on 21/01/10.
//  Copyright __MyCompanyName__ 2010 . All rights reserved.
//

#import "MyDocument.h"

@implementation MyDocument

- (id)init
{
    self = [super init];
    if (self) {
        missions = [[Missions alloc] init];
        // Add your subclass-specific initialization here.
        // If an error occurs here, send a [self release] message and return nil.
    
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
    [super windowControllerDidLoadNib:aController];
    [missions nibLoaded];
    if(loading != nil)
        [self actualLoad:loading ofType:loadType];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to write your document to data of the specified type. If the given outError != NULL, ensure that you set *outError when returning nil.

    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.

    // For applications targeted for Panther or earlier systems, you should use the deprecated API -dataRepresentationOfType:. In this case you can also choose to override -fileWrapperRepresentationOfType: or -writeToFile:ofType: instead.
    if(![typeName isEqual:@"Shadowrun Character"]){ //Should never happen, since we can only save Shadowrun Character files.
        *outError = [NSError errorWithDomain:@"sr4cg" code:1 userInfo:nil];
    }
    NSXMLElement * root = [[NSXMLElement alloc] initWithName:@"Character"];
    NSXMLDocument * ret = [[NSXMLDocument alloc] initWithRootElement:root];
    [root addChild:[missions getXML]];
    [root addChild:[general getXML]];
    [root addChild:[skills getXML]];
    [root addChild:[spells getXML]];
    [root addChild:[vehicles getXML]];
    
    if ( outError != NULL ) {
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
	}
	return [ret XMLData];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type.  If the given outError != NULL, ensure that you set *outError when returning NO.

    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead. 
    
    // For applications targeted for Panther or earlier systems, you should use the deprecated API -loadDataRepresentation:ofType. In this case you can also choose to override -readFromFile:ofType: or -loadFileWrapperRepresentation:ofType: instead.
    if(![typeName isEqual:@"Shadowrun Character"]){ //Should never happen, since we can only save Shadowrun Character files.
        *outError = [NSError errorWithDomain:@"sr4cg" code:1 userInfo:nil];
    }
    loading = [data retain];
    loadType = typeName;
    if ( outError != NULL ) {
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
	}
    return YES;
}

-(void)actualLoad:(NSData *)data ofType:(NSString *)typeName{
    NSError *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
    NSXMLDocument * file = [[NSXMLDocument alloc] initWithData: data options:0 error:&outError];
    NSXMLElement* root = [file rootElement];
    NSArray* children = [root children];
    for (NSXMLElement * node in children) {
        if([[node name] isEqual:@"Missions"])
            [missions loadFromXML:node];
        else if([[node name] isEqual:@"General"])
            [general loadFromXML:node];
        else if([[node name] isEqual:@"Skills"])
            [skills loadFromXML:node];
        else if([[node name] isEqual:@"Spells"])
            [spells loadFromXML:node];
        else if([[node name] isEqual:@"Vehicles"])
            [vehicles loadFromXML:node];
    }
    [loading release];
    [file release];
    loading = nil;
    loadType = nil;
}

@end
