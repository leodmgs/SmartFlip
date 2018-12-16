//
//  ViewController.swift
//  SmartFlip
//
//  Created by Leonardo Domingues on 12/16/18.
//  Copyright © 2018 Leonardo Domingues. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let containerView = UIView()
    let currentTextLabel = UILabel()
    let maxCharRange = (start: 65, end: 90)
    let maxValueRange = (start: 0, end: 50)
    var currentValue = 0
    var currentChar = 65
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupGestureRecognizers()
    }
    
    // @ADD: Insert wild cards allowing the user flip correctly for any side
    // @ADD: Invert flip direction to turn the game a more difficult
    
    private func setupGestureRecognizers() {
        let swipeLeftToRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeftToRight.direction = .right
        let swipeRightToLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRightToLeft.direction = .left
        let swipeTopToBottom = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeTopToBottom.direction = .down
        let swipeBottomToUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeBottomToUp.direction = .up
        containerView.addGestureRecognizer(swipeLeftToRight)
        containerView.addGestureRecognizer(swipeRightToLeft)
        containerView.addGestureRecognizer(swipeTopToBottom)
        containerView.addGestureRecognizer(swipeBottomToUp)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) {
        if gesture.state == .ended {
            let text = getNextText(direction: gesture.direction)
            var options: UIView.AnimationOptions = []
            if gesture.direction == .left {
                options = UIView.AnimationOptions.transitionFlipFromRight
            }
            if gesture.direction == .right {
                options = UIView.AnimationOptions.transitionFlipFromLeft
            }
            if gesture.direction == .down {
                options = UIView.AnimationOptions.transitionFlipFromBottom
            }
            if gesture.direction == .up {
                options = UIView.AnimationOptions.transitionFlipFromTop
            }
            startTransition(containerView, [options], text)
        }
        
    }
    
    func getNextText(direction: UISwipeGestureRecognizer.Direction) -> String {
        if direction == .down {
            if currentValue < maxValueRange.end {
                currentValue += 1
            }
            return "\(currentValue)"
        }
        if direction == .up {
            if currentValue > maxValueRange.start {
                currentValue -= 1
            }
            return "\(currentValue)"
        }
        if direction == .left {
            if currentChar > maxCharRange.start {
                currentChar -= 1
            }
            return "\(Character(UnicodeScalar(currentChar)!))"
        }
        if direction == .right {
            if currentChar < maxCharRange.end {
                currentChar += 1
            }
            return "\(Character(UnicodeScalar(currentChar)!))"
        }
        return "\(currentChar)"
    }
    
    func startTransition(_ view: UIView, _ options: UIView.AnimationOptions, _ textLabel: String) {
        UIView.transition(with: view, duration: 0.3, options: options, animations: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                self.currentTextLabel.text = textLabel
            }
        })
    }
    
    private func setupViews() {
        containerView.backgroundColor = UIColor.yellow
        containerView.layer.cornerRadius = 15
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(containerView)
        
        let containerPosX = CGFloat(UIScreen.main.bounds.width / 2) - 125
        let containerPosY = CGFloat(UIScreen.main.bounds.height / 2) - 125
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: containerPosX).isActive = true
        containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: containerPosY).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        currentTextLabel.text = "\(currentValue)"
        currentTextLabel.font = UIFont.boldSystemFont(ofSize: 72)
        currentTextLabel.textAlignment = .center
        currentTextLabel.textColor = UIColor.black
        currentTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(currentTextLabel)
        
        let valuePosX = CGFloat(250 /*containerView width*/ / 2) - 45 // valueLabel has 80
        let valuePosY = CGFloat(250 /*containerView heigh*/  / 2) - 40 // valueLabel has 80
        currentTextLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: valuePosX).isActive = true
        currentTextLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: valuePosY).isActive = true
        currentTextLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true
        currentTextLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
    }

}

