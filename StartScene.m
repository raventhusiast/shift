//
//  SKScene+StartScene.m
//  Shift
//
//  Created by Ronald Poeu on 30/5/15.
//  Copyright (c) 2015 Team3. All rights reserved.
//

#import "StartScene.h"
#import "GameScene.h"

@implementation StartScene: SKScene


-(void)didMoveToView:(SKView *)view {

    [self setBackgroundColor:[SKColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0]];
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    myLabel.text = @"Press ANY key to start!";
    myLabel.fontSize = 65;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    [self addChild:myLabel];
    
    
}

- (void)keyDown:(NSEvent *)event {
    [self handleKeyEvent:event keyDown:YES];
}

- (void)keyUp:(NSEvent *)event {
    [self handleKeyEvent:event keyDown:NO];
}

- (void)handleKeyEvent:(NSEvent *)event keyDown:(BOOL)downOrUp {
    SKScene *myScene = [[GameScene alloc] initWithSize:self.size];
    SKTransition *reveal = [SKTransition fadeWithDuration:0.5];
    [self.view presentScene:myScene transition:reveal];
}
@end

