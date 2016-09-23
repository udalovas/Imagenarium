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
        
        rgbaImage.pixels = rgbaImage.pixels.map({ (pixel:Pixel) -> Pixel in
            return Pixel(
                red: pixel.red,
                green: pixel.green,
                blue: pixel.blue,
                alpha: UInt8(max(0, min(255, level * 255))))
        })
        
        return rgbaImage
    }
}