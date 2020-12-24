import Foundation

typealias SoundFilename = String
typealias ImageFilename = String

struct WordPart: RawRepresentable, Equatable {
    let text: String
    let sound: SoundFilename
    
    typealias RawValue = (text: String, sound: String)
    
    init(text: String, sound: String) {
        self.text = text
        self.sound = sound
    }
    
    init?(rawValue: (text: String, sound: String)) {
        self.text = rawValue.text
        self.sound = rawValue.sound
    }
    
    var rawValue: (text: String, sound: String) {
        return (text, sound)
    }
}
