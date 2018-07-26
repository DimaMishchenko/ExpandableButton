//
//  ViewController.swift
//  ExpandableButtonExample
//
//  Created by Dima Mishchenko on 20.07.2018.
//  Copyright © 2018 Dima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var buttonView: ExpandableButtonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let insets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        let items = [
            ExpandableButtonItem(
                image: #imageLiteral(resourceName: "delete"),
                highlightedImage: #imageLiteral(resourceName: "delete").alpha(0.5),
                imageEdgeInsets: insets,
                identifier: "delete",
                action: {_ in}
            ),
            ExpandableButtonItem(
                image: #imageLiteral(resourceName: "edit"),
                highlightedImage: #imageLiteral(resourceName: "edit").alpha(0.5),
                imageEdgeInsets: insets,
                identifier: "edit",
                action: {_ in}
            ),
            ExpandableButtonItem(
                image: #imageLiteral(resourceName: "share"),
                highlightedImage: #imageLiteral(resourceName: "share").alpha(0.5),
                imageEdgeInsets: insets,
                identifier: "share",
                action: { _ in}
            ),
            ExpandableButtonItem(
                image: #imageLiteral(resourceName: "like"),
                highlightedImage: #imageLiteral(resourceName: "like").alpha(0.5),
                imageEdgeInsets: insets,
                identifier: "like",
                action: { _ in}
            )
        ]

        buttonView = ExpandableButtonView(items: items)
        buttonView.backgroundColor = .white
        buttonView.arrowWidth = 2
        buttonView.separatorWidth = 2
        buttonView.separatorTopOffset = 12
        buttonView.separatorBottomOffset = 12
        buttonView.layer.cornerRadius = 30
        view.addSubview(buttonView)
        setupFrame()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.setupFrame()
        }, completion: nil)
    }

    private func setupFrame() {
        buttonView.frame = CGRect(x: 24, y: UIScreen.main.bounds.size.height - 24 - 80, width: 60, height: 60)
    }
}

extension UIImage {
    
    func alpha(_ value: CGFloat) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

