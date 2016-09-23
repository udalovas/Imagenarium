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
}