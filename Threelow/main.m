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
#import "NumberUtils.h"

void printDices(GameController *gameController);
Boolean verifyIfPlayerHasUnHoldDices(GameController *gameController);
void holdDices(GameController *gameController, int *numberOfDicesToHold);
void verifyFinalScoreAndIfPlayerHasUnHoldDices(GameController *gameController, Boolean *playerHasUnHoldDices,
                                               NSString *playerKey, NSMutableDictionary *players, NSString **winner);

int lowScore = 10000;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        char input[255];
        NSString *userInput, *winner, *wordNumber;
        NSMutableDictionary *players = [[NSMutableDictionary alloc] init];
        GameController *gameController = [[GameController alloc] initWithDiceArrays];
        int c, numPlayers;
        Boolean endGame = false, playerHasUnHoldDices;
        
        while(!endGame){
            playerHasUnHoldDices = true;
            printf("\nNew Game\nEnter the number of players: ");
            fgets(input, 255, stdin);
            wordNumber = [[[NSString stringWithUTF8String:input] lowercaseString] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            numPlayers = [NumberUtils getNumberizeWord:wordNumber];
            
            for(int numP = 1; numP <= numPlayers && !endGame; numP++){
                NSString *playerKey = @"Player";
                playerKey = [playerKey stringByAppendingFormat:@"%d", numP];
                NSLog(@"\n\n%@ Turn:", playerKey);
                
                while(playerHasUnHoldDices){
                    // 'new game' command is automatic, when all players finish their turn, the game reset
                    printf("\nroll - Roll dices\nreset - Reset all held dices:\nend - End game\n");
                    fgets(input, 255, stdin);
                    userInput = [[[NSString stringWithUTF8String:input] lowercaseString] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                    
                    if([userInput isEqualToString:@"roll"]){
                        [gameController rollDices];
                        verifyFinalScoreAndIfPlayerHasUnHoldDices(gameController, &playerHasUnHoldDices, playerKey, players, &winner);
                    }else if([userInput isEqualToString:@"reset"]){
                        NSLog(@"\n\nNumber of rolls made: %d", gameController.numberOfRolls);
                        [gameController resetDices];
                    }else if([userInput isEqualToString:@"rol1"]){
                        [gameController rollLoadedDice];
                        verifyFinalScoreAndIfPlayerHasUnHoldDices(gameController, &playerHasUnHoldDices, playerKey, players, &winner);
                    }else if([userInput isEqualToString:@"end"]){
                        endGame = true;
                        break;
                    }else{
                        printf("\nInvalid option!\nTry Again...(press enter)");
                    }
                    // This is to avoid jumping one user entry
                    while ( (c = getchar()) != '\n' && c != EOF );
                }
                
                [gameController restartGame];
                playerHasUnHoldDices = true;
            }
            if(!endGame){
                NSLog(@"\n\nGAME OVER!\nThe winner is %@!\nScore: %d", winner, lowScore);
            }
            lowScore = 10000;
        }
    }
    return 0;
}

Boolean verifyIfPlayerHasUnHoldDices(GameController *gameController){
    for(int i = 0; i < 5; i++){
        if(![[gameController.dicesRolled objectAtIndex:i] isDiceHold]){
            return true;
        }
    }
    return false;
}

void verifyFinalScoreAndIfPlayerHasUnHoldDices(GameController *gameController, Boolean *playerHasUnHoldDices,
                                               NSString *playerKey, NSMutableDictionary *players, NSString **winner) {
    *playerHasUnHoldDices = verifyIfPlayerHasUnHoldDices(gameController);
    
    if(!*playerHasUnHoldDices){
        int playerFinalScore = [gameController score];
        [players setObject:[NSNumber numberWithInteger:playerFinalScore] forKey:playerKey];
        
        if(lowScore > playerFinalScore){
            lowScore = playerFinalScore;
            *winner = playerKey;
        }
        
        NSLog(@"\n\n%@: ", playerKey);
        printf("Final score: %d\n", playerFinalScore);
        printf("Score to beat: %d\n", lowScore);
    }
}
