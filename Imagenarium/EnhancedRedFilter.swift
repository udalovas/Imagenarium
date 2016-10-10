//
//  EnhancedRedFilter.swift
//  Imagenarium
//
//  Created by Алексей Удалов on 23/09/16.
//  Copyright © 2016 udalovas. All rights reserved.
//

import Foundation

open class EnhancedRedFilter: Filter {
    
    open static let DEFAULT_LEVEL:Int = 5;
    
    fileprivate let level:Int
    
    public convenience init() {
        self.init(level: EnhancedRedFilter.DEFAULT_LEVEL)
    }
    
    public init(level: Int) {
        self.level = level;
    }
    
    open func apply(_ rgbaImage: RGBAImage) -> RGBAImage {
        let avgRed = ImageProcessor.getAvgColors(rgbaImage).R
        return RGBAImage(
            pixels: rgbaImage.pixels.map({ pixel -> Pixel in
                let redDiff = Int(pixel.red) - avgRed
                return Pixel(
                    red: redDiff > 0 ?
                        UInt8(max(0, min(255, avgRed + redDiff * level))) : pixel.red,
                    green: pixel.green,
                    blue: pixel.blue,
                    alpha: pixel.alpha)
            }),
            width: rgbaImage.width,
            height: rgbaImage.height)
    }
    
}
