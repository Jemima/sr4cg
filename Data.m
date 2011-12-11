//
//  Data.m
//  SR4CG3
//
//  Created by David Munro on 16/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Data.h"


@implementation Data
@synthesize data;
-(id)init{
    self = [super init];
    data = [[NSMutableDictionary alloc] init];
    
    
    return self;
}
-(NSXMLDocument*)loadFromFile:(NSString*)path{
    NSURL * basePath = [NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]];
    NSURL * url = [NSURL URLWithString:path relativeToURL:basePath];
    NSError * err = [[NSError alloc] init];
    NSXMLDocument* file = [[NSXMLDocument alloc] initWithContentsOfURL:url options:0 error:&err];
    if(file == nil)
    {
        [err release];
        return nil;
    }
    NSXMLElement * root = [file rootElement];
    data = [self makeDictionaryFromNode:root];
    return file;
}
-(NSMutableDictionary*)makeDictionaryFromNode:(NSXMLElement*)node{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    NSXMLNode * att = [node attributeForName:@"type"];
    if(att != nil && [[att stringValue] isEqual:@"array"]){
        NSString* name;
        NSMutableArray* arr = [[NSMutableArray alloc] init];
        for (NSXMLElement* n in [node children]) {
            name = [n name];
            if([n childCount] == 0){
                [dict release];
                return nil;
            }else{
                [arr addObject:[self makeDictionaryFromNode:n]];
            }
        }
        [dict setValue:arr forKey:name];
    }else {
        for (NSXMLElement* n in [node children]) {
            if([n childCount] == 0){
                [dict release];
                return nil;
            }else{
                NSMutableDictionary* temp = [self makeDictionaryFromNode:n];
                if(temp == nil)
                    [dict setValue:[n stringValue] forKey:[n name]];
                else
                    [dict setValue:temp forKey:[n name]];
            }
        }
    }
    return dict;
}

@end
