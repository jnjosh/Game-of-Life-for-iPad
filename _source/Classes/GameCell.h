//
//  GameCell.h
//  GameOfLife
//
//  Created by Josh Johnson on 10/10/10.
//  Copyright 2010 soda, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GameCell : NSObject {
	BOOL alive;
}
@property (assign, getter=isAlive) BOOL alive;

@end
