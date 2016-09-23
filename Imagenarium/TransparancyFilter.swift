import Foundation

public class TransparancyFilter: Filter {
    
    public static let FULL:TransparancyFilter = TransparancyFilter(alpha: 255)
    public static let HALF:TransparancyFilter = TransparancyFilter(alpha: 128)
    
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