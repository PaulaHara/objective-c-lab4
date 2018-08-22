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
        self.dicesRolled = [[NSMutableArray alloc] initWithCapacity:6];
    }
    return self;
}

- (void)storeDicesRolled:(NSMutableArray *)aDicesRolled{
    self.dicesRolled = aDicesRolled;
}

- (void)holdDice:(int)diceNumber{
    Dice *dice = [self.dicesRolled objectAtIndex:diceNumber];
    [dice holdDice:!(dice.isDiceHold)];
}

@end
