//
//  GameOfLifeViewController.h
//  GameOfLife
//
//  Created by Josh Johnson on 10/10/10.
//  Copyright 2010 soda, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameDelegate.h"

@class Game, GameBoard;

@interface GameOfLifeViewController : UIViewController <GameDelegate> {
	IBOutlet UIView *gridView;
	IBOutlet UIBarButtonItem *toggleButton;
	
	Game *currentGame;
}

- (IBAction)resetGame;
- (IBAction)toggleGameState;

- (void)toggleCellState:(id)sender;

- (void)setupBoard:(GameBoard *)board;
- (void)updateBoard:(GameBoard *)board;
@end

