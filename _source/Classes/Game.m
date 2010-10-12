//
//  Game.m
//  GameOfLife
//
//  Created by Josh Johnson on 10/10/10.
//  Copyright 2010 soda, LLC. All rights reserved.
//

#import "Game.h"
#import "GameBoard.h"

@implementation Game

- (void)dealloc {
	[mainBoard release], mainBoard = nil;
	delegate = nil;
	[super dealloc];
}

- (id)init {
	if (self = [super init]) {
		[self setMainBoard:[[GameBoard alloc] init]];
	}
	return self;
}

- (void)generateNextIteration;
{
	NSUInteger xIterator;
	NSUInteger yIterator;
	
	GameBoard *newBoard = [GameBoard copyBoard:[self mainBoard]];
	for (xIterator = 0; xIterator <= [mainBoard rows]; xIterator++) {
		for (yIterator = 0; yIterator <= [mainBoard columns]; yIterator++) {
			NSUInteger livingNeighbors = [newBoard neighborsForCellX:xIterator CellY:yIterator];
			if (livingNeighbors < 2 || livingNeighbors > 3) {
				[mainBoard killCellX:xIterator cellY:yIterator];
			} else if (livingNeighbors == 3) {
				[mainBoard birthCellX:xIterator cellY:yIterator];
			}
		}
	}

	// notify delegate
	if ([delegate respondsToSelector:@selector(gameDidUpdateMainBoard:)]) {
		[delegate performSelector:@selector(gameDidUpdateMainBoard:) withObject:self];
	}
}

- (void)startGame;
{
	if (![self running]) {
		[self setRunning:YES];

		// start run loop
		runTimer = [[NSTimer scheduledTimerWithTimeInterval:0.5 
																								 target:self 
																							 selector:@selector(generateNextIteration) 
																							 userInfo:nil 
																								repeats:YES] retain];
	}
}

- (void)endGame;
{
	// end run loop
	[runTimer invalidate];
	[runTimer release];
	[self setRunning:NO];
}

- (void)resetGame;
{
	[[self mainBoard] clear];
}

@synthesize mainBoard, running, delegate;
@end
