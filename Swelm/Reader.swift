import Foundation

public struct Reader<R,A> {
    let f:(R) -> A
    
    public init(_ fun:@escaping((R) -> A)) {
        f = fun
    }
    
    public static func wrap(val:A) -> Reader<R,A> {
        return Reader({_ in val})
    }
    
    public func runReader(r:R) -> A {
        return f(r)
    }
}
