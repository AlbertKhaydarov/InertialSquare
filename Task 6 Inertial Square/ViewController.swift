//
//  ViewController.swift
//  Task 6 Inertial Square
//
//  Created by Admin on 17.07.2023.
//

import UIKit

class ViewController: UIViewController{
    
    lazy var mySquare: UIView = {
        var myView = UIView()
        myView.backgroundColor =  .systemBlue
        myView.layer.cornerRadius = 10
        return myView
    }()
    
    var animator: UIDynamicAnimator!
    var animatorItem: UIDynamicItemBehavior!
    var collision: UICollisionBehavior!
    var recognizer: UITapGestureRecognizer!
    var snapBehavior: UISnapBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mySquare)
        setupMySquare(mySquare)
        recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(recognizer)
        animator = UIDynamicAnimator(referenceView: view)
        animatorItem = UIDynamicItemBehavior(items: [mySquare])
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        collision = UICollisionBehavior(items: [mySquare])
        let insets = UIEdgeInsets(top: view.safeAreaInsets.top,
                                  left: view.safeAreaInsets.left,
                                  bottom: view.safeAreaInsets.bottom,
                                  right: view.safeAreaInsets.right)
        collision.setTranslatesReferenceBoundsIntoBoundary(with: insets)
        
        animator.addBehavior(collision)
//        if (snapBehavior != nil) {
//            animator.removeBehavior(snapBehavior)
//        }
        if let snapBehavior = self.snapBehavior {
            animator.removeBehavior(snapBehavior)
        }
        snapBehavior = UISnapBehavior(item: mySquare, snapTo: recognizer.location(in: self.view))
        snapBehavior.damping = 0.8
        animatorItem.angularResistance = 2.0
        animatorItem.addAngularVelocity(1.0, for: mySquare)
        animatorItem.linearVelocity(for: mySquare)
        animatorItem.resistance = 10.0
        animator.addBehavior(animatorItem)
        animator.addBehavior(snapBehavior)
    }
    
    func setupMySquare(_ myView: UIView){
        myView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myView.heightAnchor.constraint(equalToConstant: 80),
            myView.widthAnchor.constraint(equalToConstant: 80),
            myView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            myView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
}

