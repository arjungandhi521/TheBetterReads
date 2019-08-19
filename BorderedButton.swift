//
//  BorderedButton.swift
//  My Reads
//
//  Created by Digital Media on 1/19/18.
//  Copyright © 2018 Arjun Gandhi. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable

// This class is used for the rounded buttons throughout the app.
class BorderedButton : UIButton {
    
    @IBInspectable var borderWidth: CGFloat = 2.0
    @IBInspectable var radius: CGFloat = 9.0
    
    override func draw(_ rect: CGRect) {
        let pathRect = CGRect(x: rect.minX + borderWidth + 1, y: rect.minY + borderWidth + 1, width: rect.width - 2 * (borderWidth + 1), height: rect.height - 2 * (borderWidth + 1))
        // set the button's sides to be rounded
        let path = UIBezierPath(roundedRect: pathRect, cornerRadius: radius)
        path.lineWidth = borderWidth
        UIColor.black.set()
        path.stroke()
        UIColor.white.set() // background color for buttons are white
        path.fill()
        
    }
}
