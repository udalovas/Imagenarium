import Foundation

public class FilterChain {
    
    private var filters:[Filter] = []
    
    public init() {}
    
    public func addFilter(filter:Filter) -> FilterChain {
        filters.append(filter);
        return self
    }
    
    public func clear() -> FilterChain {
        filters.removeAll()
        return self
    }
}