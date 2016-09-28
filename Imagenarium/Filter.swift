import Foundation

public protocol Filter {
    
    func apply(rgbaImage: RGBAImage) -> RGBAImage
}

