import Foundation

public extension String {
    static let empty = String()
}

public extension String {
    func findIndexes(character: Character) -> [Int] {
        self.enumerated().reduce(into:  [Int]()) { indexes, candidate in
            if candidate.element == character {
                indexes.append(candidate.offset)
            }
        }
    }
}

public extension StringProtocol {
    func distance(of element: Element) -> Int? { firstIndex(of: element)?.distance(in: self) }
    func distance<S: StringProtocol>(of string: S) -> Int? { range(of: string)?.lowerBound.distance(in: self) }
}

public extension String.Index {
    func distance<S: StringProtocol>(in string: S) -> Int { string.distance(to: self) }
}
