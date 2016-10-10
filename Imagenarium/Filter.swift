import Foundation

public protocol Filter {
    
    func apply(_ rgbaImage: RGBAImage) -> RGBAImage
}

