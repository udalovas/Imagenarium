//
//  GreyScaleFilter.swift
//  Imagenarium
//
//  Created by Алексей Удалов on 23/09/16.
//  Copyright © 2016 udalovas. All rights reserved.
//

import Foundation

open class GrayScaleFilter: Filter {
    
    open static let INSTANCE:Filter = GrayScaleFilter()
    
    open func apply(_ rgbaImage: RGBAImage) -> RGBAImage {
        return RGBAImage(
            pixels: rgbaImage.pixels.map({ pixel -> Pixel in
                let gray = (Int(pixel.red) + Int(pixel.green) + Int(pixel.blue)) / 3
                return Pixel(
                    red: UInt8(gray),
                    green: UInt8(gray),
                    blue: UInt8(gray),
                    alpha: pixel.alpha)
            }),
            width: rgbaImage.width,
            height: rgbaImage.height)
    }
}
