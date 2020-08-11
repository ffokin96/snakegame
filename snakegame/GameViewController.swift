//
//  GameViewController.swift
//  snakegame
//
//  Created by Максим Тимохин on 09.08.2020.
//  Copyright © 2020 Максим Тимохин. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let v1 = self.view as? SKView
        if let skView = v1 {
            let scene = GameScene()
            scene.scaleMode = .resizeFill
                
            skView.presentScene(scene)
            
            skView.showsPhysics = true
            skView.ignoresSiblingOrder = true
            skView.showsFPS = true
            skView.showsNodeCount = true
        }
    }
//
//    override func viewWillAppear(_ animated: Bool) {
//
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//
//    }
//
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
