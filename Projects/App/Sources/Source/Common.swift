import Foundation
import UIKit

typealias SoundFilename = String
typealias ImageFilename = String

struct Phrase {
    let text: String
    let image: ImageFilename
    let background: UIColor
}

struct StringPart: Equatable {
    let text: String
    let range: Range<String.Index>
    let isAccent: Bool
}
