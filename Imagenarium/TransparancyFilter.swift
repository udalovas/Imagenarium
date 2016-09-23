import Foundation

public class TransparancyFilter: Filter {
    
    public static let FULL:TransparancyFilter = TransparancyFilter(alpha: 255)
    public static let HALF:TransparancyFilter = TransparancyFilter(alpha: 128)
    
    private let alpha:UInt8
    
    public init(alpha: UInt8) {
        self.alpha = alpha;
    }
    
    public func apply(inout rgbaImage: RGBAImage) -> RGBAImage{
        
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x;
                rgbaImage.pixels[index].alpha = self.alpha;
            }
        }
        
        return rgbaImage
    }
}