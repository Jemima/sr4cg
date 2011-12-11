//
//  Dice.m
//  SR4CG3
//
//  Created by David Munro on 29/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Dice.h"


@implementation Dice
-(IBAction) roll:(id)sender{
    /*
    arc4random_stir();
    int n = [number_dice intValue];
    int * rolls = (int*)malloc(n*sizeof(int));
    int res = [Dice doRolls:n:rolls];
    NSMutableString * ans = [[NSMutableString alloc] initWithCapacity:n*2];
    for(int i=0;i<n;i++){
        [ans appendFormat:@"%d ", rolls[i]];
    }
    int k = abs(res);
    if(res == -1)
        [result setStringValue:[NSString stringWithFormat:@"Critical Glitch!\n%@", ans]];
    else if(res < -1){
        NSString * res = [NSString stringWithFormat:@"%d hits.\nGlitch!\n%@", k-2, ans];
        [result setStringValue:res];
    }
    else
        [result setStringValue:[NSString stringWithFormat:@"%d hits.\n%@", res, ans]];
    free(rolls);
    [ans release];
     */
    NSString* ans;
    int n = [number_dice intValue];
    int hits = [Dice roll:n :&ans];
    [result setStringValue:ans];
}
-(IBAction) rollBlind:(id)sender{
    arc4random_stir();
    int lim = [limit intValue];
    int n = [number_dice intValue];
    NSMutableString * ans = [[[NSMutableString alloc] initWithCapacity:n*2] autorelease];
    int * rolls = (int*)malloc(n*sizeof(int));
    int res = [Dice doRolls:n:rolls];
    for(int n=0;n<lim;n++){
        
    }
    
    
}
-(IBAction) rollThreshold:(id)sender{
    
}
+(int)doRoll{
    unsigned n = arc4random()%6+1;
    return n;
}
+(int)doRolls:(int)number: (int *)rolls{
    int successes = 0;
    int ones = 0;
    for(int n=0;n<number;n++){
        int res = [self doRoll];
        if(res == 1)
            ones++;
        else if(res == 5 || res == 6)
            successes++;
        rolls[n] = res;
    }
    //-1 == critical glitch
    //-n == glitch, n-2 hits
    //n == n hits.
    if(ones >= ((number+1)/2)){
        if(successes == 0)
            return -1;
        return -(successes+2);
    }
    return successes;
}
+(int)roll:(int)nDice: (NSString**)str{
    arc4random_stir();
    int n = nDice;
    int * rolls = (int*)malloc(n*sizeof(int));
    int res = [self doRolls:n:rolls];
    NSMutableString * ans = [[[NSMutableString alloc] initWithCapacity:n*2] autorelease];
    for(int i=0;i<n;i++){
        [ans appendFormat:@"%d ", rolls[i]];
    }
    int k = abs(res);
    NSString* temp;
    free(rolls);
    if(res == -1){
        k = 0;
        temp = [NSString stringWithFormat:@"Critical Glitch!\n%@", ans];
    }
    else if(res < -1){
        k -= 2;
        temp = [NSString stringWithFormat:@"%d hits.\nGlitch!\n%@", k, ans];
    }
    else
        temp = [NSString stringWithFormat:@"%d hits.\n%@", res, ans];
    *str = temp;
    return k;
}
@end
