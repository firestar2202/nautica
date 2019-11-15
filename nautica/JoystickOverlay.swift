//
//  JoystickOverlay.swift
//  nautica
//
//  Created by Sarah Leavitt on 11/15/19.
//  Copyright © 2019 Innoviox. All rights reserved.
//

import Foundation
import SpriteKit

class JoystickOverlay: SKScene {
    let moveJoystick = TLAnalogJoystick(withDiameter: 100)
    let rotateJoystick = TLAnalogJoystick(withDiameter: 100)
    
    var master: GameViewController!
    
    init(size: CGSize, master: GameViewController) {
        super.init(size: size)
        
        self.master = master
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        moveJoystick.on(.begin) { [unowned self] _ in
        }
        
        moveJoystick.on(.move) { [unowned self] joystick in
            self.master.handleMove(joystick: joystick)
        }
        
        moveJoystick.on(.end) { [unowned self] _ in
        }
        
        rotateJoystick.on(.move) { [unowned self] joystick in
            self.master.handleRotate(joystick: joystick)
        }
        
        rotateJoystick.on(.end) { [unowned self] _ in
        }
    }
}
