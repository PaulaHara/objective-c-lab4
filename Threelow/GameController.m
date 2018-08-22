//
//  GameController.m
//  Threelow
//
//  Created by paula on 2018-08-21.
//  Copyright © 2018 paula. All rights reserved.
//

#import "GameController.h"
#import "Dice.h"

@implementation GameController

- (id)initWithDiceArrays{
    self = [super init];
    if(self){
        self.dicesRolled = [[NSMutableArray alloc] initWithCapacity:5];
    }
    return self;
}

- (void)storeDicesRolled:(NSMutableArray *)aDicesRolled{
    self.dicesRolled = aDicesRolled;
}

- (void)holdDiceByIndex:(int)diceNumber{
    Dice *dice = [self.dicesRolled objectAtIndex:diceNumber];
    [dice holdDice:!(dice.isDiceHold)];
    
    self.score = 0;
    for(int index = 0; index < 5; index++){
        Dice *dice = [self.dicesRolled objectAtIndex:index];
        if([dice isDiceHold]){
            self.score += [dice currentValue];
        }
    }
}

- (void)resetDices{
    for(int index = 0; index < 5; index++){
        [[self.dicesRolled objectAtIndex:index] holdDice:false];
    }
    self.score = 0;
}

@end
