//
// MIT License
//
// Copyright (c) 2018 DimaMishchenko
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import UIKit

class ArrowButton: ActionButton {
    
    private typealias TopBottomPaths = (top: CGPath, bottom: CGPath)
    
    // MARK: - Public properties
    
    var animationDuration: TimeInterval = 0.2
    var arrowInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    
    var arrowWidth: CGFloat = 1 {
        didSet {
            topLineLayer.lineWidth = arrowWidth
            bottomLineLayer.lineWidth = arrowWidth
        }
    }
    
    var arrowColor: UIColor = .black {
        didSet {
            topLineLayer.strokeColor = arrowColor.cgColor
            bottomLineLayer.strokeColor = arrowColor.cgColor
        }
    }
    
    var isArrowsHidden = false  {
        didSet {
            topLineLayer.isHidden = isArrowsHidden
            bottomLineLayer.isHidden = isArrowsHidden
        }
    }
    
    // MARK: - Private properties
    
    private lazy var topLineLayer: CAShapeLayer = layer()
    private lazy var bottomLineLayer: CAShapeLayer = layer()
    
    // MARK: - Public
  
    func showLeftArrow()    { animateArrow(with: leftArrowPaths()) }
    func showRightArrow()   { animateArrow(with: rightArrowPaths()) }
  
    // MARK: - Private
    
    private func animateArrow(with paths: TopBottomPaths) {

        let keyPath = "path"
        
        let topLineAnimation = aimation(
            keyPath: keyPath,
            duration: animationDuration,
            fromValue: topLineLayer.path,
            toValue: paths.top
        )
        
        let bottomLineAnimation = aimation(
            keyPath: keyPath,
            duration: animationDuration,
            fromValue: bottomLineLayer.path,
            toValue: paths.bottom
        )
        
        topLineLayer.path = paths.top
        topLineLayer.add(topLineAnimation, forKey: keyPath)
        
        bottomLineLayer.path = paths.bottom
        bottomLineLayer.add(bottomLineAnimation, forKey: keyPath)
    }
    
    private func aimation(keyPath: String, duration: TimeInterval, fromValue: Any?, toValue: Any?) -> CAAnimation {
        
        let animation = CABasicAnimation(keyPath: keyPath)
        animation.duration = duration
        animation.fromValue = fromValue
        animation.toValue = toValue
        
        return animation
    }
    
    private func leftArrowPaths() -> TopBottomPaths {
        
        let thirdSize = bounds.size.height / 2.5
        let sixthSize = bounds.size.width / 3
        
        let topPoint = CGPoint(
            x: center.x + sixthSize - arrowInsets.right,
            y: center.y - thirdSize + arrowInsets.top
        )
        let bottomPoint = CGPoint(
            x: center.x + sixthSize - arrowInsets.right,
            y: center.y + thirdSize - arrowInsets.bottom
        )
        let sidePoint = CGPoint(
            x: center.x - sixthSize + arrowInsets.left,
            y: center.y
        )
        
        return arrowPaths(withTop: topPoint, bottom: bottomPoint, side: sidePoint)
    }
    
    private func rightArrowPaths() -> TopBottomPaths {
        
        let thirdSize = bounds.size.height / 2.5
        let sixthSize = bounds.size.width / 3
        
        let topPoint = CGPoint(
            x: center.x - sixthSize + arrowInsets.left,
            y: center.y - thirdSize + arrowInsets.top
        )
        let bottomPoint = CGPoint(
            x: center.x - sixthSize + arrowInsets.left,
            y: center.y + thirdSize - arrowInsets.bottom
        )
        let sidePoint = CGPoint(
            x: center.x + sixthSize - arrowInsets.right,
            y: center.y
        )
        
        return arrowPaths(withTop: topPoint, bottom: bottomPoint, side: sidePoint)
    }
    
    private func arrowPaths(withTop top: CGPoint, bottom: CGPoint, side: CGPoint) -> TopBottomPaths {
        
        let gravityCenter = CGPoint(x: (top.x + bottom.x + side.x) / 3, y: (top.y + bottom.y + side.y) / 3)
        let offsetFromCenter = CGPoint(x: center.x - gravityCenter.x, y: center.y - gravityCenter.y)
        
        let topLinePath = line(from: top, to: side, offset: offsetFromCenter)
        let bottomLinePath = line(from: bottom, to: side, offset: offsetFromCenter)
        
        return (topLinePath, bottomLinePath)
    }
    
    private func line(from startPoint: CGPoint, to endPoint: CGPoint, offset: CGPoint) -> CGPath {
        
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: offset.x + startPoint.x, y: offset.y + startPoint.y))
        path.addLine(to: CGPoint(x: offset.x + endPoint.x, y: offset.y + endPoint.y))

        return path
    }
    
    private func layer() -> CAShapeLayer {
        
        let layer = CAShapeLayer()
        layer.strokeColor = arrowColor.cgColor
        layer.lineWidth = arrowWidth
        layer.lineJoin = kCALineJoinRound
        layer.lineCap = kCALineCapRound
        self.layer.addSublayer(layer)
        return layer
    }
}
