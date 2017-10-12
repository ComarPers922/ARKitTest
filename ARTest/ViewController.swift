//
//  ViewController.swift
//  ARTest
//
//  Created by ComarPers 922 on 2017/9/19.
//  Copyright © 2017年 ComarPers 922. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/Earth.scn")!
        //let ship = SCNScene(named: "art.scnassets/ship.scn")!
        
        if let earth = scene.rootNode.childNode(withName: "Earth", recursively: true)
        {
            let localRotation = SCNAction.customAction(duration: 1, action: { (node, delta) in
                        let W = Float(cos(0.01 / 2))
                        let Y = Float(sin(0.01 / 2))
                        let value = SCNQuaternion(x:0, y:Y, z:0, w:W)
                        node.localRotate(by: value)
                })
            earth.runAction(SCNAction.repeatForever(localRotation))
            
            if let ship = scene.rootNode.childNode(withName: "Ship", recursively: true)
            {
                ship.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: -0.1, z: 0, duration: 0.33)))
            }
        }
        
        // Set the scene to the view
        sceneView.scene = scene
        
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    

    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        return node
    }

    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
