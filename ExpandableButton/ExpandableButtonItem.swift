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
    
    // image
    public var image: UIImage?
    public var highlightedImage: UIImage?
    
    // title
    public var attributedTitle: NSAttributedString?
    public var highlightedAttributedTitle: NSAttributedString?
    
    // insets
    public var contentEdgeInsets: UIEdgeInsets = .zero
    public var titleEdgeInsets: UIEdgeInsets = .zero
    public var imageEdgeInsets: UIEdgeInsets = .zero
    
    // width
    public var size: CGSize?
    
    // alignment
    public var titleAlignment: NSTextAlignment = .center
    
    // content mode
    public var imageContentMode: UIView.ContentMode = .scaleAspectFit
    
    // action
    public var action: ActionBlock = {_ in}
    
    // identifier
    public var identifier: String = ""
    
    // MARK: - Init
    
    public init(image: UIImage? = nil,
                highlightedImage: UIImage? = nil,
                attributedTitle: NSAttributedString? = nil,
                highlightedAttributedTitle: NSAttributedString? = nil,
                contentEdgeInsets: UIEdgeInsets = .zero,
                titleEdgeInsets: UIEdgeInsets = .zero,
                imageEdgeInsets: UIEdgeInsets = .zero,
                size: CGSize? = nil,
                titleAlignment: NSTextAlignment = .center,
                imageContentMode: UIView.ContentMode = .scaleAspectFit,
                identifier: String = "",
                action: @escaping ActionBlock = {_ in}) {
        
        self.image = image
        self.highlightedImage = highlightedImage
        self.attributedTitle = attributedTitle
        self.highlightedAttributedTitle = highlightedAttributedTitle
        self.contentEdgeInsets = contentEdgeInsets
        self.titleEdgeInsets = titleEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
        self.size = size
        self.titleAlignment = titleAlignment
        self.imageContentMode = imageContentMode
        self.identifier = identifier
        self.action = action
    }
}
