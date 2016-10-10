import Foundation

open class FilterChain {
    
    fileprivate var filters:[Filter] = []
    
    public init() {}
    
    open func addFilter(_ filter:Filter) -> FilterChain {
        filters.append(filter);
        return self
    }
    
    open func clear() -> FilterChain {
        filters.removeAll()
        return self
    }
}
