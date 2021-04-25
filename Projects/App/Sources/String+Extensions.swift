import Foundation
import UIKit

extension String {
    func highlight(stringPart: StringPart, fontName: String, size: CGFloat) -> NSAttributedString {
        let string = NSMutableAttributedString(string: self)
        let nsRange = NSRange(stringPart.range, in: self)
//        string.addAttribute(.foregroundColor, value: color, range: nsRange)
        string.addAttribute(.font, value: UIFont(name: fontName, size: size), range: nsRange)
        return string
    }
}
