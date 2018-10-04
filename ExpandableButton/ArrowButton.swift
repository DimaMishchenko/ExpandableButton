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

public class ArrowButton: ActionButton {
    
    private typealias TopBottomPaths = (top: CGPath, bottom: CGPath)
    
    // MARK: - Public properties
    
    public var animationDuration: TimeInterval = 0.2
    public var arrowInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    
    public var arrowWidth: CGFloat = 1 {
        didSet {
            topLineLayer.lineWidth = arrowWidth
            bottomLineLayer.lineWidth = arrowWidth
        }
    }
    
    public var arrowColor: UIColor = .black {
        didSet {
            topLineLayer.strokeColor = arrowColor.cgColor
            bottomLineLayer.strokeColor = arrowColor.cgColor
        }
    }
    
    public var isArrowsHidden = false  {
        didSet {
            topLineLayer.isHidden = isArrowsHidden
            bottomLineLayer.isHidden = isArrowsHidden
        }
    }
    
    // MARK: - Private properties
    
    private lazy var topLineLayer: CAShapeLayer = layer()
    private lazy var bottomLineLayer: CAShapeLayer = layer()
    
    // MARK: - Public
  
    public func showUpArrow()       { animateArrow(with: upArrowPaths()) }
    public func showDownArrow()     { animateArrow(with: downArrowPaths()) }
    public func showLeftArrow()     { animateArrow(with: leftArrowPaths()) }
    public func showRightArrow()    { animateArrow(with: rightArrowPaths()) }
  
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
    
    private func upArrowPaths() -> TopBottomPaths {

        let verticalInset = bounds.size.height / 3
        let horizontalInset = bounds.size.width / 2.5

        let firstPoint = CGPoint(
            x: center.x - horizontalInset + arrowInsets.left,
            y: center.y + verticalInset - arrowInsets.bottom
        )
        let secondPoint = CGPoint(
            x: center.x + horizontalInset - arrowInsets.right,
            y: center.y + verticalInset - arrowInsets.bottom
        )
        let centerPoint = CGPoint(
            x: center.x,
            y: center.y - verticalInset + arrowInsets.top
        )

        return arrowPaths(firstPoint: firstPoint, secondPoint: secondPoint, centerPoint: centerPoint)
    }
    
    private func downArrowPaths() -> TopBottomPaths {
        
        let verticalInset = bounds.size.height / 3
        let horizontalInset = bounds.size.width / 2.5
        
        let firstPoint = CGPoint(
            x: center.x - horizontalInset + arrowInsets.left,
            y: center.y - verticalInset + arrowInsets.top
        )
        let secondPoint = CGPoint(
            x: center.x + horizontalInset - arrowInsets.right,
            y: center.y - verticalInset + arrowInsets.top
        )
        let centerPoint = CGPoint(
            x: center.x,
            y: center.y + verticalInset - arrowInsets.bottom
        )
        
        return arrowPaths(firstPoint: firstPoint, secondPoint: secondPoint, centerPoint: centerPoint)
    }
    
    private func leftArrowPaths() -> TopBottomPaths {
        
        let verticalInset = bounds.size.height / 2.5
        let horizontalInset = bounds.size.width / 3
        
        let firstPoint = CGPoint(
            x: center.x + horizontalInset - arrowInsets.right,
            y: center.y - verticalInset + arrowInsets.top
        )
        let secondPoint = CGPoint(
            x: center.x + horizontalInset - arrowInsets.right,
            y: center.y + verticalInset - arrowInsets.bottom
        )
        let centerPoint = CGPoint(
            x: center.x - horizontalInset + arrowInsets.left,
            y: center.y
        )
        
        return arrowPaths(firstPoint: firstPoint, secondPoint: secondPoint, centerPoint: centerPoint)
    }
    
    private func rightArrowPaths() -> TopBottomPaths {
        
        let verticalInset = bounds.size.height / 2.5
        let horizontalInset = bounds.size.width / 3
        
        let firstPoint = CGPoint(
            x: center.x - horizontalInset + arrowInsets.left,
            y: center.y - verticalInset + arrowInsets.top
        )
        let secondPoint = CGPoint(
            x: center.x - horizontalInset + arrowInsets.left,
            y: center.y + verticalInset - arrowInsets.bottom
        )
        let centerPoint = CGPoint(
            x: center.x + horizontalInset - arrowInsets.right,
            y: center.y
        )
        
        return arrowPaths(firstPoint: firstPoint, secondPoint: secondPoint, centerPoint: centerPoint)
    }
    
    private func arrowPaths(firstPoint top: CGPoint, secondPoint: CGPoint, centerPoint: CGPoint) -> TopBottomPaths {
        
        let gravityCenter = CGPoint(x: (top.x + secondPoint.x + centerPoint.x) / 3,
                                    y: (top.y + secondPoint.y + centerPoint.y) / 3)
        let offsetFromCenter = CGPoint(x: center.x - gravityCenter.x, y: center.y - gravityCenter.y)
        
        let topLinePath = line(from: top, to: centerPoint, offset: offsetFromCenter)
        let bottomLinePath = line(from: secondPoint, to: centerPoint, offset: offsetFromCenter)
        
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
        layer.lineJoin = CAShapeLayerLineJoin.round
        layer.lineCap = CAShapeLayerLineCap.round
        self.layer.addSublayer(layer)
        return layer
    }
}
