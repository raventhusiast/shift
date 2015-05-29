//
//  GameScene.m
//  Shift
//
//  Created by Ronald Poeu on 22/5/15.
//  Copyright (c) 2015 Team3. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene
{
    
    SKSpriteNode *_character;
    NSArray *_WalkingFrames;
    NSArray *_JumpingFrames;
    
}
-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    myLabel.text = @"SHIFT to start!";
    myLabel.fontSize = 65;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    [self addChild:myLabel];
    
    NSMutableArray *walkFrames = [NSMutableArray array];
    SKTextureAtlas *characterAnimatedAtlas = [SKTextureAtlas atlasNamed:@"Character"];
    
    NSString *textureName = [NSString stringWithFormat:@"still"];
    SKTexture *temp = [characterAnimatedAtlas textureNamed:textureName];
    [walkFrames addObject:temp];
    NSString *textureName2 = [NSString stringWithFormat:@"run"];
    SKTexture *temp2 = [characterAnimatedAtlas textureNamed:textureName2];
    [walkFrames addObject:temp2];
    
    _WalkingFrames = walkFrames;
    
    SKTexture *temp3 = _WalkingFrames[0];
    _character = [SKSpriteNode spriteNodeWithTexture:temp3];
    _character.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:_character];
    //[self walking];
    
}

-(void)walking
{
    //This is our general runAction method to make our bear walk.
    [_character runAction:
                      [SKAction animateWithTextures:_WalkingFrames
                                       timePerFrame:0.1f
                                             resize:NO
                                            restore:YES]];
    return;
}

-(void)moveRightChar
{
    [_character setTexture:[SKTexture textureWithImageNamed:@"run"]];
    
    CGPoint moveDifference = CGPointMake(_character.position.x+20, _character.position.y);
    [_character runAction:[SKAction moveTo:moveDifference duration:0.5]];  //3
    
    
}
-(void)moveLeftChar
{
    [_character setTexture:[SKTexture textureWithImageNamed:@"run"]];
    CGPoint moveDifference = CGPointMake(_character.position.x-20, _character.position.y);
    [_character runAction:[SKAction moveTo:moveDifference duration:1]];  //3
}

-(void)characterMoveEnded
{
    [_character setTexture:[SKTexture textureWithImageNamed:@"still"]];
}




- (void)keyDown:(NSEvent *)event {
    [self handleKeyEvent:event keyDown:YES];
}

- (void)keyUp:(NSEvent *)event {
    [self handleKeyEvent:event keyDown:NO];
}

- (void)handleKeyEvent:(NSEvent *)event keyDown:(BOOL)downOrUp {
    // First check the arrow keys since they are on the numeric keypad.
    if (downOrUp){
    if ([event modifierFlags] & NSNumericPadKeyMask) { // arrow keys have this mask
        NSString *theArrow = [event charactersIgnoringModifiers];
        unichar keyChar = 0;
        if ([theArrow length] == 1) {
            keyChar = [theArrow characterAtIndex:0];
            switch (keyChar) {
                case NSUpArrowFunctionKey:
                    //self.defaultPlayer.moveForward = downOrUp;
                    break;
                case NSLeftArrowFunctionKey:
                    //self.defaultPlayer.moveLeft = downOrUp;
                    [self moveLeftChar];
                    break;
                case NSRightArrowFunctionKey:
                    //[self walking];
                    [self moveRightChar];
                    
                    //[self characterMoveEnded];
                    
                    
                    
                    
                    break;
                case NSDownArrowFunctionKey:
                    //self.defaultPlayer.moveBack = downOrUp;
                    break;
            }
        }
    }
    }
    else{
        NSString *theArrow = [event charactersIgnoringModifiers];
        unichar keyChar = 0;
        if ([theArrow length] == 1) {
            keyChar = [theArrow characterAtIndex:0];
            switch (keyChar) {
                case NSUpArrowFunctionKey:
                    //self.defaultPlayer.moveForward = downOrUp;
                    break;
                case NSLeftArrowFunctionKey:
                    //self.defaultPlayer.moveLeft = downOrUp;
                    [self characterMoveEnded];
                    break;
                case NSRightArrowFunctionKey:
                    //[self walking];
                    //[self moveRightChar];
                    
                    [self characterMoveEnded];
                    
                    
                    
                    
                    break;
                case NSDownArrowFunctionKey:
                    //self.defaultPlayer.moveBack = downOrUp;
                    break;
            }
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
