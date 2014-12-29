//
//  ViewController.swift
//  MorphShape
//
//  Created by James Tang on 24/12/14.
//  Copyright (c) 2014 James Tang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var shapeLayer : CAShapeLayer?
    var expanded = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureShapeLayer()
    }

    func configureShapeLayer() {
        let layer = CAShapeLayer()
        layer.path = self.circlePath().CGPath
        self.view.layer.addSublayer(layer)
        self.shapeLayer = layer
    }

    @IBAction func morphButtonDidPress(sender: AnyObject) {

        if expanded {
            self.collapse()
        } else {
            self.expand()
        }

        self.expanded = !self.expanded
    }


    func collapse() {
        let layer = self.shapeLayer!
        let roundedRectBezierPath = self.rectPath()
        let ovalBezierPath = self.circlePath()

        let spring = CABasicAnimation(keyPath: "path")
        spring.duration = 0.4
        spring.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        spring.fromValue = roundedRectBezierPath.CGPath
        spring.toValue = ovalBezierPath.CGPath
        layer.path = ovalBezierPath.CGPath

        layer.addAnimation(spring, forKey: "animationPath")
    }

    func expand() {
        let layer = self.shapeLayer!
        let roundedRectBezierPath = self.rectPath()
        let ovalBezierPath = self.circlePath()

        let spring = CABasicAnimation(keyPath: "path")
        spring.duration = 0.4
        spring.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        spring.fromValue = ovalBezierPath.CGPath
        spring.toValue = roundedRectBezierPath.CGPath

        layer.path = roundedRectBezierPath.CGPath

        layer.addAnimation(spring, forKey: "animationPath")
    }

    func rectPath() -> UIBezierPath {
        return UIBezierPath(
            roundedRect: CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 240)
            , cornerRadius: 1)
    }

    func circlePath() -> UIBezierPath {
        let width : CGFloat = 100.0
        return UIBezierPath(roundedRect: CGRectMake(
            (self.view.frame.size.width - width)/2,
            (self.view.frame.size.height - width)/2,
            width,
            width), cornerRadius: width/2)
    }


}

