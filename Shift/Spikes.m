//
//  SKSpriteNode+Spikes.m
//  Shift
//
//  Created by Ronald Poeu on 31/5/15.
//  Copyright (c) 2015 Team3. All rights reserved.
//

#import "Spikes.h"
#import "GameScene.h"

@implementation Spikes: SKSpriteNode


- (BOOL) collisionWithPlayer:(SKNode *)player
{
    // Boost the player up
    //[GameScene gameOver];
    
    // The HUD needs updating to show the new stars and score
    return YES;
}

@end
