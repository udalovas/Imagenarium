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
        
        rgbaImage.pixels = rgbaImage.pixels.map({ (pixel:Pixel) -> Pixel in
            
            let gray = (Int(pixel.red) + Int(pixel.green) + Int(pixel.blue)) / 3
            
            return Pixel(
                red: UInt8(gray),
                green: UInt8(gray),
                blue: UInt8(gray),
                alpha: pixel.alpha)
        })
        
        return rgbaImage
    }
}