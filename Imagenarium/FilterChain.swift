import Foundation

public class FilterChain: Filter {
    
    private var filters:[Filter] = []
    
    public init() {}
    
    public func addFilter(filter:Filter) -> FilterChain {
        filters.append(filter);
        return self
    }
    
    public func doChain(inout rgbaImage:RGBAImage) -> RGBAImage {
        filters.forEach{ (filter : Filter) -> () in
            filter.apply(&rgbaImage)
        }
        return rgbaImage
    }
    
    public func clear() -> FilterChain {
        filters.removeAll()
        return self
    }
    
    public func apply(inout rgbaImage: RGBAImage) -> RGBAImage {
        return doChain(&rgbaImage)
    }
}