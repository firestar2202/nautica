//
//  JoystickOverlay.swift
//  nautica
//
//  Created by Sarah Leavitt on 11/15/19.
//  Copyright © 2019 Innoviox. All rights reserved.
//

import Foundation
import SceneKit

class JoystickOverlay: SKScene {
    let moveJoystick = TLAnalogJoystick(withDiameter: 100)
    let rotateJoystick = TLAnalogJoystick(withDiameter: 100)
}
