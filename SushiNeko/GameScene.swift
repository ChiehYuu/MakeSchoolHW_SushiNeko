//
//  GameScene.swift
//  SushiNeko
//
//  Created by Jay on 2016/8/5.
//  Copyright (c) 2016年 Jay. All rights reserved.
//

import SpriteKit

/* Tracking enum for use with character and sushi side */
enum Side {
    case Left, Right, None
}

class GameScene: SKScene {
    
    /* Game objects */
    var sushiBasePiece: SushiPiece!
    var character: Character!
    /* Sushi tower array */
    var sushiTower: [SushiPiece] = []
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!"
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        self.addChild(myLabel)
        
        /* Connect game objects */
        sushiBasePiece = childNodeWithName("sushiBasePiece") as! SushiPiece
        
        /* Setup chopstick connections */
        sushiBasePiece.connectChopsticks()
        
        /* Connect game objects */
        character = childNodeWithName("character") as! Character
        
        /* Manually stack the start of the tower */
        addTowerPiece(.None)
        addTowerPiece(.Right)
        
        /* Randomize tower to just outside of the screen */
        addRandomPieces(10)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            /* Get touch position in scene */
            let location = touch.locationInNode(self)
            
            
            
            /* Was touch on left/right hand side of screen? */
            if location.x > size.width / 2 {
                character.side = .Right
            } else {
                character.side = .Left
            }
            
            
            /* Grab sushi piece on top of the base sushi piece, it will always be 'first' */
            let firstPiece = sushiTower.first as SushiPiece!
            
            /* Remove from sushi tower array */
            sushiTower.removeFirst()
            
            /* Animate the punched sushi piece */
            firstPiece.flip(character.side)
            
            
            /* Add a new sushi piece to the top of the sushi tower */
            addRandomPieces(1)
            
            /* Drop all the sushi pieces down one place */
            for node:SushiPiece in sushiTower {
                node.runAction(SKAction.moveBy(CGVector(dx: 0, dy: -55), duration: 0.10))
                
                /* Reduce zPosition to stop zPosition climbing over UI */
                node.zPosition -= 1
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func addTowerPiece(side: Side) {
        /* Add a new sushi piece to the sushi tower */
        
        /* Copy original sushi piece */
        let newPiece = sushiBasePiece.copy() as! SushiPiece
        newPiece.connectChopsticks()
        
        /* Access last piece properties */
        let lastPiece = sushiTower.last
        
        /* Add on top of last piece, default on first piece */
        let lastPosition = lastPiece?.position ?? sushiBasePiece.position
        newPiece.position = lastPosition + CGPoint(x: 0, y: 55)
        
        /* Increment Z to ensure it's on top of the last piece, default on first piece*/
        let lastZPosition = lastPiece?.zPosition ?? sushiBasePiece.zPosition
        newPiece.zPosition = lastZPosition + 1
        
        /* Set side */
        newPiece.side = side
        
        /* Add sushi to scene */
        addChild(newPiece)
        
        /* Add sushi piece to the sushi tower */
        sushiTower.append(newPiece)
    }
    
    func addRandomPieces(total: Int) {
        /* Add random sushi pieces to the sushi tower */
        
        for _ in 1...total {
            
            /* Need to access last piece properties */
            let lastPiece = sushiTower.last as SushiPiece!
            
            /* Need to ensure we don't create impossible sushi structures */
            if lastPiece.side != .None {
                addTowerPiece(.None)
            } else {
                
                /* Random Number Generator */
                let rand = CGFloat.random(min: 0, max: 1.0)
                
                if rand < 0.45 {
                    /* 45% Chance of a left piece */
                    addTowerPiece(.Left)
                } else if rand < 0.9 {
                    /* 45% Chance of a right piece */
                    addTowerPiece(.Right)
                } else {
                    /* 10% Chance of an empty piece */
                    addTowerPiece(.None)
                }
            }
        }
    }
    
}
