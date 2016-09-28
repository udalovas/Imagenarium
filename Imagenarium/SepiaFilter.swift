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
    
    public func apply(rgbaImage: RGBAImage) -> RGBAImage {
        return RGBAImage(
            pixels: rgbaImage.pixels.map({ pixel -> Pixel in
                
                let red = min(Double(pixel.red) * 0.393 + Double(pixel.green) * 0.769 + Double(pixel.blue) * 0.189, 255)
                let green = min(Double(pixel.red) * 0.349 + Double(pixel.green) * 0.686 + Double(pixel.blue) * 0.168, 255)
                let blue = min(Double(pixel.red) * 0.272 + Double(pixel.green) * 0.534 + Double(pixel.blue) * 0.131, 255)
                
                return Pixel(
                    red: UInt8(red),
                    green: UInt8(green),
                    blue: UInt8(blue),
                    alpha: pixel.alpha)
            }),
            width: rgbaImage.width,
            height: rgbaImage.height)
    }
    
}