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
    let moveJoystick = TLAnalogJoystick(withDiameter: 150)
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
        let moveJoystickHiddenArea = TLAnalogJoystickHiddenArea(rect: CGRect(x: 0, y: 0, width: frame.midX, height: frame.height))
        moveJoystickHiddenArea.lineWidth = 0
        moveJoystickHiddenArea.joystick = moveJoystick
        addChild(moveJoystickHiddenArea)
        
        let rotateJoystickHiddenArea = TLAnalogJoystickHiddenArea(rect: CGRect(x: frame.midX, y: 0, width: frame.midX, height: frame.height))
        rotateJoystickHiddenArea.lineWidth = 0
        rotateJoystickHiddenArea.joystick = rotateJoystick
        addChild(rotateJoystickHiddenArea)
        
        moveJoystick.handleImage = UIImage(named: "joystick")
        moveJoystick.baseImage = UIImage(named: "dpad")
        rotateJoystick.handleImage = UIImage(named: "joystick")
        rotateJoystick.baseImage = UIImage(named: "dpad")

        moveJoystick.on(.move) { [unowned self] joystick in self.master.handleMove(joystick: joystick) }
        rotateJoystick.on(.move) { [unowned self] joystick in self.master.handleRotate(joystick: joystick) }
        
        view.isMultipleTouchEnabled = true
    }
}
