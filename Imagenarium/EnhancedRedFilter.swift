//
//  EnhancedRedFilter.swift
//  Imagenarium
//
//  Created by Алексей Удалов on 23/09/16.
//  Copyright © 2016 udalovas. All rights reserved.
//

import Foundation

public class EnhancedRedFilter: Filter {
    
    public static let DEFAULT_LEVEL:Int = 5;
    
    private let level:Int
    
    public convenience init() {
        self.init(level: EnhancedRedFilter.DEFAULT_LEVEL)
    }
    
    public init(level: Int) {
        self.level = level;
    }
    
    public func apply(inout rgbaImage: RGBAImage) -> RGBAImage {
       
        let avgRed = ImageProcessor.getAvgColors(rgbaImage).R
        
        rgbaImage.pixels = rgbaImage.pixels.map({ (pixel:Pixel) -> Pixel in
            
            let redDiff = Int(pixel.red) - avgRed
            
            return Pixel(
                red: redDiff > 0 ?
                    UInt8(max(0, min(255, avgRed + redDiff * level))) : pixel.red,
                green: pixel.green,
                blue: pixel.blue,
                alpha: pixel.alpha)
        })
        
        return rgbaImage
    }
    
}