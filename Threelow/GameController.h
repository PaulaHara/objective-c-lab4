//
//  GameController.h
//  Threelow
//
//  Created by paula on 2018-08-21.
//  Copyright © 2018 paula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dice.h"

@interface GameController : NSObject

@property Dice *d1;
@property Dice *d2;
@property Dice *d3;
@property Dice *d4;
@property Dice *d5;
@property NSMutableArray *dicesRolled;
@property int score;
@property int numberOfRolls;

- (id)initWithDiceArrays;

- (void)rollDices;

- (void)printDices;

- (void)holdDiceByIndex:(int)diceNumber;

- (void)resetDices;

- (void)restartGame;

@end
