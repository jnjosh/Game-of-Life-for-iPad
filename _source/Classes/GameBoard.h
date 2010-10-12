//
//  GameBoard.h
//  GameOfLife
//
//  Created by Josh Johnson on 10/10/10.
//  Copyright 2010 soda, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameBoard : NSObject {
	NSUInteger rows;
	NSUInteger columns;
	
	NSMutableArray *cells;
}

@property (assign) NSUInteger rows;
@property (assign) NSUInteger columns;
@property (retain) NSMutableArray *cells;

+ (GameBoard *)copyBoard:(GameBoard *)oldBoard;
- (BOOL)isCellActiveAtX:(NSUInteger)x Y:(NSUInteger)y;
- (NSUInteger)neighborsForCellX:(NSUInteger)x CellY:(NSUInteger)y;

- (void)birthCellX:(NSUInteger)x cellY:(NSUInteger)y;
- (void)killCellX:(NSUInteger)x cellY:(NSUInteger)y;
- (void)clear;

@end
