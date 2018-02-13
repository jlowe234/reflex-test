//
//  UIImage+Circle.swift
//  ReflexTest
//
//  Created by Jonathan Lowe on 2/12/18.
//  Copyright © 2018 Jonathan Lowe. All rights reserved.
//

import UIKit

// Create a circle of a designated color and diameter.
extension UIImage {
    func circle(diameter: CGFloat, color: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: diameter, height: diameter))
        return renderer.image { (context) in
            context.cgContext.setFillColor(color.cgColor)
            context.cgContext.setStrokeColor(color.cgColor)
            
            context.cgContext.addEllipse(in: CGRect(x: 0, y: 0, width: diameter, height: diameter))
            context.cgContext.drawPath(using: .fillStroke)
        }
    }
}
