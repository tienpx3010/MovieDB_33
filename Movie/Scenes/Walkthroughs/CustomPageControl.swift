//
//  CustomPageControl.swift
//  Movie
//
//  Created by pham.xuan.tien on 1/3/19.
//  Copyright © 2019 Framgia. All rights reserved.
//  https://github.com/MQZHot/ZPageControl

import UIKit

public enum PageControlAlignment {
    case center
    case left
    case right
}

public class CustomPageControl: UIControl {
    public var numberOfPages: Int = 0 {
        didSet { setupItems() }
    }
    public var spacing: CGFloat = 8 {
        didSet { updateFrame() }
    }
    public var dotSize: CGSize = CGSize(width: 8, height: 8) {
        didSet { updateFrame() }
    }
    public var currentDotSize: CGSize? {
        didSet { updateFrame() }
    }
    public var dotRadius: CGFloat? {
        didSet { updateFrame() }
    }
    public var currentDotRadius: CGFloat? {
        didSet { updateFrame() }
    }
    public var currentPage: Int = 0 {
        didSet { changeColor(); updateFrame() }
    }
    public var currentPageIndicatorTintColor: UIColor = UIColor.white {
        didSet { changeColor() }
    }
    public var pageIndicatorTintColor: UIColor = UIColor.gray {
        didSet { changeColor() }
    }
    public var dotImage: UIImage? {
        didSet { changeColor() }
    }
    public var currentDotImage: UIImage? {
        didSet { changeColor() }
    }
    public var alignment: PageControlAlignment = .center {
        didSet { updateFrame() }
    }

    fileprivate var items = [UIImageView]()
    fileprivate func changeColor() {
        for (index, item) in items.enumerated() {
            if currentPage == index {
                item.backgroundColor = currentDotImage == nil ? currentPageIndicatorTintColor : UIColor.clear
                item.image = currentDotImage
                if currentDotImage != nil { item.layer.cornerRadius = 0 }
            } else {
                item.backgroundColor = dotImage == nil ? pageIndicatorTintColor : UIColor.clear
                item.image = dotImage
                if dotImage != nil { item.layer.cornerRadius = 0 }
            }
        }
    }

    fileprivate func updateFrame() {
        for (index, item) in items.enumerated() {
            let frame = getFrame(index: index)
            item.frame = frame
            var radius = dotRadius == nil ? frame.size.height/2 : dotRadius!
            if currentPage == index {
                if currentDotImage != nil { radius = 0 }
                item.layer.cornerRadius = currentDotRadius == nil ? radius : currentDotRadius!
            } else {
                if dotImage != nil { radius = 0 }
                item.layer.cornerRadius = radius
            }
            item.layer.masksToBounds = true
        }
    }

    fileprivate func getFrame(index: Int) -> CGRect {
        let itemW = dotSize.width + spacing
        var currentSize = currentDotSize
        if currentSize == nil {
            currentSize = dotSize
        }
        let currentItemW = (currentSize?.width)! + spacing
        let totalWidth = itemW*CGFloat(numberOfPages-1)+currentItemW+spacing
        var orignX: CGFloat = 0
        switch alignment {
        case .center:
            orignX = (frame.size.width-totalWidth)/2+spacing
        case .left:
            orignX = spacing
        case .right:
            orignX = frame.size.width-totalWidth+spacing
        }
        var x: CGFloat = 0
        if index <= currentPage {
            x = orignX + CGFloat(index)*itemW
        } else {
            x = orignX + CGFloat(index-1)*itemW + currentItemW
        }
        let width = index == currentPage ? (currentSize?.width)! : dotSize.width
        let height = index == currentPage ? (currentSize?.height)! : dotSize.height
        let y = (frame.size.height-height)/2
        return CGRect(x: x, y: y, width: width, height: height)
    }

    fileprivate func setupItems() {
        for item in items { item.removeFromSuperview() }
        items.removeAll()
        for i in 0..<numberOfPages {
            let frame = getFrame(index: i)
            let item = UIImageView(frame: frame)
            addSubview(item)
            items.append(item)
        }
        updateFrame()
        changeColor()
    }
}

