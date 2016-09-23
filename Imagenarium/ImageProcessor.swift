import Foundation

public class ImageProcessor {
    
    public init() {}
    
    public enum FilterSet {
        
        case CALM, INCREASED_CONSTRAST
    }
    
    public func process(inout rgbaImage:RGBAImage, with filter:FilterSet) -> RGBAImage {
        switch filter {
        case .CALM:
            FilterChain()
                .addFilter(TransparancyFilter.HALF)
                .apply(&rgbaImage)
        case .INCREASED_CONSTRAST:
            FilterChain()
                .addFilter(TransparancyFilter.FULL)
                .apply(&rgbaImage)
        }
        return rgbaImage
    }
    
    public static func getAvgColors(rgbaImage:RGBAImage) -> (R: Int, G: Int, B: Int) {
        
        var totalRed = 0
        var totalGreen = 0
        var totalBlue = 0
        
        for y in 0 ..< rgbaImage.height {
            for x in 0 ..< rgbaImage.width {
                let index = y * rgbaImage.width + x
                var pixel = rgbaImage.pixels[index]
                
                totalRed += Int(pixel.red)
                totalGreen += Int(pixel.green)
                totalBlue += Int(pixel.blue)
            }
        }
        
        let count = rgbaImage.width * rgbaImage.height
        return (totalRed/count, totalGreen/count, totalBlue/count)
    }
}