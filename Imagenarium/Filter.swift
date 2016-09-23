import Foundation

public protocol Filter {
    
    func apply(inout rgbaImage: RGBAImage) -> RGBAImage
}

