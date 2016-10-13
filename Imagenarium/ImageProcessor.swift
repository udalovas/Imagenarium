import UIKit
import ImageIO

open class ImageProcessor {
    
    public enum FilterType: String {
        case Sepia, GrayScale, RedRose
        
        static let all:[FilterType] = [Sepia, GrayScale, RedRose];
    }
    
    open static func getFilter(_ filter:String) -> Filter {
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
    
    open static func getAvgColors(_ rgbaImage:RGBAImage) -> (R: Int, G: Int, B: Int) {
        let total = rgbaImage.pixels.reduce((0, 0, 0)) { (accumulator: (Int, Int, Int), pixel) -> (Int, Int, Int) in
            return (accumulator.0 + Int(pixel.red), accumulator.1 + Int(pixel.green), accumulator.2 + Int(pixel.blue))
        }
        return (total.0/rgbaImage.pixels.count, total.1/rgbaImage.pixels.count, total.2/rgbaImage.pixels.count)
    }
    
    open static func drawText(_ text: String, inImage: UIImage, atPoint: CGPoint) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(inImage.size, false, UIScreen.main.scale)
        inImage.draw(in: CGRect(x: 0, y: 0, width: inImage.size.width, height: inImage.size.height))
        let rect = CGRect(x: atPoint.x, y: atPoint.y, width: inImage.size.width, height: inImage.size.height)
        text.draw(in: rect, withAttributes: [
            NSFontAttributeName: UIFont(name: "Helvetica Bold", size: 14)!,
            NSForegroundColorAttributeName: UIColor.white,
        ])
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result!
    }
}
