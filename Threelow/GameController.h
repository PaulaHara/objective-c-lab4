//
//  GameController.h
//  Threelow
//
//  Created by paula on 2018-08-21.
//  Copyright © 2018 paula. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameController : NSObject

@property NSMutableArray *dicesRolled;
@property int score;

- (id)initWithDiceArrays;

- (void)storeDicesRolled:(NSMutableArray *)aDicesRolled;

- (void)holdDiceByIndex:(int)diceNumber;

- (void)resetDices;

@end
