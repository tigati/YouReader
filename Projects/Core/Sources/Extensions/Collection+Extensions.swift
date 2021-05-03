import Foundation

public extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

    static func safeElementAtIndex<T: Collection>(collection: T, index: T.Index) -> T.Element? {
        return collection.indices.contains(index) ? collection[index] : nil
    }
}

public extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safeFromEnd index: Index) -> Element? {
        let offset = self.distance(from: index, to: self.startIndex) - 1
        let newIndex = self.index(self.endIndex, offsetBy: offset)
        return indices.contains(newIndex) ? self[newIndex] : nil
    }
}

public extension Collection {
    func distance(to index: Index) -> Int { distance(from: startIndex, to: index) }
}
