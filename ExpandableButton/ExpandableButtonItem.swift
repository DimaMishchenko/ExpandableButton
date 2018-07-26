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
