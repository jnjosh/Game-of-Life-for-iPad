//
//  GameDelegate.h
//  GameOfLife
//
//  Created by Josh Johnson on 10/11/10.
//  Copyright 2010 soda, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Game;

@protocol GameDelegate
- (void)gameDidUpdateMainBoard:(Game *)game;
@end
