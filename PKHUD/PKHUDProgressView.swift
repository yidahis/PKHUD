//
//  PKHUDProgressVIew.swift
//  PKHUD
//
//  Created by Philip Kluz on 6/12/15.
//  Copyright (c) 2016 NSExceptional. All rights reserved.
//  Licensed under the MIT license.
//

import UIKit
import QuartzCore

/// PKHUDProgressView provides an indeterminate progress view.
open class PKHUDProgressView: PKHUDSquareBaseView, PKHUDAnimating {

    public init(title: String? = nil, subtitle: String? = nil) {
        super.init(image: PKHUDAssets.progressActivityImage, title: title, subtitle: subtitle)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func startAnimation() {
        imageView.image = imageView.image?.imageWithTinColor(PKHUD.sharedHUD.contentColor ?? UIColor.black)
        imageView.layer.add(PKHUDAnimation.discreteRotation, forKey: "progressAnimation")
    }

    public func stopAnimation() {
    }
}

extension UIImage{
    /// 改变图片tin
    ///
    /// - Parameters:
    ///   - color: tinColor
    ///   - blendMode: 是否保留色阶
    /// - Returns: 图片
    func imageWithTinColor(_ color: UIColor, blendMode: Bool = false) -> UIImage? {
        let bounds = CGRect(x:0, y:0, width:self.size.width, height:self.size.height)
        if blendMode {
            UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
            color.setFill()
            UIRectFill(bounds)
            self.draw(in: bounds, blendMode: CGBlendMode.overlay, alpha: 1.0)
            self.draw(in: bounds, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage
        }else {
            var newImage = self.withRenderingMode(.alwaysTemplate)
            UIGraphicsBeginImageContextWithOptions(self.size, false, newImage.scale)
            color.set()
            newImage.draw(in: bounds)
            if let img = UIGraphicsGetImageFromCurrentImageContext() {
                newImage = img
            }
            UIGraphicsEndImageContext()
            return newImage
        }
    }
}
