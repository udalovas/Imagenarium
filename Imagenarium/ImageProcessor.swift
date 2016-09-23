import Foundation

public class ImageProcessor {
    
    public init() {}
    
    public static func getAvgColors(rgbaImage:RGBAImage) -> (R: Int, G: Int, B: Int) {
        
        let total = rgbaImage.pixels.reduce((0, 0, 0)) { (accumulator: (Int, Int, Int), pixel) -> (Int, Int, Int) in
            return (accumulator.0 + Int(pixel.red), accumulator.1 + Int(pixel.green), accumulator.2 + Int(pixel.blue))
        }
        
        return (total.0/rgbaImage.pixels.count, total.1/rgbaImage.pixels.count, total.2/rgbaImage.pixels.count)
    }
}