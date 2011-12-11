//
//  Stats.h
//  SR4CG3
//
//  Created by David Munro on 16/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Stats : NSObject {
    NSMutableDictionary* stats;
    int strBase;
    int strCurr;
    int bodBase;
    int bodCurr;
    int agiBase;
    int agiCurr;
    int reaBase;
    int reaCurr;
    int logBase;
    int logCurr;
    int intBase;
    int intCurr;
    int wilBase;
    int wilCurr;
    int chaBase;
    int chaCurr;
    
    int magBase;
    int magCurr;
    int resBase;
    int resCurr;
    int iniBase;
    int iniCurr;
    int inpBase;
    int inpCurr;
    int inaBase;
    int inaCurr;
    int iapBase;
    int iapCurr;
    int inmBase;
    int inmCurr;
    int impBase;
    int impCurr;
    int damBase;
    int damCurr;
    int stuBase;
    int stuCurr;
}

@property (getter=getAttribute) int strBase;
@property int strCurr;
@property int bodBase;
@property int bodCurr;
@property int agiBase;
@property int agiCurr;
@property int reaBase;
@property int reaCurr;
@property int logBase;
@property int logCurr;
@property int intBase;
@property int intCurr;
@property int wilBase;
@property int wilCurr;
@property int chaBase;
@property int chaCurr;

@property int magBase;
@property int magCurr;
@property int resBase;
@property int resCurr;
@property int iniBase;
@property int iniCurr;
@property int inpBase;
@property int inpCurr;
@property int inaBase;
@property int inaCurr;
@property int iapBase;
@property int iapCurr;
@property int inmBase;
@property int inmCurr;
@property int impBase;
@property int impCurr;
@property int damBase;
@property int damCurr;
@property int stuBase;
@property int stuCurr;


-(int)read:(NSString*) key;
-(void)write:(NSString*) key value: (int)value;
@end
