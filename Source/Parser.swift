import Foundation

let russianLetters = Set("абвгдеёжзийклмнопрстуфхцчшщьъыэюя")
let russianSoglasnaie = Set("бвгджзйклмнпрстфхцчшщ")
let russianZnaki = Set("ьъ")
let russianGlasnie = Set("аеёиоуыэюя")

func parseBySklads(text: String) -> [Substring] {
    let text = text.lowercased()
    var substrings: [Substring] = []
    var previousSkladIndex: Int? = nil
    for (index, char) in text.enumerated() {
        
        if char.isRussianLetter == false { continue }
        
        // Уже есть буква и она согласная
        if let startIndex = previousSkladIndex {
            var letterOffset = 1
            previousSkladIndex = index
            if char.isGlasnaya || char.isRussianZnak {
                letterOffset = 2
                previousSkladIndex = nil
            }
            
            let start = text.index(text.startIndex, offsetBy: startIndex)
            let end = text.index(text.startIndex, offsetBy: startIndex + letterOffset)
            let candidate = text[start..<end]
            substrings.append(candidate)
            continue
        }
        
        if char.isGlasnaya {
            let start = text.index(text.startIndex, offsetBy: index)
            let end = text.index(text.startIndex, offsetBy: index + 1)
            let candidate = text[start..<end]
            print("")
            substrings.append(candidate)
            previousSkladIndex = nil
            continue
        }
        
        previousSkladIndex = index
    }
    
    if let startIndex = previousSkladIndex {
        let start = text.index(text.startIndex, offsetBy: startIndex)
        let end = text.index(text.startIndex, offsetBy: startIndex + 1)
        let candidate = text[start..<end]
        substrings.append(candidate)
    }
    
    
    return substrings
}

extension Character {
    var isRussianLetter: Bool {
        russianLetters.contains(self)
    }
    
    var isGlasnaya: Bool {
        russianGlasnie.contains(self)
    }
    
    var isSoglasnaya: Bool {
        russianSoglasnaie.contains(self)
    }
    
    var isRussianZnak: Bool {
        russianZnaki.contains(self)
    }
}

let phrases: [String] = [
    "фу! кислый!",
    "ой! кто это?",
    "какой красивый!",
    "я похож на луну?",
    "наберу грибов",
    "вот ты где!",
    "эй! поехали!",
    "мамочки! горим!",
    "я - молодец",
    "баю-бай",
    "еду к бабушке!",
    "письмо деду морозу",
    "нос замёрз",
    "не весело",
    "там моркова",
    "я как папа!",
    "не бойся, кот!",
    "ба-бах",
    "я и мой брат",
    "рисую змею",
    "принимаю соль",
    "надо погромче!",
    "закончился",
    "отпусти",
    "гав-гав!",

]


