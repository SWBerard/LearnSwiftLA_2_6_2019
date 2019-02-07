//
//  ViewController.swift
//  Dynamic Views
//
//  Created by Steven Berard on 2/6/19.
//  Copyright © 2019 Event Farm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var animator: UIDynamicAnimator!

    @IBOutlet weak var rockView: UIView!
    @IBOutlet weak var groundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animator = UIDynamicAnimator(referenceView: view)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

//        let gravityBehavior = UIGravityBehavior(items: [rockView])
////        gravityBehavior.gravityDirection = CGVector(dx: 1.0, dy: 1.0)
//        animator.addBehavior(gravityBehavior)

        // Mark: - extension: <#Extension Name#>
        UIGravityBehavior()

        let centerGravityField = UIFieldBehavior.radialGravityField(position: view.center)
        centerGravityField.strength = 1
        centerGravityField.addItem(rockView)
        animator.addBehavior(centerGravityField)

        let fieldBehavior = UIFieldBehavior.vortexField()
        fieldBehavior.position = view.center
        fieldBehavior.region = UIRegion(size: view.frame.size)
        fieldBehavior.strength = -0.1
        fieldBehavior.addItem(rockView)
        fieldBehavior.addItem(groundView)
        animator.addBehavior(fieldBehavior)

        let collisionBehavior = UICollisionBehavior(items: [rockView, groundView])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collisionBehavior)

        let attachmentBehavior = UIAttachmentBehavior(item: groundView, attachedToAnchor: groundView.center)
        animator.addBehavior(attachmentBehavior)

        let groundRotationBehavior = UIDynamicItemBehavior(items: [groundView])
        groundRotationBehavior.allowsRotation = false
        animator.addBehavior(groundRotationBehavior)

        let rockDynamicBehavior = UIDynamicItemBehavior(items: [rockView])
        rockDynamicBehavior.elasticity = 1.0
        rockDynamicBehavior.friction = 0
        rockDynamicBehavior.resistance = 0
        rockDynamicBehavior.angularResistance = 0
        animator.addBehavior(rockDynamicBehavior)
    }
}

