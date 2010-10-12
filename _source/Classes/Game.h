//
//  Game.h
//  GameOfLife
//
//  Created by Josh Johnson on 10/10/10.
//  Copyright 2010 soda, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameDelegate.h"

@class GameBoard;

@interface Game : NSObject {
	GameBoard *mainBoard;
	BOOL running;

@private
	NSTimer *runTimer;
	NSObject<GameDelegate> *delegate;
}

@property (retain) GameBoard *mainBoard;
@property (assign) BOOL running;
@property (assign) NSObject<GameDelegate> *delegate;

- (void)generateNextIteration;

- (void)startGame;
- (void)endGame;
- (void)resetGame;
@end
