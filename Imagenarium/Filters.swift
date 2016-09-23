import Foundation
import UIKit

public struct Filters {
    
    private var image: RGBAImage!
    private var avgRed: Int!
    private var avgGreen: Int!
    private var avgBlue: Int!
    
    public init(image: UIImage) {
        self.image = RGBAImage(image: image)!
    }
    
    private mutating func getAvgColors() {
        var totalRed = 0
        var totalGreen = 0
        var totalBlue = 0
        
        for y in 0 ..< self.image.height {
            for x in 0 ..< self.image.width {
                let index = y * self.image.width + x
                var pixel = self.image.pixels[index]
                
                totalRed += Int(pixel.red)
                totalGreen += Int(pixel.green)
                totalBlue += Int(pixel.blue)
            }
        }
        
        let count = self.image.width * self.image.height
        self.avgRed = totalRed/count
        self.avgGreen = totalGreen/count
        self.avgBlue = totalBlue/count
    }
    
    public mutating func enhanceRed(level: Int) -> UIImage? {
        getAvgColors()
        var temp = self.image
        for y in 0 ..< temp.height {
            for x in 0 ..< temp.width {
                let index = y * temp.width + x
                var pixel = temp.pixels[index]
                
                let redDiff = Int(pixel.red) - avgRed
                if redDiff > 0 {
                    pixel.red = UInt8(max(0, min(255, avgRed + redDiff * level)))
                    temp.pixels[index] = pixel
                }
            }
        }
        return temp.toUIImage()
    }
    
    public func grayscale() -> UIImage? {
        var temp = self.image
        for y in 0 ..< temp.height {
            for x in 0 ..< temp.width {
                let index = y * temp.width + x
                var pixel = temp.pixels[index]
                
                let gray = (Int(pixel.red) + Int(pixel.green) + Int(pixel.blue)) / 3
                
                pixel.red = UInt8(gray)
                pixel.green = UInt8(gray)
                pixel.blue = UInt8(gray)
                
                temp.pixels[index] = pixel
            }
        }
        return temp.toUIImage()
    }
    
    public func adjustBrightness(amount: Double) -> UIImage? {
        var temp = self.image
        for y in 0 ..< temp.height {
            for x in 0 ..< temp.width {
                let index = y * temp.width + x
                var pixel = temp.pixels[index]
                
                pixel.alpha = UInt8(max(0, min(255, amount * 255)))
                
                temp.pixels[index] = pixel
            }
        }
        return temp.toUIImage()
    }
}