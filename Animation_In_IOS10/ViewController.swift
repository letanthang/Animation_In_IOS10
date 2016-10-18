//
//  ViewController.swift
//  Animation_In_IOS10
//
//  Created by Thang Le Tan on 10/18/16.
//  Copyright © 2016 Thang Le Tan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var animator: UIViewPropertyAnimator!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let play = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(playTapped))
        let reverse = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(reverseTapped))
        
        navigationItem.rightBarButtonItems = [play, reverse]
        
        
        let slider = UISlider()
       
        slider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slider)
        
        
        slider.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        slider.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        

        
        let redBox = UIView(frame: CGRect(x: -64, y: 0, width: 128, height: 128))
        redBox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(redBox)
        redBox.backgroundColor = UIColor.red
        redBox.center.y = view.center.y
        
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(boxTapped))
        redBox.addGestureRecognizer(gesture)
        
        
        animator = UIViewPropertyAnimator(duration: 20, curve: .easeOut, animations: {
            redBox.center.x = self.view.frame.width
            redBox.transform = CGAffineTransform(rotationAngle: CGFloat.pi)//.scaledBy(x: 0.001, y: 0.001)
        })
        
        //animator.isManualHitTestingEnabled = true
        
        /*
        UIView.animate(withDuration: 20, delay: 0, options: .allowUserInteraction, animations: { 
            redBox.center.x = self.view.frame.width
            }, completion: nil)
        */
        
        animator.addCompletion { (position) in
            if position == .end {
                self.view.backgroundColor = UIColor.green
            } else {
                self.view.backgroundColor = UIColor.red
            }
        }
        

    }
    
    func boxTapped() {
        print("Box Tapped!")
    }
    
    func sliderChanged(_ sender: UISlider)  {
        animator.fractionComplete = CGFloat(sender.value)
    }
    
    func playTapped() {
        if animator.state == .active {
            if animator.isRunning {
                //animator.pauseAnimation()
                animator.stopAnimation(false)
                animator.finishAnimation(at: .end)
                
            } else {
                animator.continueAnimation(withTimingParameters: nil, durationFactor: 1.0)
            }
        } else {
            animator.startAnimation()
        }
        
    }
    
    func reverseTapped() {
        animator.isReversed = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

