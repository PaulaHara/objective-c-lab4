//
//  main.m
//  Threelow
//
//  Created by paula on 2018-08-21.
//  Copyright © 2018 paula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dice.h"
#import "GameController.h"

void printDices(GameController *gameController);
Boolean verifyIfPlayerHasUnHoldDices(GameController *gameController);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Dice *dice1 = [[Dice alloc] init];
        Dice *dice2 = [[Dice alloc] init];
        Dice *dice3 = [[Dice alloc] init];
        Dice *dice4 = [[Dice alloc] init];
        Dice *dice5 = [[Dice alloc] init];
        
        char input[255];
        NSString *userInput = @"roll";
        NSMutableArray *dicesRolled = [[NSMutableArray alloc] initWithCapacity:6];
        GameController *gameController = [[GameController alloc] initWithDiceArrays];
        int numberOfDicesToHold, c;
        Boolean playerHasUnHoldDice = true;
        
        while(playerHasUnHoldDice){
            printf("roll - Roll dices\nreset - Reset all held dices:\n");
            fgets(input, 255, stdin);
            userInput = [[[NSString stringWithUTF8String:input] lowercaseString] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            
            if([userInput isEqualToString:@"roll"]){
                [dice1 rollDice];
                [dice2 rollDice];
                [dice3 rollDice];
                [dice4 rollDice];
                [dice5 rollDice];
                
                [dicesRolled insertObject:dice1 atIndex:0];
                [dicesRolled insertObject:dice2 atIndex:1];
                [dicesRolled insertObject:dice3 atIndex:2];
                [dicesRolled insertObject:dice4 atIndex:3];
                [dicesRolled insertObject:dice5 atIndex:4];
                
                [gameController storeDicesRolled:dicesRolled];
                
                printDices(gameController);
                
                printf("\nHow many dices do you wanna hold:\n");
                scanf("%d", &numberOfDicesToHold);
                
                if(numberOfDicesToHold > 0){
                    printf("\nEnter the index of the dice(s) you wanna hold:\n");
                    int indexDice;
                    for(int index = 0; index < numberOfDicesToHold; index++){
                        scanf("%d", &indexDice);
                        if(indexDice > 0 && indexDice < 6){
                            [gameController holdDiceByIndex:(indexDice-1)];
                        }else{
                            printf("\nInvalid index!\nTry again...\n");
                            index--;
                        }
                    }
                    printDices(gameController);
                }
                
                playerHasUnHoldDice = verifyIfPlayerHasUnHoldDices(gameController);
            }else if([userInput isEqualToString:@"reset"]){
                [gameController resetDices];
                printDices(gameController);
            }else{
                printf("\nInvalid option!\nTry Again...(press enter)");
            }
            printf("\n");
            while ( (c = getchar()) != '\n' && c != EOF );
        }
    }
    return 0;
}

void printDices(GameController *gameController){
    NSMutableString *dicesToPrint = [[NSMutableString alloc] init];
    for(int i = 0; i < 5; i++){
        Dice *dice = [gameController.dicesRolled objectAtIndex:i];
        
        if([[gameController.dicesRolled objectAtIndex:i] isDiceHold]){
            [dicesToPrint appendFormat:@"D%d: [%d] ", i+1, [dice currentValue]];
        }else{
            [dicesToPrint appendFormat:@"D%d: %d ", i+1, [dice currentValue]];
        }
        
        [dicesToPrint appendFormat:@"- "];
        if(i == 4){
            [dicesToPrint appendFormat:@"Total Score: %d", [gameController score]];
        }
    }
    NSLog(@"\n\n%@", dicesToPrint);
}

Boolean verifyIfPlayerHasUnHoldDices(GameController *gameController){
    for(int i = 0; i < 5; i++){
        if(![[gameController.dicesRolled objectAtIndex:i] isDiceHold]){
            return true;
        }
    }
    return false;
}
