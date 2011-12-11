//
//  Stats.m
//  SR4CG3
//
//  Created by David Munro on 16/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Stats.h"


@implementation Stats
-(int)strBase{
    return [self read:@"strBase"];
}
-(void)setStrBase:(int)value{
    [self write:@"strBase" value:value];
}
-(int)strCurr{
    return [self read:@"strCurr"];
}
-(void)setStrCurr:(int)value{
    [self write:@"strCurr" value:value];
}
-(int)bodBase{
    return [self read:@"bodBase"];
}
-(void)setBodBase:(int)value{
    [self write:@"bodBase" value:value];
}
-(int)bodCurr{
    return [self read:@"bodCurr"];
}
-(void)setBodCurr:(int)value{
    [self write:@"bodCurr" value:value];
}
-(int)agiBase{
    return [self read:@"agiBase"];
}
-(void)setAgiBase:(int)value{
    [self write:@"agiBase" value:value];
}
-(int)agiCurr{
    return [self read:@"agiCurr"];
}
-(void)setAgiCurr:(int)value{
    [self write:@"agiCurr" value:value];
}
-(int)reaBase{
    return [self read:@"reaBase"];
}
-(void)setReaBase:(int)value{
    [self write:@"reaBase" value:value];
}
-(int)reaCurr{
    return [self read:@"reaCurr"];
}
-(void)setReaCurr:(int)value{
    [self write:@"reaCurr" value:value];
}
-(int)logBase{
    return [self read:@"logBase"];
}
-(void)setLogBase:(int)value{
    [self write:@"logBase" value:value];
}
-(int)logCurr{
    return [self read:@"logCurr"];
}
-(void)setLogCurr:(int)value{
    [self write:@"logCurr" value:value];
}
-(int)intCurr{
    return [self read:@"intCurr"];
}
-(void)setIntCurr:(int)value{
    [self write:@"intCurr" value:value];
}
-(int)intBase{
    return [self read:@"intBase"];
}
-(void)setIntBase:(int)value{
    [self write:@"intBase" value:value];
}
-(int)wilCurr{
    return [self read:@"wilCurr"];
}
-(void)setWilCurr:(int)value{
    [self write:@"wilCurr" value:value];
}
-(int)wilBase{
    return [self read:@"wilBase"];
}
-(void)setWilBase:(int)value{
    [self write:@"wilBase" value:value];
}
-(int)chaCurr{
    return [self read:@"chaCurr"];
}
-(void)setChaCurr:(int)value{
    [self write:@"chaCurr" value:value];
}
-(int)chaBase{
    return [self read:@"chaBase"];
}
-(void)setChaBase:(int)value{
    [self write:@"chaBase" value:value];
}

@synthesize magBase;
@synthesize magCurr;
@synthesize resBase;
@synthesize resCurr;
@synthesize iniBase;
@synthesize iniCurr;
@synthesize inpBase;
@synthesize inpCurr;
@synthesize inaBase;
@synthesize inaCurr;
@synthesize iapBase;
@synthesize iapCurr;
@synthesize inmBase;
@synthesize inmCurr;
@synthesize impBase;
@synthesize impCurr;
@synthesize damBase;
@synthesize damCurr;
@synthesize stuBase;
@synthesize stuCurr;
-(id)init{
    self = [super init];
    stats = [[NSMutableDictionary alloc] init];
    return self;
}
-(int)read:(NSString*) key{
    return [[stats objectForKey:key] intValue];
}
-(void)write:(NSString*) key value: (int)value{
    NSNumber* temp2 = [stats objectForKey:key];
    [temp2 release];
    NSNumber * temp = [[NSNumber alloc] initWithInt:value];
    [stats setObject:temp forKey:key];
}



@end
