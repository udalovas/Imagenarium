//
//  BrightnessFilter.swift
//  Imagenarium
//
//  Created by Алексей Удалов on 23/09/16.
//  Copyright © 2016 udalovas. All rights reserved.
//

import Foundation

public class BrightnessFilter: Filter {
    
    private let level:Double
    
    public init(level:Double) {
        self.level = level
    }
    
    public func apply(inout rgbaImage: RGBAImage) -> RGBAImage {
        for y in 0 ..< rgbaImage.height {
            for x in 0 ..< rgbaImage.width {
                let index = y * rgbaImage.width + x
                var pixel = rgbaImage.pixels[index]
                
                pixel.alpha = UInt8(max(0, min(255, level * 255)))
                
                rgbaImage.pixels[index] = pixel
            }
        }
        return rgbaImage
    }
}