//
//  PuzzleVerifyView+PatternProvider.swift
//  PuzzleVerifyDemo
//
//  Created by yunduan on 2022/2/26.
//

import Foundation
import UIKit

extension PuzzleVerifyView {
    static var squarePath: UIBezierPath {
        return UIBezierPath.init(rect: CGRect.init(x: 0, y: 0, width: 100, height: 100))
    }
    
    static var circlePath: UIBezierPath {
        return UIBezierPath.init(ovalIn: CGRect.init(x: 0, y: 0, width: 100, height: 100))
    }
    
    static var classicPath: UIBezierPath {
        let classicPath = UIBezierPath.init()
        classicPath.move(to: CGPoint.init(x: 17.45, y: 71.16))
        classicPath.addCurve(to: CGPoint.init(x: 25, y: 74.69), controlPoint1: CGPoint.init(x: 20.83, y: 67.76), controlPoint2: CGPoint.init(x: 25, y: 69.2))
        classicPath.addLine(to: CGPoint.init(x: 25, y: 100))
        classicPath.addLine(to: CGPoint.init(x: 50.31, y: 100))
        classicPath.addCurve(to: CGPoint.init(x: 53.84, y: 92.45), controlPoint1: CGPoint.init(x: 55.79, y: 100), controlPoint2: CGPoint.init(x: 57.24, y: 95.83))
        classicPath.addCurve(to: CGPoint.init(x: 50, y: 85.33), controlPoint1: CGPoint.init(x: 52.18, y: 90.78), controlPoint2: CGPoint.init(x: 50, y: 89.4))
        classicPath.addCurve(to: CGPoint.init(x: 62.5, y: 75), controlPoint1: CGPoint.init(x: 50, y: 80.8), controlPoint2: CGPoint.init(x: 54.62, y: 75))
        classicPath.addCurve(to: CGPoint.init(x: 75, y: 85.33), controlPoint1: CGPoint.init(x: 70.38, y: 75), controlPoint2: CGPoint.init(x: 75, y: 80.8))
        classicPath.addCurve(to: CGPoint.init(x: 71.16, y: 92.45), controlPoint1: CGPoint.init(x: 75, y: 89.4), controlPoint2: CGPoint.init(x: 72.82, y: 90.78))
        classicPath.addCurve(to: CGPoint.init(x: 74.69, y: 100), controlPoint1: CGPoint.init(x: 67.76, y: 95.83), controlPoint2: CGPoint.init(x: 69.2, y: 100))
        classicPath.addLine(to: CGPoint.init(x: 100, y: 100))
        classicPath.addLine(to: CGPoint.init(x: 100, y: 74.69))
        classicPath.addCurve(to: CGPoint.init(x: 92.45, y: 71.16), controlPoint1: CGPoint.init(x: 100, y: 69.21), controlPoint2: CGPoint.init(x: 95.83, y: 67.76))
        classicPath.addCurve(to: CGPoint.init(x: 85.33, y: 75), controlPoint1: CGPoint.init(x: 90.78, y: 72.82), controlPoint2: CGPoint.init(x: 89.4, y: 75))

        classicPath.addCurve(to: CGPoint.init(x: 75, y: 62.5), controlPoint1: CGPoint.init(x: 80.8, y: 75), controlPoint2: CGPoint.init(x: 75, y: 70.38))

        classicPath.addCurve(to: CGPoint.init(x: 85.33, y: 50), controlPoint1: CGPoint.init(x: 75, y: 54.62), controlPoint2: CGPoint.init(x: 80.8, y: 50))
        classicPath.addCurve(to: CGPoint.init(x: 92.45, y: 53.84), controlPoint1: CGPoint.init(x: 89.4, y: 50), controlPoint2: CGPoint.init(x: 90.78, y: 52.18))
        classicPath.addCurve(to: CGPoint.init(x: 100, y: 50.31), controlPoint1: CGPoint.init(x: 95.83, y: 57.24), controlPoint2: CGPoint.init(x: 100, y: 55.8))
        classicPath.addLine(to: CGPoint.init(x: 100, y: 25))
        classicPath.addLine(to: CGPoint.init(x: 74.69, y: 25))
        classicPath.addCurve(to: CGPoint.init(x: 71.16, y: 17.45), controlPoint1: CGPoint.init(x: 69.21, y: 25), controlPoint2: CGPoint.init(x: 67.76, y: 20.83))
        classicPath.addCurve(to: CGPoint.init(x: 75, y: 10.33), controlPoint1: CGPoint.init(x: 72.82, y: 15.78), controlPoint2: CGPoint.init(x: 75, y: 14.4))
        classicPath.addCurve(to: CGPoint.init(x: 62.5, y: 0), controlPoint1: CGPoint.init(x: 75, y: 5.8), controlPoint2: CGPoint.init(x: 70.38, y: 0))
        classicPath.addCurve(to: CGPoint.init(x: 50, y: 10.33), controlPoint1: CGPoint.init(x: 54.62, y: 0), controlPoint2: CGPoint.init(x: 50, y: 5.8))
        classicPath.addCurve(to: CGPoint.init(x: 53.84, y: 17.45), controlPoint1: CGPoint.init(x: 50, y: 14.4), controlPoint2: CGPoint.init(x: 52.18, y: 15.78))
        classicPath.addCurve(to: CGPoint.init(x: 50.31, y: 25), controlPoint1: CGPoint.init(x: 57.24, y: 20.83), controlPoint2: CGPoint.init(x: 55.8, y: 25))
        classicPath.addLine(to: CGPoint.init(x: 25, y: 25))
        classicPath.addLine(to: CGPoint.init(x: 25, y: 50.31))
        classicPath.addCurve(to: CGPoint.init(x: 17.45, y: 53.84), controlPoint1: CGPoint.init(x: 25, y: 55.79), controlPoint2: CGPoint.init(x: 20.83, y: 57.24))
        classicPath.addCurve(to: CGPoint.init(x: 10.33, y: 50), controlPoint1: CGPoint.init(x: 15.78, y: 52.18), controlPoint2: CGPoint.init(x: 14.4, y: 50))
        classicPath.addCurve(to: CGPoint.init(x: 0, y: 62.5), controlPoint1: CGPoint.init(x: 5.8, y: 50), controlPoint2: CGPoint.init(x: 0, y: 54.62))
        classicPath.addCurve(to: CGPoint.init(x: 10.33, y: 75), controlPoint1: CGPoint.init(x: 0, y: 70.38), controlPoint2: CGPoint.init(x: 5.8, y: 75))
        classicPath.addCurve(to: CGPoint.init(x: 17.45, y: 71.16), controlPoint1: CGPoint.init(x: 14.4, y: 75), controlPoint2: CGPoint.init(x: 15.78, y: 72.82))
        classicPath.move(to: CGPoint.init(x: 17.45, y: 71.16))

        classicPath.close()
        return classicPath
    }
}

extension DispatchQueue {
    private static var _onceTracker = [String]()
    static func once(token: String, block: (() -> ())?) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        if _onceTracker.contains(token) { return }
        _onceTracker.append(token)
        block?()
    }
}

