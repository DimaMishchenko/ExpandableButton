//
//  ActionButton.swift
//  ExpandableButtonExample
//
//  Created by Dima Mishchenko on 20.07.2018.
//  Copyright © 2018 Dima. All rights reserved.
//

import UIKit

public class ActionButton: UIButton {
    
    public typealias ButtonActionBlock = () -> Void
    
    // MARK: - Public properties
    
    public var actionBlock: ButtonActionBlock?
    
    // MARK: - Init
    
    override public init(frame: CGRect) {
        
        super.init(frame: frame)
        addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)
    }
    
    required public init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Actions
    
    @objc private func buttonSelected() { actionBlock?() }
}
