import UIKit
import ImageIO

open class ImageProcessor {
    
    open static let FILTERS:[String] = ["GrayScale", "CISepiaTone", "CIGaussianBlur", "CITwirlDistortion", "CIBumpDistortion", "CIPixellate", "CIUnsharpMask", "CIVignette"]
    
    open static func getFilter(_ filter:String) -> CIFilter? {
        switch filter {
        case "GrayScale":
            return GrayScaleCIFilter()
        default:
            return CIFilter(name: filter)
        }
    }
    
    open static func apply(filterKey:String, to image: UIImage, in context:CIContext) -> UIImage? {
        let filter = ImageProcessor.getFilter(filterKey)
        filter?.setValue(CIImage(image: image), forKey: kCIInputImageKey)
        if let cgimg = context.createCGImage(filter!.outputImage!, from: filter!.outputImage!.extent) {
            return UIImage(cgImage: cgimg)
        } else { return nil }
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
