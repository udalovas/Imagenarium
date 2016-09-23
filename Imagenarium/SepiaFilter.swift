//
//  SepiaFilter.swift
//  Filterer
//
//  Created by Алексей Удалов on 20/09/16.
//  Copyright © 2016 udalovas. All rights reserved.
//

import Foundation

public class SepiaFilter : Filter {
    
    public static let INSTANCE:Filter = SepiaFilter()
    
    public func apply(inout rgbaImage: RGBAImage) -> RGBAImage{
        
        for y in 0 ..< rgbaImage.height {
            for x in 0 ..< rgbaImage.width {
                
                let index = y * rgbaImage.width + x
                var pixel = rgbaImage.pixels[index]
                
                let red = min(Int((Double(pixel.red) * 0.393) + (Double(pixel.green) * 0.769) + (Double(pixel.blue) * 0.189)), 255)
                let green = min(Int((Double(pixel.red) * 0.349) + (Double(pixel.green) * 0.686) + (Double(pixel.blue) * 0.168)), 255)
                let blue = min(Int((Double(pixel.red) * 0.272) + (Double(pixel.green) * 0.534) + (Double(pixel.blue) * 0.131)), 255)
                
                pixel.red = UInt8(red)
                pixel.green = UInt8(green)
                pixel.blue = UInt8(blue)
                
                rgbaImage.pixels[index] = pixel
            }
        }
        
        return rgbaImage
    }
    
}