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

public class ExpandableButtonView: UIView {
    
    public enum Direction {
        case up
        case down
        case left
        case right
    }
    
    public enum State {
        case opened
        case closed
        case animating
    }
    
    // MARK: - UI properties
    
    private var arrowButton: ArrowButton!
    private var separatorView: UIView!
    private var itemsButtons: [ActionButton] = []
    
    // MARK: - Public properties
    
    public private(set) var direction: Direction
    
    public private(set) var state: State = .closed
    
    public var animationDuration: TimeInterval = 0.2 {
        didSet { arrowButton.animationDuration = animationDuration }
    }
    
    public var closeOnAction: Bool = false
    public var isHapticFeedback = true
    
    // arrow
    
    public var arrowInsets: UIEdgeInsets {
        get { return arrowButton.arrowInsets }
        set { arrowButton.arrowInsets = newValue }
    }
    
    public var arrowWidth: CGFloat {
        get { return arrowButton.arrowWidth }
        set { arrowButton.arrowWidth = newValue }
    }
    
    public var arrowColor: UIColor {
        get { return arrowButton.arrowColor }
        set { arrowButton.arrowColor = newValue }
    }
    
    public var closeOpenImagesInsets: UIEdgeInsets {
        get { return arrowButton.imageEdgeInsets }
        set { arrowButton.imageEdgeInsets = newValue }
    }
    public var closeImage: UIImage?
    public var openImage: UIImage?
    
    // separator
    
    public var isSeparatorHidden: Bool = false      { didSet { separatorView.isHidden = isSeparatorHidden } }
    public var separatorColor: UIColor = .black     { didSet { separatorView.backgroundColor = separatorColor } }
    public var separatorInset: CGFloat = 8          { didSet { reloadSeparatorFrame() } }
    public var separatorWidth: CGFloat = 1          { didSet { reloadSeparatorFrame() } }
    
    // MARK: - Private properties
    
    private var firstLayout = true
    
    // MARK: - Init
    
    public init(frame: CGRect = .zero, direction: Direction = .right, items: [ExpandableButtonItem]) {
        
        self.direction = direction
        super.init(frame: frame)
        setupUI()
        setupButtons(with: items)
    }
    
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Overrides

    public override var frame: CGRect { didSet { setupFrames() } }
    public override var backgroundColor: UIColor? { didSet { arrowButton.backgroundColor = backgroundColor } }
    
    override public func layoutSubviews() {
        
        super.layoutSubviews()
        
        if firstLayout {
            
            setupFrames()
            showCloseArrow()
            
            firstLayout = false
        }
    }
    
    // MARK: - Public
    
    public func open() {
        
        guard state == .closed else { return }
    
        state = .animating
        showOpenArrow()
        
        itemsButtons.forEach { $0.isHidden = false }
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.itemsButtons.forEach { $0.alpha = 0; $0.alpha = 1 }
            self.open(with: self.direction)
        }) {
            if $0 {
                self.state = .opened
                self.impactHapticFeedback()
            }
        }
    }
    
    public func close() {

        guard state == .opened else { return }
        
        state = .animating
        
        // because of CABasicAnimation in ArrowButton.
        if direction == .up || direction == .left { self.close(with: self.direction) }
        
        showCloseArrow()
        
        // because of CABasicAnimation in ArrowButton.
        if direction == .up || direction == .left { self.open(with: self.direction) }
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.itemsButtons.forEach { $0.alpha = 1; $0.alpha = 0 }
            self.close(with: self.direction)
        }) {
            if $0 {
                self.itemsButtons.forEach { $0.isHidden = true }
                self.state = .closed
                self.impactHapticFeedback()
            }
        }
        
    }
    
    // MARK: - Private
    
    private func setupUI() {
        
        clipsToBounds = true
        
        // arrow button
        
        arrowButton = ArrowButton()
        arrowButton.actionBlock = { [weak self] in
        
            guard let state = self?.state else { return }
            
            switch state {
            case .opened: self?.close()
            case .closed: self?.open()
            case .animating: break
            }
        }
        arrowButton.backgroundColor = backgroundColor
        addSubview(arrowButton)
        
        // separator
        
        separatorView = UIView()
        separatorView.backgroundColor = separatorColor
        insertSubview(separatorView, belowSubview: arrowButton)
    }
    
    private func setupButtons(with items: [ExpandableButtonItem]) {
        
        items.forEach { item in
            
            let button = ActionButton()
            insertSubview(button, belowSubview: arrowButton)
            
            button.setImage(item.image, for: .normal)
            button.setImage(item.highlightedImage, for: .highlighted)
            
            button.setAttributedTitle(item.attributedTitle, for: .normal)
            button.setAttributedTitle(item.highlightedAttributedTitle, for: .highlighted)
            
            button.contentEdgeInsets = item.contentEdgeInsets
            button.titleEdgeInsets = item.titleEdgeInsets
            button.imageEdgeInsets = item.imageEdgeInsets
            
            button.titleLabel?.textAlignment = item.titleAlignment
            button.imageView?.contentMode = item.imageContentMode
            
            if let size = item.size { button.frame = CGRect(origin: .zero, size: size) }
            
            button.actionBlock = { [weak self] in
                item.action(item)
                if let closeOnAction = self?.closeOnAction, closeOnAction { self?.close() }
            }
            
            itemsButtons.append(button)
        }
    }
    
    // MARK: - Layout
    
    private func setupFrames() {
        
        guard arrowButton != nil, separatorView != nil else { return }
        
        // arrow button
        
        arrowButton.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        // separator
        
        reloadSeparatorFrame()
        
        // items buttons
        
        setupItemButtonsFrames()
        itemsButtons.forEach { $0.isHidden = true }
        
        // self
        
        switch state {
        case .closed:
            showCloseArrow()
        case .opened:
            open(with: direction)
            showOpenArrow()
        default: break
        }
    }
    
    private func reloadSeparatorFrame() {
        
        switch direction {
        case .up:
            let y = itemsButtons.reduce(0, { $0 + $1.frame.height })
            let width = frame.width - separatorInset * 2
            separatorView.frame = CGRect(x: separatorInset, y: y, width: width, height: separatorWidth)
        case .down:
            let width = frame.width - separatorInset * 2
            separatorView.frame = CGRect(x: separatorInset, y: frame.height, width: width, height: separatorWidth)
        case .left:
            let x = itemsButtons.reduce(0, { $0 + $1.frame.width })
            let height = frame.height - separatorInset * 2
            separatorView.frame = CGRect(x: x, y: separatorInset, width: separatorWidth, height: height)
        case .right:
            let height = frame.height - separatorInset * 2
            separatorView.frame = CGRect(x: frame.width, y: separatorInset, width: separatorWidth, height: height)
        }
    }
    
    private func setupItemButtonsFrames() {
        
        var previousButton: UIButton?
        
        itemsButtons.forEach {
            
            let width = $0.frame.width == 0 ? arrowButton.frame.width : $0.frame.width
            let height = $0.frame.height == 0 ? arrowButton.frame.height : $0.frame.height
            
            var x: CGFloat = 0
            var y: CGFloat = 0
            
            switch direction {
            case .up:
                y = previousButton != nil ?
                    previousButton!.frame.origin.y + previousButton!.frame.height :
                    arrowButton.frame.origin.y
            case .down:
                y = previousButton != nil ?
                    previousButton!.frame.origin.y + previousButton!.frame.height :
                    arrowButton.frame.origin.y + arrowButton.frame.height
            case .left:
                x = previousButton != nil ?
                    previousButton!.frame.origin.x + previousButton!.frame.width :
                    arrowButton.frame.origin.x
            case .right:
                x = previousButton != nil ?
                    previousButton!.frame.origin.x + previousButton!.frame.width :
                    arrowButton.frame.origin.x + arrowButton.frame.width
            }
            $0.frame = CGRect(x: x, y: y, width: width, height: height)
            
            previousButton = $0
        }
    }
    
    // MARK: - Arrows
    
    private func showOpenArrow() {
        
        arrowButton.setImage(openImage, for: .normal)
        arrowButton.isArrowsHidden = openImage != nil
        
        if openImage == nil {
            
            if closeImage == nil {
                
                switch direction {
                case .up:       arrowButton.showDownArrow()
                case .down:     arrowButton.showUpArrow()
                case .left:     arrowButton.showRightArrow()
                case .right:    arrowButton.showLeftArrow()
                }
            }
        }
    }
    
    private func showCloseArrow() {
        
        arrowButton.setImage(closeImage, for: .normal)
        arrowButton.isArrowsHidden = closeImage != nil
        
        if closeImage == nil {
            
            switch direction {
            case .up:       arrowButton.showUpArrow()
            case .down:     arrowButton.showDownArrow()
            case .left:     arrowButton.showLeftArrow()
            case .right:    arrowButton.showRightArrow()
            }
        }
    }
    
    // MARK: - Haptic Feedback
    
    private func impactHapticFeedback() {
        
        if #available(iOS 10.0, *), isHapticFeedback {
            
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        }
    }
    
    // MARK: - Open close
    
    private func open(with direction: Direction) {
        
        switch direction {
        case .up:
            let itemsHeight = itemsButtons.reduce(0, { $0 + $1.frame.height })
            let y = frame.origin.y - itemsHeight
            let height = frame.size.height + itemsHeight
            
            super.frame = CGRect(x: frame.origin.x, y: y, width: frame.size.width, height: height)
            
            let arrY = super.frame.height - arrowButton.frame.height
            arrowButton.frame = CGRect(x: 0, y: arrY, width: arrowButton.frame.width, height: arrowButton.frame.height)
        case .down:
            let height = frame.size.height + itemsButtons.reduce(0, { $0 + $1.frame.height })
            super.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: height)
        case .left:
            let itemsWidth = itemsButtons.reduce(0, { $0 + $1.frame.width })
            let x = frame.origin.x - itemsWidth
            let width = frame.size.width + itemsWidth
            super.frame = CGRect(x: x, y: frame.origin.y, width: width, height: frame.size.height)
            
            let arrX = super.frame.width - arrowButton.frame.width
            arrowButton.frame = CGRect(x: arrX, y: 0, width: arrowButton.frame.width, height: arrowButton.frame.height)
        case .right:
            let width = frame.size.width + itemsButtons.reduce(0, { $0 + $1.frame.width })
            super.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: width, height: frame.size.height)
        }
    }
    
    private func close(with direction: Direction) {
        
        switch direction {
        case .up:
            let itemsHeight = itemsButtons.reduce(0, { $0 + $1.frame.height })
            let y = frame.origin.y + itemsHeight
            let height = frame.size.height - itemsHeight
            super.frame = CGRect(x: frame.origin.x, y: y, width: frame.size.width, height: height)
            
            arrowButton.frame = CGRect(x: 0, y: 0, width: arrowButton.frame.width, height: arrowButton.frame.height)
        case .down:
            let height = frame.size.height - itemsButtons.reduce(0, { $0 + $1.frame.height })
            super.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: height)
        case .left:
            let itemsWidth = itemsButtons.reduce(0, { $0 + $1.frame.width })
            let x = frame.origin.x + itemsWidth
            let width = frame.size.width - itemsWidth
            super.frame = CGRect(x: x, y: frame.origin.y, width: width, height: frame.size.height)
            
            arrowButton.frame = CGRect(x: 0, y: 0, width: arrowButton.frame.width, height: arrowButton.frame.height)
        case .right:
            let width = frame.size.width - itemsButtons.reduce(0, { $0 + $1.frame.width })
            super.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: width, height: frame.size.height)
        }
    }
}
