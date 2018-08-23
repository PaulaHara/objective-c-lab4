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
void holdDices(GameController *gameController, int *numberOfDicesToHold);

int lowScore = 10000;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        char input[255];
        NSString *userInput, *winner;
        NSMutableDictionary *players = [[NSMutableDictionary alloc] init];
        GameController *gameController = [[GameController alloc] initWithDiceArrays];
        int c, numPlayers;
        Boolean endGame = false, playerHasUnHoldDices;
        
        while(!endGame){
            playerHasUnHoldDices = true;
            printf("Enter the number of players: ");
            // I'm not validating if the input is not a number, if it's not the game will get stuck in an infinite loop
            scanf("%d", &numPlayers);
            while ( (c = getchar()) != '\n' && c != EOF );
            
            for(int numP = 1; numP <= numPlayers; numP++){
                NSString *playerKey = @"Player";
                playerKey = [playerKey stringByAppendingFormat:@"%d", numP];
                NSLog(@"\n\n%@ Turn:", playerKey);
                
                while(playerHasUnHoldDices){
                    // new game command is automatic, when the player finish his turn, the game reset
                    printf("\nroll - Roll dices\nreset - Reset all held dices:\nend - End game\n");
                    fgets(input, 255, stdin);
                    userInput = [[[NSString stringWithUTF8String:input] lowercaseString] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                    
                    if([userInput isEqualToString:@"roll"]){
                        [gameController rollDices];
                        playerHasUnHoldDices = verifyIfPlayerHasUnHoldDices(gameController);
                        
                        if(!playerHasUnHoldDices){
                            int playerFinalScore = [gameController score];
                            [players setObject:[NSNumber numberWithInteger:playerFinalScore] forKey:playerKey];
                            
                            if(lowScore > playerFinalScore){
                                lowScore = playerFinalScore;
                                winner = playerKey;
                            }
                            
                            NSLog(@"\n%@: ", playerKey);
                            printf("Final score: %d\n", playerFinalScore);
                            printf("Score to beat: %d\n", lowScore);
                        }
                    }else if([userInput isEqualToString:@"reset"]){
                        NSLog(@"\n\nNumber of rolls made: %d", gameController.numberOfRolls);
                        [gameController resetDices];
                    }else if([userInput isEqualToString:@"end"]){
                        endGame = true;
                    }else{
                        printf("\nInvalid option!\nTry Again...(press enter)");
                    }
                    while ( (c = getchar()) != '\n' && c != EOF );
                }
                
                [gameController restartGame];
                playerHasUnHoldDices = true;
            }
            NSLog(@"\n\nGAME OVER!\nThe winner is %@!\nScore: %d", winner, lowScore);
            printf("\n");
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
