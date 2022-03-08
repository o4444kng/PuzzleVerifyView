//
//  PuzzleVerifyView.swift
//  PuzzleVerifyDemo
//
//  Created by yunduan on 2022/2/25.
//

import Foundation
import UIKit

enum PuzzleVerifyPattern {
    case classic
    case square
    case circle
    case custom
}

protocol PuzzleVerifyViewDelegate: NSObjectProtocol {
    func didChange(verification: Bool, puzzleVerifyView: PuzzleVerifyView)
    func didChange(newPosition: CGPoint, xPercentage: CGFloat, yPercentage: CGFloat)
}

class PuzzleVerifyView: UIView {
    
    var puzzleDefaultSize = CGSize.init(width: 40, height: 40)
    var puzzleAnimationDuration = 0.6
    var verificationTolerance: CGFloat = 8
    
    var backImageView: UIImageView?
    var backInnerShadowLayer: CAShapeLayer?
    var frontImageView: UIImageView?
    
    var image: UIImage? {
        didSet {
            backImageView?.image = image
            frontImageView?.image = image
            puzzleImageView?.image = image
            updatePuzzleMask()
        }
    }
    var pattern: PuzzleVerifyPattern = .classic {
        didSet {
            updatePuzzleMask()
        }
    }

    var customPuzzlePatternPath: UIBezierPath? {
        didSet {
            updatePuzzleMask()
        }
    }
    
    /// puzzle rect size, not for MockPuzzleVerifyPattern.custom
    var puzzleSize: CGSize = CGSize.init(width: 40, height: 40) {
        didSet {
            updatePuzzleMask()
        }
    }
    
    var puzzleBlankPosition: CGPoint? {
        didSet {
            updatePuzzleMask()
        }
    }
    
    var puzzlePosition: CGPoint? {
        set {
            if !enable { return }
            var position = newValue ?? .zero
            position.x = max(self.puzzleMinX, position.x)
            position.x = min(self.puzzleMaxX, position.x)
            
            position.y = max(self.puzzleMinY, position.y)
            position.y = min(self.puzzleMaxY, position.y)
            
            puzzleImageContainerView?.layer.shadowOpacity = Float(puzzleShadowOpacity)
            puzzleContainerPosition = CGPoint.init(x: position.x - (puzzleBlankPosition?.x ?? 0), y: position.y - (puzzleBlankPosition?.y ?? 0))
        }
        get {
            return CGPoint.init(x: (puzzleContainerPosition?.x ?? 0) + (puzzleBlankPosition?.x ?? 0), y: (puzzleContainerPosition?.y ?? 0) + (puzzleBlankPosition?.y ?? 0))
        }
    }
    
    var puzzleXPercentage: CGFloat? {
        set {
            if !enable { return }
            var percentage = newValue ?? .zero
            percentage = max(0, percentage)
            percentage = min(1, percentage)
            var position = puzzlePosition ?? .zero
            position.x = percentage * (puzzleMaxX - puzzleMinX) + self.puzzleMinX
            puzzlePosition = position
            performCallback()
        }
        get {
            return (puzzlePosition?.x ?? 0 - puzzleMinX) / (puzzleMaxX - puzzleMinX)
        }
    }
    var puzzleYPercentage: CGFloat? {
        set {
            if !enable { return }
            var percentage = newValue ?? .zero
            percentage = max(0, percentage)
            percentage = min(1, percentage)
            var position = puzzlePosition ?? .zero
            position.y = percentage * (puzzleMaxY - puzzleMinY) + self.puzzleMinY
            puzzlePosition = position
            performCallback()
        }
        get {
            return (puzzlePosition?.y ?? 0 - puzzleMinY) / (puzzleMaxY - puzzleMinY)
        }
    }

    var isVerified: Bool  {
        return abs((self.puzzlePosition?.x ?? 0) - (puzzleBlankPosition?.x ?? 0)) <= verificationTolerance && abs((self.puzzlePosition?.y ?? 0) - (puzzleBlankPosition?.y ?? 0)) <= verificationTolerance
    }
    
    var enable: Bool = true
    
    var puzzleBlankAlpha: CGFloat = 0.5 {
        didSet {
            backImageView?.alpha = puzzleBlankAlpha
        }
    }
    var puzzleBlankInnerShadowColor: UIColor = .black {
        didSet {
            backInnerShadowLayer?.shadowColor  = puzzleBlankInnerShadowColor.cgColor
        }
    }
    var puzzleBlankInnerShadowRadius: CGFloat = 4 {
        didSet {
            backInnerShadowLayer?.shadowRadius = puzzleBlankInnerShadowRadius
        }
    }
    var puzzleBlankInnerShadowOpacity: CGFloat = 0.5 {
        didSet {
            backInnerShadowLayer?.shadowOpacity = Float(puzzleBlankInnerShadowOpacity)
        }
    }
    var puzzleBlankInnerShadowOffset: CGSize = .zero {
        didSet {
            backInnerShadowLayer?.shadowOffset = puzzleBlankInnerShadowOffset
        }
    }
    
    var puzzleShadowColor: UIColor = .black
    var puzzleShadowRadius: CGFloat = 4
    var puzzleShadowOpacity: CGFloat = 0.5
    var puzzleShadowOffset: CGSize = .zero
    
    weak var delegate: PuzzleVerifyViewDelegate?
    

    
    var puzzleImageView: UIImageView?
    var puzzleImageContainerView: UIView?
    var puzzleContainerPosition: CGPoint? {
        didSet {
            var frame = puzzleImageContainerView?.frame
            frame?.origin = puzzleContainerPosition ?? .zero
            puzzleImageContainerView?.frame = frame ?? .zero
        }
    }
    var lastVerification: Bool = false
    
    
    func completeVerification(with animiation: Bool) {
        if animiation {
            UIView.animate(withDuration: puzzleAnimationDuration) { [weak self] in
                self?.puzzlePosition = self?.puzzleBlankPosition
                self?.puzzleImageContainerView?.layer.shadowOpacity = 0
            }
        } else {
            puzzlePosition = puzzleBlankPosition
            puzzleImageContainerView?.layer.shadowOpacity = 0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview != nil {
            updatePuzzleMask()
        }
    }
    
    func commonInit() {
        if backImageView != nil { return }
        enable = true
        isUserInteractionEnabled = true
        clipsToBounds = true
        puzzlePosition = CGPoint.init(x: 20, y: 20)
        backImageView = UIImageView.init(frame: self.bounds)
        backImageView?.isUserInteractionEnabled = false
        backImageView?.contentMode = .scaleToFill
        backImageView?.backgroundColor = .clear
        backImageView?.alpha = puzzleBlankAlpha
        addSubview(backImageView!)
        
        frontImageView = UIImageView.init(frame: self.bounds)
        frontImageView?.isUserInteractionEnabled = false
        frontImageView?.contentMode = .scaleToFill
        frontImageView?.backgroundColor = .clear
        addSubview(frontImageView!)
        
        puzzleImageContainerView = UIView.init(frame: CGRect.init(x: puzzleContainerPosition?.x ?? 0, y: puzzleContainerPosition?.y ?? 0, width: self.bounds.size.width, height: self.bounds.size.height))
        puzzleImageContainerView?.backgroundColor = .clear
        puzzleImageContainerView?.isUserInteractionEnabled = false
        puzzleImageContainerView?.layer.shadowColor = puzzleShadowColor.cgColor
        puzzleImageContainerView?.layer.shadowRadius = puzzleShadowRadius
        puzzleImageContainerView?.layer.shadowOpacity = Float(puzzleShadowOpacity)
        puzzleImageContainerView?.layer.shadowOffset = puzzleShadowOffset
        addSubview(puzzleImageContainerView!)
        
        puzzleImageView = UIImageView.init(frame: puzzleImageContainerView?.bounds ?? .zero)
        puzzleImageView?.isUserInteractionEnabled = false
        puzzleImageView?.contentMode = .scaleToFill
        puzzleImageView?.backgroundColor = .clear
        puzzleImageContainerView!.addSubview(puzzleImageView!)

        backInnerShadowLayer = CAShapeLayer()
        backInnerShadowLayer?.frame = self.bounds
        backInnerShadowLayer?.fillRule = CAShapeLayerFillRule.evenOdd
        backInnerShadowLayer?.shadowColor = puzzleBlankInnerShadowColor.cgColor
        backInnerShadowLayer?.shadowRadius = puzzleShadowRadius
        backInnerShadowLayer?.shadowOffset = puzzleBlankInnerShadowOffset
    }
}

extension PuzzleVerifyView {
    
    var puzzleMinX: CGFloat {
        return 0
    }
    
    var puzzleMaxX: CGFloat {
        return self.bounds.size.width - puzzleSize.width
    }
    
    var puzzleMinY: CGFloat {
        return 0
    }
    
    var puzzleMaxY: CGFloat {
        return self.bounds.size.height - puzzleSize.height
    }
    
    func performCallback() {
        delegate?.didChange(newPosition: puzzlePosition ?? .zero, xPercentage: puzzleXPercentage ?? 0, yPercentage: puzzleYPercentage ?? 0)
        if lastVerification != isVerified {
            lastVerification = isVerified
            delegate?.didChange(verification: isVerified, puzzleVerifyView: self)
        }
    }
    
    func updatePuzzleMask() {
        if self.superview != nil { return }
        
        // paths
        let puzzlePath = getNewScaledPuzzlePath()
        let maskPath = UIBezierPath.init(rect: self.bounds)
        if puzzlePath != nil {
            maskPath.append(UIBezierPath.init(cgPath: puzzlePath!.cgPath))
        }
        maskPath.usesEvenOddFillRule = true
        
        // layers
        let backMaskLayer = CAShapeLayer()
        backMaskLayer.frame = self.bounds
        backMaskLayer.path = puzzlePath?.cgPath
        backMaskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        
        let frontMaskLayer = CAShapeLayer()
        frontMaskLayer.frame = self.bounds
        frontMaskLayer.path = maskPath.cgPath
        frontMaskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        frontMaskLayer.backgroundColor = UIColor.clear.cgColor
        
        let puzzleMaskLayer = CAShapeLayer()
        puzzleMaskLayer.frame = self.bounds
        puzzleMaskLayer.path = puzzlePath?.cgPath
        
        backImageView?.layer.mask = backMaskLayer
        frontImageView?.layer.mask = frontMaskLayer
        puzzleImageView?.layer.mask = puzzleMaskLayer
        if puzzlePath != nil {
            let shadowPath = UIBezierPath.init(rect: self.bounds.insetBy(dx: -20, dy: -20))
            shadowPath.append(puzzlePath!)
            backInnerShadowLayer?.frame = self.bounds
            backInnerShadowLayer?.path = shadowPath.cgPath
        }
        backImageView?.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        backImageView?.layer.addSublayer(backInnerShadowLayer!)
    }
    
    func getNewScaledPuzzlePath() -> UIBezierPath? {
        var path: UIBezierPath?
        if pattern == PuzzleVerifyPattern.custom {
            if customPuzzlePatternPath != nil {
                path = UIBezierPath.init(cgPath: customPuzzlePatternPath!.cgPath)
                puzzleSize = path!.bounds.size
            }
        } else {
            path = UIBezierPath.init(cgPath: verifyPath(forPattern: pattern).cgPath)
            if path?.bounds.width ?? 0 > 0 && path?.bounds.height ?? 0 > 0 && puzzleSize != CGSize.zero {
                path?.apply(CGAffineTransform.init(scaleX: puzzleSize.width / path!.bounds.width, y: puzzleSize.width / path!.bounds.width))
            }
        }
        let tx = (puzzleBlankPosition?.x ?? 0) - (path?.bounds.origin.x ?? 0)
        let ty = (puzzleBlankPosition?.y ?? 0) - (path?.bounds.origin.y ?? 0)
        let transform = CGAffineTransform.init(translationX: tx, y: ty)

        path?.apply(transform)
        return path
    }
    
    func verifyPath(forPattern aPattern: PuzzleVerifyPattern) -> UIBezierPath {
        switch aPattern {
        case .square:
            return PuzzleVerifyView.squarePath
        case .classic:
            return PuzzleVerifyView.classicPath
        case .circle:
            return PuzzleVerifyView.circlePath
        case .custom:
            return PuzzleVerifyView.classicPath
        }
    }
}

