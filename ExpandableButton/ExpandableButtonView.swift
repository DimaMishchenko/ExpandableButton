//
//  ExpandableButtonView.swift
//  ExpandableButtonExample
//
//  Created by Dima Mishchenko on 20.07.2018.
//  Copyright © 2018 Dima. All rights reserved.
//

import UIKit

public class ExpandableButtonView: UIView {
    
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
    public var separatorTopOffset: CGFloat = 8      { didSet { reloadSeparatorFrame() } }
    public var separatorBottomOffset: CGFloat = 8   { didSet { reloadSeparatorFrame() } }
    public var separatorWidth: CGFloat = 1          { didSet { reloadSeparatorFrame() } }
    
    // MARK: - Private properties
    
    private var firstLayout = true
    
    // MARK: - Init
    
    public init(frame: CGRect = .zero, items: [ExpandableButtonItem]) {
        
        super.init(frame: frame)
        setupUI()
        setupButtons(with: items)
    }
    
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Overrides

    public override var frame: CGRect { didSet { setupFrames() } }
    
    override public func layoutSubviews() {
        
        super.layoutSubviews()
        
        if firstLayout {
            
            setupFrames()
            showRightArrow()
            
            firstLayout = false
        }
    }
    
    // MARK: - Public
    
    public func open() {
        
        guard state == .closed else { return }
    
        state = .animating
        showLeftArrow()
        
        UIView.animate(withDuration: animationDuration, animations: {
            super.frame = CGRect(
                x: self.frame.origin.x,
                y: self.frame.origin.y,
                width: self.frame.size.width + self.arrowButton.frame.size.width * CGFloat(self.itemsButtons.count),
                height: self.frame.size.height
            )
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
        showRightArrow()
        
        UIView.animate(withDuration: animationDuration, animations: {
            super.frame = CGRect(
                x: self.frame.origin.x,
                y: self.frame.origin.y,
                width: self.frame.size.width - self.arrowButton.frame.size.width * CGFloat(self.itemsButtons.count),
                height: self.frame.size.height
            )
        }) {
            if $0 {
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
        addSubview(arrowButton)
        
        // separator
        
        separatorView = UIView()
        separatorView.backgroundColor = separatorColor
        addSubview(separatorView)
    }
    
    private func setupButtons(with items: [ExpandableButtonItem]) {
        
        items.forEach { item in
            
            let button = ActionButton()
            addSubview(button)
            
            button.setTitle(item.title, for: .normal)
            button.setTitle(item.highlightedTitle, for: .highlighted)
            
            button.setImage(item.image, for: .normal)
            button.setImage(item.highlightedImage, for: .highlighted)
            
            button.setAttributedTitle(item.attributedTitle, for: .normal)
            button.setAttributedTitle(item.highlightedAttributedTitle, for: .highlighted)
            
            button.contentEdgeInsets = item.contentEdgeInsets
            button.titleEdgeInsets = item.titleEdgeInsets
            button.imageEdgeInsets = item.imageEdgeInsets
            
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
        
        var previousButton: UIButton?
        
        itemsButtons.forEach {
            
            let x = previousButton != nil ?
                    previousButton!.frame.origin.x + previousButton!.frame.width :
                    arrowButton.frame.origin.x + arrowButton.frame.width
            
            $0.frame = CGRect(
                x: x,
                y: 0,
                width: arrowButton.frame.width,
                height: arrowButton.frame.height
            )
            
            previousButton = $0
        }
        
        // self
        
        switch state {
        case .closed:
            showRightArrow()
        case .opened:
            super.frame = CGRect(
                x: frame.origin.x,
                y: frame.origin.y,
                width: frame.width + frame.width * CGFloat(itemsButtons.count),
                height: frame.height
            )
            showLeftArrow()
        default: break
        }
    }
    
    private func reloadSeparatorFrame() {
        
        separatorView.frame = CGRect(
            x: frame.width,
            y: separatorTopOffset,
            width: separatorWidth,
            height: frame.height - separatorTopOffset - separatorBottomOffset
        )
    }
    
    // MARK: - Arrows
    
    private func showLeftArrow() {
        
        arrowButton.setImage(openImage, for: .normal)
        arrowButton.isArrowsHidden = openImage != nil
        if openImage == nil { arrowButton.showLeftArrow() }
    }
    
    private func showRightArrow() {
        
        arrowButton.setImage(closeImage, for: .normal)
        arrowButton.isArrowsHidden = closeImage != nil
        if closeImage == nil { arrowButton.showRightArrow() }
    }
    
    // MARK: - Haptic Feedback
    
    private func impactHapticFeedback() {
        
        if #available(iOS 10.0, *), isHapticFeedback {
            
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        }
    }
   
}
