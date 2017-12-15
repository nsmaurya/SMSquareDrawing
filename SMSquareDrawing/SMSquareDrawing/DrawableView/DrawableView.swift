//
//  DrawableView.swift
//  SMSquareDrawing
//
//  Created by SunilMaurya on 15/12/17.
//  Copyright © 2017 SunilMaurya. All rights reserved.
//

import UIKit

class DrawableView: UIView {

    //MARK:- Draw rect
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(1.0)
        context?.setStrokeColor(UIColor.black.cgColor)
        context?.addRect(rect)
        context?.strokePath()
    }
}
