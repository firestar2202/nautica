//
//  GameViewController.swift
//  nautica
//
//  Created by Sarah Leavitt on 11/15/19.
//  Copyright © 2019 Innoviox. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    var ship: SCNNode!
    var camera: SCNNode!
    let scene = SCNScene()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
        // retrieve the ship node
        ship = scene.rootNode.childNode(withName: "ship", recursively: true)!
//        ship.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        
        let lookAtConstraint = SCNLookAtConstraint(target: ship)

        let distanceConstraint = SCNDistanceConstraint(target: ship)
        distanceConstraint.minimumDistance = 5 // set to whatever minimum distance between the camera and aircraft you'd like
        distanceConstraint.maximumDistance = 15 // set to whatever maximum distance between the camera and aircraft you'd like

        cameraNode.constraints = [lookAtConstraint, distanceConstraint]
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        scene.rootNode.addChildNode(ship)
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.black
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
        
        scnView.overlaySKScene = JoystickOverlay(size: scnView.frame.size, master: self)
        scnView.allowsCameraControl = false
        
        let box = SCNBox(width: 1, height: 1, length: 0.3, chamferRadius: 0.1)
        let mat = SCNMaterial()
        mat.emission.contents = UIColor.red
        box.materials = [mat]
        let boxNode = SCNNode(geometry: box)
        boxNode.position = SCNVector3(x: 5, y: 5, z: 5)
        scene.rootNode.addChildNode(boxNode)
    }
    
    @objc func handleTap(_ gestureRecognize: UIGestureRecognizer) {
//        // retrieve the SCNView
//        let scnView = self.view as! SCNView
//
//        // check what nodes are tapped
//        let p = gestureRecognize.location(in: scnView)
//        let hitResults = scnView.hitTest(p, options: [:])
//        // check that we clicked on at least one object
//        if hitResults.count > 0 {
//            // retrieved the first clicked object
//            let result = hitResults[0]
//
//            // get its material
//            let material = result.node.geometry!.firstMaterial!
//
//            // highlight it
//            SCNTransaction.begin()
//            SCNTransaction.animationDuration = 0.5
//
//            // on completion - unhighlight
//            SCNTransaction.completionBlock = {
//                SCNTransaction.begin()
//                SCNTransaction.animationDuration = 0.5
//
//                material.emission.contents = UIColor.black
//
//                SCNTransaction.commit()
//            }
//
//            material.emission.contents = UIColor.red
//
//            SCNTransaction.commit()
//        }
    }
    
    @objc func handleMove(joystick: TLAnalogJoystick) {
        print("received move", joystick.velocity)
        
        ship.runAction(SCNAction.moveBy(x: joystick.velocity.x / 50, y: joystick.velocity.y / 50, z: 0, duration: 1))
    }
    
    @objc func handleRotate(joystick: TLAnalogJoystick) {
        print("received rotate", joystick.angular)
        
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .landscape
        } else {
            return .all
        }
    }
}
