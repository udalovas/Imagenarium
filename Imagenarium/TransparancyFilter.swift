import Foundation

public class TransparancyFilter: Filter {
    
    private let alpha:UInt8
    
    public init(alpha: UInt8) {
        self.alpha = alpha;
    }
    
    public func apply(inout rgbaImage: RGBAImage) -> RGBAImage {
        
        rgbaImage.pixels = rgbaImage.pixels.map({ (pixel:Pixel) -> Pixel in
            return Pixel(
                red: pixel.alpha,
                green: pixel.green,
                blue: pixel.blue,
                alpha: self.alpha)
        })
        
        return rgbaImage
    }
}