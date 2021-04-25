import Foundation

public protocol PropsRenderer {
    associatedtype Props
    func render(_ props: Props)
}
