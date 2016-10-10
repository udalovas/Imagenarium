import Foundation

open class TransparancyFilter: Filter {
    
    fileprivate let alpha:UInt8
    
    public init(alpha: UInt8) {
        self.alpha = alpha;
    }
    
    open func apply(_ rgbaImage: RGBAImage) -> RGBAImage {
        
        return RGBAImage(
            pixels: rgbaImage.pixels.map({ (pixel:Pixel) -> Pixel in
                return Pixel(
                    red: pixel.alpha,
                    green: pixel.green,
                    blue: pixel.blue,
                    alpha: self.alpha)
                }),
            width: rgbaImage.width,
            height: rgbaImage.height)
    }
}
