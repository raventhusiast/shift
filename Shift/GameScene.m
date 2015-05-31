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
    SKSpriteNode *black;
    SKSpriteNode *white;
    SKSpriteNode *black_spikes;
    SKSpriteNode *white_spikes;
    BOOL isBlack;
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

-(void)initBlackTiles
{
    //create ground
    SKTexture* blackTexture = [SKTexture textureWithImageNamed:@"Tile"];
    blackTexture.filteringMode = SKTextureFilteringNearest;
    
    
    //list of black tiles
    
    
    
    for( int i = 0; i < 16 + self.frame.size.width / ( blackTexture.size.width * 2 ); ++i ) {
        // Create the sprite
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:blackTexture];
        [sprite setScale:0.5];
        sprite.position = CGPointMake(i * sprite.size.width/2, sprite.size.height / 2);
        sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(sprite.size.width, sprite.size.height)];
        sprite.physicsBody.dynamic = NO;
        //turn collision off
        sprite.physicsBody.collisionBitMask = 0;
        [black addChild:sprite];
        //[self addChild:sprite];
    }
    
    [self addChild:black];
}

-(void)initWhiteTiles
{
    //list of white tiles
    
    SKTexture* whiteTexture = [SKTexture textureWithImageNamed:@"White_Tile"];
    whiteTexture.filteringMode = SKTextureFilteringNearest;
    
    
    for( int i = 0; i < 16 + self.frame.size.width / ( whiteTexture.size.width * 2 ); ++i ) {
        // Create the sprite
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:whiteTexture];
        [sprite setScale:0.5];
        sprite.position = CGPointMake(i * sprite.size.width/2, sprite.size.height / 2+ 500);
        sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(sprite.size.width, sprite.size.height)];
        sprite.physicsBody.dynamic = NO;
        
        //turn colision off
        sprite.physicsBody.categoryBitMask = 0;
        [white addChild:sprite];
        //[self addChild:sprite];
    }
    
    [self addChild:white];
   
}
-(void)initTiles: (int[10][15]) array
{
    for(int i=0; i<10; i++){
        for(int j=0; j<15; j++){
            int temp = array[i][j];
            if (temp ==0){
                /*
                SKTexture* whiteTexture = [SKTexture textureWithImageNamed:@"White_Tile"];
                whiteTexture.filteringMode = SKTextureFilteringNearest;
                SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:whiteTexture];
                [sprite setScale:0.5];
                sprite.position = CGPointMake((j+0.5) * (sprite.size.width), (i+0.5)*(sprite.size.height));
                sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(sprite.size.width, sprite.size.height)];
                sprite.physicsBody.dynamic = NO;
                
                //turn colision off
                sprite.physicsBody.categoryBitMask = 0;
                [white addChild:sprite];
                 */
            }
            else if (temp == 1){
                SKTexture* blackTexture = [SKTexture textureWithImageNamed:@"Tile"];
                blackTexture.filteringMode = SKTextureFilteringNearest;
                SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:blackTexture];
                [sprite setScale:0.5];
                sprite.position = CGPointMake((j+0.5) * (sprite.size.width), (i+0.5)*(sprite.size.height));
                sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(sprite.size.width, sprite.size.height)];
                sprite.physicsBody.dynamic = NO;
                //turn collision off
                sprite.physicsBody.collisionBitMask = 0;
                [black addChild:sprite];
            }
            else if (temp == 2){
                
            }
            else if (temp == 3){
                SKTexture* blackTexture = [SKTexture textureWithImageNamed:@"Black_Spike_Up"];
                blackTexture.filteringMode = SKTextureFilteringNearest;
                SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:blackTexture];
                [sprite setScale:0.5];
                sprite.position = CGPointMake((j+0.5) * (sprite.size.width), (i+0.25)*(sprite.size.height)*2);
                sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(sprite.size.width, sprite.size.height)];
                sprite.physicsBody.dynamic = NO;
                //turn collision off
                sprite.physicsBody.collisionBitMask = 0;
                [black_spikes addChild:sprite];
            }
            
        }
    }
    [self addChild:black];
    [self addChild:white];
    [self addChild:black_spikes];
    [self addChild:white_spikes];
}

-(void)changeTiles
{
    //if (isBlack){
        //[white removeFromParent];
      //  [self addChild:black];
    //}
   // else{
        //[black removeFromParent];
      //  [self addChild:white];
    //}
}

-(void)newGame: (int) lvl
{
    int lvl_array[10][15] = {
        {1,3,3,3,3,3,3,3,3,3,3,1,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
        {1,0,0,0,0,0,1,1,1,1,0,1,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,1,0,1},
        {1,0,0,0,1,1,1,0,0,0,0,0,0,0,1},
        {1,0,0,0,1,3,1,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,1,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
    };
    
    
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
    isBlack = true;
    
    
    black = [SKSpriteNode new];
    white = [SKSpriteNode new];
    black_spikes = [SKSpriteNode new];
    white_spikes = [SKSpriteNode new];
    [self initTiles: lvl_array];
    SKTexture *temp3 = [SKTexture textureWithImageNamed:@"still"];
    _character = [SKSpriteNode spriteNodeWithTexture:temp3];
    [_character setScale:0.3];
    
    
    
    _character.position = CGPointMake(160, 360);
    _character.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_character.size];
    _character.physicsBody.dynamic = YES;
    _character.physicsBody.allowsRotation = NO;

    //[self walking];
    
    
    //[self initBlackTiles];
    //[self initWhiteTiles];
    [self addChild:_character];
    
    

    
    
    Platform *platform = [self createPlatformAtPosition:CGPointMake(160, 320)];
    [self addChild:platform];
    Platform *platform2 = [self createPlatformAtPosition:CGPointMake(860, 500)];
    [self addChild:platform2];
}

- (Platform *) createPlatformAtPosition:(CGPoint)position
{
    // 1
    Platform *node = [Platform node];
    [node setPosition:position];
    [node setName:@"NODE_PLATFORM"];
    
    
    // 2
    SKSpriteNode *sprite;
    
    sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Door"];
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
    //[_character setTexture:[SKTexture textureWithImageNamed:@"run"]];
    
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

-(void)changePosition: (SKSpriteNode*) colOnTileList  with: (SKSpriteNode*) colOfTileList{
    
    for(SKSpriteNode *colOfTile in colOfTileList.children){
        colOfTile.physicsBody.dynamic = YES;
        colOfTile.position = CGPointMake(colOfTile.position.x, colOfTile.position.y * -1 + self.size.height);
        colOfTile.physicsBody.categoryBitMask = 0;
        colOfTile.physicsBody.dynamic = NO;
    }
    
    for(SKSpriteNode *colOnTile in colOnTileList.children){
        
        colOnTile.physicsBody.dynamic = YES;
        colOnTile.position = CGPointMake(colOnTile.position.x, colOnTile.position.y * -1 + self.size.height);
        colOnTile.physicsBody.categoryBitMask = 1;

        colOnTile.physicsBody.dynamic = NO;
    }
    
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
                    
                    isBlack = !(isBlack);
                    [self changeTiles];
                    //[self gameOver];
                    break;
                    
                case 'w':
                    
                    if(isBlack){
                        [self changePosition: black  with: white ];
                        isBlack = false;
                    } else {
                        [self changePosition: white  with: black ];
                        isBlack = true;
                    }

                    
                    
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
