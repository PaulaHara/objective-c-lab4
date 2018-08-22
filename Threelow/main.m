//
//  main.m
//  Threelow
//
//  Created by paula on 2018-08-21.
//  Copyright © 2018 paula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dice.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Dice *dice1 = [[Dice alloc] init];
        [dice1 rollDice];
        NSLog(@"Dice 1: %d", [dice1 currentValue]);
        
        Dice *dice2 = [[Dice alloc] init];
        [dice2 rollDice];
        NSLog(@"Dice 2: %d", [dice2 currentValue]);
        
        Dice *dice3 = [[Dice alloc] init];
        [dice3 rollDice];
        NSLog(@"Dice 3: %d", [dice3 currentValue]);
        
        Dice *dice4 = [[Dice alloc] init];
        [dice4 rollDice];
        NSLog(@"Dice 4: %d", [dice4 currentValue]);
        
        Dice *dice5 = [[Dice alloc] init];
        [dice5 rollDice];
        NSLog(@"Dice 5: %d", [dice5 currentValue]);
    }
    return 0;
}
