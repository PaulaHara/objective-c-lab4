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
        Dice *dice2 = [[Dice alloc] init];
        Dice *dice3 = [[Dice alloc] init];
        Dice *dice4 = [[Dice alloc] init];
        Dice *dice5 = [[Dice alloc] init];
        
        char input[255];
        NSString *userInput = @"roll";
        
        while([userInput isEqualToString:@"roll"]){
            printf("To roll the dices type 'roll':\n");
            fgets(input, 255, stdin);
            userInput = [[[NSString stringWithUTF8String:input] lowercaseString] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            
            [dice1 rollDice];
            [dice2 rollDice];
            [dice3 rollDice];
            [dice4 rollDice];
            [dice5 rollDice];
            
            NSLog(@"\nD1: %d - D2: %d - D3: %d - D4: %d - D5: %d", [dice1 currentValue], [dice2 currentValue], [dice3 currentValue], [dice4 currentValue], [dice5 currentValue]);
            printf("\n");
        }
    }
    return 0;
}
