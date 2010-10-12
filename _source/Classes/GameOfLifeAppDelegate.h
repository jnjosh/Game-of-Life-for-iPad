//
//  GameOfLifeAppDelegate.h
//  GameOfLife
//
//  Created by Josh Johnson on 10/10/10.
//  Copyright 2010 soda, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameOfLifeViewController;

@interface GameOfLifeAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    GameOfLifeViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet GameOfLifeViewController *viewController;

@end

