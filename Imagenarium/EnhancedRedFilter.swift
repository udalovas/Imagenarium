//
//  EnhancedRedFilter.swift
//  Imagenarium
//
//  Created by Алексей Удалов on 23/09/16.
//  Copyright © 2016 udalovas. All rights reserved.
//

import Foundation

public class EnhancedRedFilter: Filter {
    
    private let level:Int
    
    public init(level: Int) {
        self.level = level;
    }
    
    public func apply(inout rgbaImage: RGBAImage) -> RGBAImage {
       
        let avgRed = ImageProcessor.getAvgColors(rgbaImage).R
        
        for y in 0 ..< rgbaImage.height {
            for x in 0 ..< rgbaImage.width {
                let index = y * rgbaImage.width + x
                var pixel = rgbaImage.pixels[index]
                
                let redDiff = Int(pixel.red) - avgRed
                if redDiff > 0 {
                    pixel.red = UInt8(max(0, min(255, avgRed + redDiff * level)))
                    rgbaImage.pixels[index] = pixel
                }
            }
        }
        return rgbaImage
    }
    
}