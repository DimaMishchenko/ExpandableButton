//
//  ExpandableButtonItem.swift
//  ExpandableButtonExample
//
//  Created by Dima Mishchenko on 20.07.2018.
//  Copyright © 2018 Dima. All rights reserved.
//

import UIKit

public class ExpandableButtonItem {
    
    public typealias ActionBlock = (ExpandableButtonItem) -> Void
    
    // MARK: - Properties
    
    // normal
    public var title: String = ""
    public var attributedTitle: NSAttributedString?
    public var image: UIImage?
    
    // highlighted
    public var highlightedTitle: String = ""
    public var highlightedAttributedTitle: NSAttributedString?
    public var highlightedImage: UIImage?
    
    // insets
    public var contentEdgeInsets: UIEdgeInsets = .zero
    public var titleEdgeInsets: UIEdgeInsets = .zero
    public var imageEdgeInsets: UIEdgeInsets = .zero
    
    // action
    public var action: ActionBlock = {_ in}
    
    // identifier
    public var identifier: String = ""
    
    // MARK: - Init
    
    public init(title: String = "",
                attributedTitle: NSAttributedString? = nil,
                image: UIImage? = nil,
                highlightedTitle: String = "",
                highlightedAttributedTitle: NSAttributedString? = nil,
                highlightedImage: UIImage? = nil,
                contentEdgeInsets: UIEdgeInsets = .zero,
                titleEdgeInsets: UIEdgeInsets = .zero,
                imageEdgeInsets: UIEdgeInsets = .zero,
                identifier: String = "",
                action: @escaping ActionBlock = {_ in}) {
        
        self.title = title
        self.attributedTitle = attributedTitle
        self.image = image
        self.highlightedTitle = highlightedTitle
        self.highlightedAttributedTitle = highlightedAttributedTitle
        self.highlightedImage = highlightedImage
        self.contentEdgeInsets = contentEdgeInsets
        self.titleEdgeInsets = titleEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
        self.identifier = identifier
        self.action = action
    }
}
