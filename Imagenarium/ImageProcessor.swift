import Foundation

public class ImageProcessor {
    
    public enum FilterType: String {
        case Sepia, GrayScale, RedRose
        
        static let all:[FilterType] = [Sepia, GrayScale, RedRose];
    }
    
    public static func getFilter(filter:String) -> Filter {
        switch filter {
        case FilterType.GrayScale.rawValue:
            return GrayScaleFilter.INSTANCE
        case FilterType.Sepia.rawValue:
            return SepiaFilter.INSTANCE
        case FilterType.RedRose.rawValue:
            return EnhancedRedFilter()
        default: return NoopFilter.INSTANCE
        }
    }
    
    public static func getAvgColors(rgbaImage:RGBAImage) -> (R: Int, G: Int, B: Int) {
        
        let total = rgbaImage.pixels.reduce((0, 0, 0)) { (accumulator: (Int, Int, Int), pixel) -> (Int, Int, Int) in
            return (accumulator.0 + Int(pixel.red), accumulator.1 + Int(pixel.green), accumulator.2 + Int(pixel.blue))
        }
        
        return (total.0/rgbaImage.pixels.count, total.1/rgbaImage.pixels.count, total.2/rgbaImage.pixels.count)
    }
}