//
//  GameController.m
//  Threelow
//
//  Created by paula on 2018-08-21.
//  Copyright © 2018 paula. All rights reserved.
//

#import "GameController.h"

@implementation GameController

- (id)initWithDiceArrays{
    self = [super init];
    if(self){
        self.d1 = [[Dice alloc] init];
        self.d2 = [[Dice alloc] init];
        self.d3 = [[Dice alloc] init];
        self.d4 = [[Dice alloc] init];
        self.d5 = [[Dice alloc] init];
        self.dicesRolled = [[NSMutableArray alloc] initWithCapacity:5];
    }
    return self;
}

- (void)rollDices{
    if(self.numberOfRolls < 5){
        [self.d1 rollDice];
        [self.d2 rollDice];
        [self.d3 rollDice];
        [self.d4 rollDice];
        [self.d5 rollDice];
        
        [self.dicesRolled insertObject:self.d1 atIndex:0];
        [self.dicesRolled insertObject:self.d2 atIndex:1];
        [self.dicesRolled insertObject:self.d3 atIndex:2];
        [self.dicesRolled insertObject:self.d4 atIndex:3];
        [self.dicesRolled insertObject:self.d5 atIndex:4];
        
        [self printDices];
        
        self.numberOfRolls++;
        
        int numberOfDicesToHold = 0;
        while(numberOfDicesToHold == 0){
            printf("\nHow many dices do you wanna hold:\n");
            // I'm not validating if the input is not a number, if it's not the game will get stuck in an infinite loop
            scanf("%d", &numberOfDicesToHold);
            
            if(numberOfDicesToHold > 0){
                printf("\nEnter the number of the dice(s) you wanna hold:\n");
                int indexDice;
                for(int index = 0; index < numberOfDicesToHold; index++){
                    // Same here
                    scanf("%d", &indexDice);
                    if(indexDice > 0 && indexDice < 6){
                        [self holdDiceByIndex:(indexDice-1)];
                    }else{
                        printf("\nInvalid index!\nTry again...\nEnter the number of the dice(s) you wanna hold:\n");
                        index--;
                    }
                }
                [self printDices];
            }else{
                printf("\nYou have to hold at least 1 dice.\nTry Again...\n");
            }
        }
        numberOfDicesToHold = 0;
    }else{
        NSLog(@"\n\nYou can't roll again, you need to reset.");
    }
}

- (void) printDices{
    NSMutableString *dicesToPrint = [[NSMutableString alloc] init];
    for(int i = 0; i < 5; i++){
        Dice *dice = [self.dicesRolled objectAtIndex:i];
        
        if([[self.dicesRolled objectAtIndex:i] isDiceHold]){
            [dicesToPrint appendFormat:@"D%d: [%d] ", i+1, [dice currentValue]];
        }else{
            [dicesToPrint appendFormat:@"D%d: %d ", i+1, [dice currentValue]];
        }
        
        [dicesToPrint appendFormat:@"- "];
        if(i == 4){
            [dicesToPrint appendFormat:@"Total Score: %d", self.score];
        }
    }
    NSLog(@"\n\n%@", dicesToPrint);
}

- (void)holdDiceByIndex:(int)diceNumber{
    Dice *dice = [self.dicesRolled objectAtIndex:diceNumber];
    [dice holdDice:!(dice.isDiceHold)];
    
    self.score = 0;
    for(int index = 0; index < 5; index++){
        Dice *dice = [self.dicesRolled objectAtIndex:index];
        if([dice isDiceHold]){
            if([dice currentValue] != 3){
                self.score += [dice currentValue];
            }
        }
    }
}

- (void)resetDices{
    if(self.dicesRolled[0] != nil){
        for(int index = 0; index < 5; index++){
            [[self.dicesRolled objectAtIndex:index] holdDice:false];
        }
    }
    self.score = 0;
    self.numberOfRolls = 0;
    [self printDices];
}

- (void)restartGame{
    [self.dicesRolled removeAllObjects];
    self.score = 0;
    self.numberOfRolls = 0;
    [self.d1 holdDice:false];
    [self.d2 holdDice:false];
    [self.d3 holdDice:false];
    [self.d4 holdDice:false];
    [self.d5 holdDice:false];
}

@end
