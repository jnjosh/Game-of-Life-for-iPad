//
//  GameOfLifeViewController.m
//  GameOfLife
//
//  Created by Josh Johnson on 10/10/10.
//  Copyright 2010 soda, LLC. All rights reserved.
//

#import "GameOfLifeViewController.h"
#import "GameBoard.h"
#import "Game.h"
#import "NSObject+AssociatedObjects.h"
#import <QuartzCore/QuartzCore.h>

@implementation GameOfLifeViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	if (currentGame == nil) {
		currentGame = [[Game alloc] init];
		[currentGame setDelegate:self];
	}
	[self setupBoard:[currentGame mainBoard]];
}

- (void)toggleCellState:(id)sender;
{
	UIButton *btn = (UIButton *)sender;
	NSUInteger col = [[btn associatedValueForKey:@"ycol"] intValue];
	NSUInteger row = [[btn associatedValueForKey:@"xrow"] intValue];
	
	// update ui
	[btn setSelected:![btn isSelected]];
	if ([btn isSelected]) {
		[btn setBackgroundColor:[UIColor blackColor]];
	} else {
		[btn setBackgroundColor:[UIColor whiteColor]];
	}
	
	// update board
	[[currentGame mainBoard] birthCellX:row cellY:col];
}

- (void)setupBoard:(GameBoard *)board;
{
	NSUInteger rows = [[currentGame mainBoard] rows];
	NSUInteger cols = [[currentGame mainBoard] columns];
	CGSize cellSize = { gridView.frame.size.width / cols, gridView.frame.size.height / rows };
	CGPoint insertPoint = CGPointZero;
	
	for (int x = 0; x <= rows; x++) {
		for (int y = 0; y <= cols; y++) {
			UIButton *newButton = [UIButton buttonWithType:UIButtonTypeCustom];
			CGRect newButtonFrame = { insertPoint, cellSize };
			[newButton associateValue:[NSNumber numberWithInt:x] withKey:@"xrow"];
			[newButton associateValue:[NSNumber numberWithInt:y] withKey:@"ycol"];
			[newButton setFrame:newButtonFrame];
			[newButton setSelected:NO];
			[newButton setBackgroundColor:[UIColor whiteColor]];
			[[newButton layer] setCornerRadius:5.0f];
			[[newButton layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
			[[newButton layer] setBorderWidth:1.0f];
			[newButton addTarget:self action:@selector(toggleCellState:) forControlEvents:UIControlEventTouchUpInside];
			[gridView addSubview:newButton];
			insertPoint.x += cellSize.width;
		}
		insertPoint.x	= 0;
		insertPoint.y += cellSize.height;
	}
}

- (void)updateBoard:(GameBoard *)board;
{
	for (UIView *cell in [gridView subviews]) {
		if (![cell isKindOfClass:[UIButton class]]) continue;
		
		NSUInteger row = [[cell associatedValueForKey:@"xrow"] intValue];
		NSUInteger col = [[cell associatedValueForKey:@"ycol"] intValue];
		if (row < 0 || row > [board rows]) continue;
		if (col < 0 || col > [board columns]) continue;		
		
		if ([board isCellActiveAtX:row Y:col]) {
			[(UIButton *)cell setSelected:YES];
			[(UIButton *)cell setBackgroundColor:[UIColor blackColor]];
		}
		else {
			[(UIButton *)cell setSelected:NO];
			[(UIButton *)cell setBackgroundColor:[UIColor whiteColor]];
		}
	}
}

- (void)gameDidUpdateMainBoard:(Game *)game
{
	[self updateBoard:[game mainBoard]];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return interfaceOrientation == UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (IBAction)resetGame;
{
	if (currentGame != nil) {
		[currentGame resetGame];
		[self gameDidUpdateMainBoard:currentGame];
	}
}

- (IBAction)toggleGameState;
{
	if ([currentGame running]) {
		[currentGame endGame];
		[toggleButton setTitle:@"Start"];
	} else {
		[currentGame startGame];
		[toggleButton setTitle:@"Stop"];
	}

}

- (void)dealloc {
	[gridView release];
	[currentGame release];
	[super dealloc];
}

@end
