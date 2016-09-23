//
//  GreyScaleFilter.swift
//  Imagenarium
//
//  Created by Алексей Удалов on 23/09/16.
//  Copyright © 2016 udalovas. All rights reserved.
//

import Foundation

public class GrayScaleFilter: Filter {
    
    public static let INSTANCE:Filter = GrayScaleFilter()
    
    public func apply(inout rgbaImage: RGBAImage) -> RGBAImage {
        
        for y in 0 ..< rgbaImage.height {
            for x in 0 ..< rgbaImage.width {
                
                let index = y * rgbaImage.width + x
                var pixel = rgbaImage.pixels[index]
                
                let gray = (Int(pixel.red) + Int(pixel.green) + Int(pixel.blue)) / 3
                
                pixel.red = UInt8(gray)
                pixel.green = UInt8(gray)
                pixel.blue = UInt8(gray)
                
                rgbaImage.pixels[index] = pixel
            }
        }
        return rgbaImage
    }
}