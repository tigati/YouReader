import Foundation
import UIKit

extension UIFontDescriptor {
    static let monoDescriptor: UIFontDescriptor = {
        // Attempt to find a good monospaced, non-bold, non-italic font
        for family in UIFont.familyNames {
            for name in UIFont.fontNames(forFamilyName: family) {
                guard let f = UIFont(name: name, size: 12)
                else { break }
                let fd = f.fontDescriptor
                let st = fd.symbolicTraits
                if
                    st.contains(.traitMonoSpace) &&
                    !st.contains(.traitBold) &&
                    !st.contains(.traitItalic) &&
                    !st.contains(.traitExpanded) &&
                    !st.contains(.traitCondensed)
                {
                    return fd
                }
            }
        }

        return UIFontDescriptor(name: "Courier", size: 0) // fallback
    }()

    class func preferredMonoFontDescriptor(withTextStyle style: UIFont.TextStyle) -> UIFontDescriptor {
        // Use the following line if you need a fully monospaced font
        let monoDescriptor = UIFontDescriptor.monoDescriptor

        // Use the following two lines if you only need monospaced digits in the font
        //let monoDigitFont = UIFont.monospacedDigitSystemFont(ofSize: 0, weight: .regular)
        //let monoDescriptor = monoDigitFont.fontDescriptor

        // Get the non-monospaced preferred font
        let defaultFontDescriptor = preferredFontDescriptor(withTextStyle: style)
        // Remove any attributes that specify a font family or name and remove the usage
        // This will leave other attributes such as size and weight, etc.
        var fontAttrs = defaultFontDescriptor.fontAttributes
        fontAttrs.removeValue(forKey: .family)
        fontAttrs.removeValue(forKey: .name)
        fontAttrs.removeValue(forKey: .init(rawValue: "NSCTFontUIUsageAttribute"))
        let monospacedFontDescriptor = monoDescriptor.addingAttributes(fontAttrs)

        return monospacedFontDescriptor
            .withSymbolicTraits(defaultFontDescriptor.symbolicTraits)
            ?? monospacedFontDescriptor
    }
}
