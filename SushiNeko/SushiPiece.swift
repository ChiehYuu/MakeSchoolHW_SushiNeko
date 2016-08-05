//
//  SushiPiece.swift
//  SushiNeko
//
//  Created by Jay on 2016/8/5.
//  Copyright © 2016年 Jay. All rights reserved.
//

import SpriteKit

class SushiPiece: SKSpriteNode {
    
    /* Chopsticks objects */
    var rightChopstick: SKSpriteNode!
    var leftChopstick: SKSpriteNode!
    
    /* You are required to implement this for your subclass to work */
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func connectChopsticks() {
        /* Connect the child chopstick nodes */
        
        rightChopstick = childNodeWithName("rightChopstick") as! SKSpriteNode
        leftChopstick = childNodeWithName("leftChopstick") as! SKSpriteNode
        
        /* Set the default side */
        side = .None
    }
    
    /* Sushi type */
    var side: Side = .None {
        
        didSet {
            switch side {
            case .Left:
                /* Show left chopstick */
                leftChopstick.hidden = false
            case .Right:
                /* Show right chopstick */
                rightChopstick.hidden = false
            case .None:
                /* Hide all chopsticks */
                leftChopstick.hidden = true
                rightChopstick.hidden = true
            }
            
        }
    }
    
}