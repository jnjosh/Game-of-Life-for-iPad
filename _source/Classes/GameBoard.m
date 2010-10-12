//
//  GameBoard.m
//  GameOfLife
//
//  Created by Josh Johnson on 10/10/10.
//  Copyright 2010 soda, LLC. All rights reserved.
//

#import "GameBoard.h"
#import "GameCell.h"

#define ROWS 23
#define COLUMNS 23

@interface GameBoard () 
- (void)setupBoard;
@end

@implementation GameBoard

- (id)init {
	if (self = [super init]) {
		[self setRows:ROWS];
		[self setColumns:COLUMNS];
		
		[self setupBoard];
	}
	return self;
}

- (void)dealloc {
	[cells release], cells = nil;
	[super dealloc];
}

+ (GameBoard *)copyBoard:(GameBoard *)oldBoard;
{
	GameBoard *newBoard = [[GameBoard alloc] init];
	[newBoard setCells:[[oldBoard cells] copy]];
	return [newBoard autorelease];
}

- (void)setupBoard;
{
	[cells release], cells = nil;
	cells = [[NSMutableArray alloc] initWithCapacity:ROWS];
	for (int xIterate = 0; xIterate <= ROWS; xIterate++) {
		NSMutableArray *cols = [[NSMutableArray alloc] initWithCapacity:COLUMNS];
		for (int yIterate = 0; yIterate <= COLUMNS; yIterate++) {
			GameCell *newCell	= [[GameCell alloc] init];
			[cols addObject:newCell];
		}
		[cells addObject:cols];
	}
}

- (BOOL)isCellActiveAtX:(NSUInteger)x Y:(NSUInteger)y;
{
	if (x < 0 || y < 0) return NO;
	if (x > ROWS || y > COLUMNS) return NO;
	return [[[cells objectAtIndex:x] objectAtIndex:y] isAlive];
}

- (NSUInteger)neighborsForCellX:(NSUInteger)x CellY:(NSUInteger)y;
{
	NSUInteger livingNeighbors = 0;
	
	if ([self isCellActiveAtX:(x - 1) Y:(y - 1)])
		livingNeighbors++;
	if ([self isCellActiveAtX:x Y:(y - 1)])
		livingNeighbors++;
	if ([self isCellActiveAtX:(x + 1) Y:(y - 1)])
		livingNeighbors++;
	if ([self isCellActiveAtX:(x - 1) Y:y])
		livingNeighbors++;
	if ([self isCellActiveAtX:(x + 1) Y:y])
		livingNeighbors++;
	if ([self isCellActiveAtX:(x - 1) Y:(y + 1)])
		livingNeighbors++;
	if ([self isCellActiveAtX:x Y:(y + 1)])
		livingNeighbors++;
	if ([self isCellActiveAtX:(x + 1) Y:(y + 1)])
		livingNeighbors++;
	
	return livingNeighbors;
}

- (void)birthCellX:(NSUInteger)x cellY:(NSUInteger)y;
{
	GameCell *cell = [[cells objectAtIndex:x] objectAtIndex:y];
	[cell setAlive:YES];
}

- (void)killCellX:(NSUInteger)x cellY:(NSUInteger)y;
{
	GameCell *cell = [[cells objectAtIndex:x] objectAtIndex:y];
	[cell setAlive:NO];
}

- (void)clear; 
{
	[self setupBoard];
}

@synthesize rows, columns, cells;
@end
