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
    
    public func apply(inout rgbaImage: RGBAImage) -> RGBAImage {
        
        rgbaImage.pixels = rgbaImage.pixels.map({ (pixel:Pixel) -> Pixel in
            
            return Pixel(
                red: UInt8(min(Int(Double(pixel.red) * 0.393 + Double(pixel.green) * 0.769 + Double(pixel.blue) * 0.189), 255)),
                green: UInt8(min(Int((Double(pixel.red) * 0.349) + (Double(pixel.green) * 0.686) + (Double(pixel.blue) * 0.168)), 255)),
                blue: UInt8(min(Int((Double(pixel.red) * 0.272) + (Double(pixel.green) * 0.534) + (Double(pixel.blue) * 0.131)), 255)),
                alpha: pixel.alpha)
        })
        
        return rgbaImage
    }
    
}