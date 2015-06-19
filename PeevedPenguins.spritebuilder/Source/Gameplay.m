//
//  Gameplay.m
//  PeevedPenguins
//
//  Created by Luis Ángel García Muñoz on 18/6/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Gameplay.h"

@implementation Gameplay {
    CCPhysicsNode *_physicsNode;
    CCNode *_catapultArm;
    CCNode *_levelNode;
    CCNode *_contentNode;
    
}

- (void)didLoadFromCCB {
    self.userInteractionEnabled = TRUE;
    CCScene *level = [CCBReader loadAsScene:@"Levels/Level1"];
    [_levelNode addChild:level];
    
    // Debug physics bodies&joints
    _physicsNode.debugDraw = TRUE;
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    [self launchPenguin];
}

- (void)launchPenguin {
    CCNode *penguin = [CCBReader load:@"Penguin"];
    penguin.position = ccpAdd(_catapultArm.position, ccp(16, 50));
    
    [_physicsNode addChild:penguin];
    
    CGPoint launchDirection = ccp(1, 0);
    CGPoint force = ccpMult(launchDirection, 8000);
    [penguin.physicsBody applyForce:force];
    
    // Asegurar que el objeto es visible
    self.position = ccp(0, 0);
    CCActionFollow *actionF = [CCActionFollow actionWithTarget:penguin worldBoundary:self.boundingBox];
    [_contentNode runAction:actionF];
    
}

- (void)retry {
    // reload this level
    [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"Gameplay"]];
}

@end
