//
//  GameScene.m
//  Shift
//
//  Created by Ronald Poeu on 22/5/15.
//  Copyright (c) 2015 Team3. All rights reserved.
//

#import "GameScene.h"
#import "Platform.h"
#import "StartScene.h"
#import "EndScene.h"

@implementation GameScene
{
    SKSpriteNode *_character;
    int lvl;
    
}
-(void)didMoveToView:(SKView *)view {
    [self newGame:lvl];
    //[self gotoStartScene];
    
}

-(void)gotoStartScene
{
    SKScene *myScene = [[StartScene alloc] initWithSize:self.size];
    SKTransition *reveal = [SKTransition fadeWithDuration:0.5];
    [self.view presentScene:myScene transition:reveal];
}

-(void)newGame: (int) lvl
{
    self.physicsWorld.gravity = CGVectorMake( 0.0, -5.0 );
    
    
    [self setBackgroundColor:[SKColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0]];
    /* Setup your scene here
     SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
     
     myLabel.text = @"SHIFT to start!";
     myLabel.fontSize = 65;
     myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
     CGRectGetMidY(self.frame));
     
     [self addChild:myLabel];
     */
    
    
    
    
    SKTexture *temp3 = [SKTexture textureWithImageNamed:@"still"];
    _character = [SKSpriteNode spriteNodeWithTexture:temp3];
    [_character setScale:0.5];
    
    
    
    _character.position = CGPointMake(160, 360);
    _character.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_character.size];
    _character.physicsBody.dynamic = YES;
    _character.physicsBody.allowsRotation = NO;
    [self addChild:_character];
    //[self walking];
    
    //create ground
    SKTexture* groundTexture = [SKTexture textureWithImageNamed:@"Tile"];
    groundTexture.filteringMode = SKTextureFilteringNearest;
    
    for( int i = 0; i < 16 + self.frame.size.width / ( groundTexture.size.width * 2 ); ++i ) {
        // Create the sprite
        SKSpriteNode* sprite = [SKSpriteNode spriteNodeWithTexture:groundTexture];
        [sprite setScale:0.5];
        sprite.position = CGPointMake(i * sprite.size.width/2, sprite.size.height / 2);
        sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(sprite.size.width, sprite.size.height)];
        sprite.physicsBody.dynamic = NO;
        
        [self addChild:sprite];
    }
    
    Platform *platform = [self createPlatformAtPosition:CGPointMake(160, 320)];
    [self addChild:platform];
}

- (Platform *) createPlatformAtPosition:(CGPoint)position
{
    // 1
    Platform *node = [Platform node];
    [node setPosition:position];
    [node setName:@"NODE_PLATFORM"];
    
    
    // 2
    SKSpriteNode *sprite;
    
    sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Tile"];
    [sprite setScale:0.5];
    [node addChild:sprite];
    
    // 3
    node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:sprite.size];
    node.physicsBody.dynamic = NO;
    //node.physicsBody.categoryBitMask = CollisionCategoryPlatform;
    node.physicsBody.collisionBitMask = 0;
    
    return node;
}



-(void)moveRightChar
{
    [_character setTexture:[SKTexture textureWithImageNamed:@"run"]];
    
    //CGPoint moveDifference = CGPointMake(_character.position.x+20, _character.position.y);
    //[_character runAction:[SKAction moveTo:moveDifference duration:0.2]];  //3
    //_character.physicsBody.velocity = CGVectorMake(0, 0);
    //[_character.physicsBody applyImpulse:CGVectorMake(40, 0)];
    _character.physicsBody.velocity = CGVectorMake(100.0f, _character.physicsBody.velocity.dy);
}
-(void)moveLeftChar
{
    //[_character setTexture:[SKTexture textureWithImageNamed:@"run"]];
    //CGPoint moveDifference = CGPointMake(_character.position.x-20, _character.position.y);
    //[_character runAction:[SKAction moveTo:moveDifference duration:0.2]];  //3
    _character.physicsBody.velocity = CGVectorMake(-100.0f, _character.physicsBody.velocity.dy);
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
                    //_character.physicsBody.velocity = CGVectorMake(0, 0);
                    //[_character.physicsBody applyImpulse:CGVectorMake(0, 250)];
                    _character.physicsBody.velocity = CGVectorMake(_character.physicsBody.velocity.dx, 450);
                    break;
                case NSLeftArrowFunctionKey:
                    //self.defaultPlayer.moveLeft = downOrUp;
                    //[self characterMoveEnded];
                    break;
                case NSRightArrowFunctionKey:
                    //[self walking];
                    //[self moveRightChar];
                    
                    //[self characterMoveEnded];
                    
                    
                    
                    
                    break;
                case NSDownArrowFunctionKey:
                    //self.defaultPlayer.moveBack = downOrUp;
                    //[self resetLvl];
                    [self gameOver];
                    break;
            }
        }
    }
}

-(void)gameOver
{
    SKScene *myScene = [[EndScene alloc] initWithSize:self.size];
    SKTransition *reveal = [SKTransition fadeWithDuration:0.5];
    [self.view presentScene:myScene transition:reveal];
}

-(void)resetLvl
{
    [self removeAllChildren];
    [self newGame:lvl];
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
