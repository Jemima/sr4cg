//
//  Data.h
//  SR4CG3
//
//  Created by David Munro on 16/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Data : NSObject {
    NSMutableDictionary* data;
}
@property (retain) NSMutableDictionary* data;
-(NSXMLDocument*)loadFromFile:(NSString*)path;
-(NSMutableDictionary*)makeDictionaryFromNode:(NSXMLElement*)node;
@end
