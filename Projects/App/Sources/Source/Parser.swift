import Foundation

let russianLetters = Set("абвгдеёжзийклмнопрстуфхцчшщьъыэюя")
let russianSoglasnaie = Set("бвгджзйклмнпрстфхцчшщ")
let russianZnaki = Set("ьъ")
let russianGlasnie = Set("аеёиоуыэюя")
let accentSymbol: Character = "`"

func parseBySklads(text: String) -> [StringPart] {
    let accentIndex = text.distance(of: accentSymbol).map { $0 - 1 }
    let text = text.lowercased().replacingOccurrences(of: String(accentSymbol), with: String.empty)
    var substrings: [StringPart] = []
    var previousSkladIndex: Int? = nil
    for (index, char) in text.enumerated() {
        
        // Определяем под ударением ли склад
        let isAccent = accentIndex == index
        
        if char.isRussianLetter == false { continue }
        
        // Уже есть буква и она согласная
        if let startIndex = previousSkladIndex {
            previousSkladIndex = index
            var letterOffset = 1
            if char.isGlasnaya || char.isRussianZnak {
                letterOffset = 2
                previousSkladIndex = nil
            }
            
            let start = text.index(text.startIndex, offsetBy: startIndex)
            let end = text.index(text.startIndex, offsetBy: startIndex + letterOffset)
            let range = start..<end
            let candidate = String(text[range])
            let part = StringPart.init(text: candidate, range: range, isAccent: isAccent)
            substrings.append(part)
            continue
        }
        
        if char.isGlasnaya {
            let start = text.index(text.startIndex, offsetBy: index)
            let end = text.index(text.startIndex, offsetBy: index + 1)
            let range = start..<end
            let candidate = String(text[range])
            let part = StringPart.init(text: candidate, range: range, isAccent: isAccent)
            substrings.append(part)
            previousSkladIndex = nil
            continue
        }
        
        previousSkladIndex = index
    }
    
    if let startIndex = previousSkladIndex {
        let start = text.index(text.startIndex, offsetBy: startIndex)
        let end = text.index(text.startIndex, offsetBy: startIndex + 1)
        let range = start..<end
        let isAccent = accentIndex == startIndex
        let candidate = String(text[range])
        let part = StringPart.init(text: candidate, range: range, isAccent: isAccent)
        substrings.append(part)
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

let phrases: [Phrase] = [
    .init(text: "ёж", image: "Gulka_046", background: Palette.red),
    .init(text: "кот", image: "Gulka_007", background: Palette.red),
    .init(text: "суп", image: "Gulka_005", background: Palette.green),
    .init(text: "шея", image: "Gulka_029", background: Palette.red),
    .init(text: "сок", image: "Gulka_028", background: Palette.yellow),
    .init(text: "лес", image: "Gulka_057", background: Palette.blue),
    .init(text: "фея", image: "Gulka_037", background: Palette.red),
    .init(text: "усы", image: "Gulka_038", background: Palette.yellow),
    .init(text: "яма", image: "Gulka_047", background: Palette.green),
    .init(text: "пар", image: "Gulka_048", background: Palette.red),
    .init(text: "дым", image: "Gulka_049", background: Palette.green),
    .init(text: "мак", image: "Gulka_051", background: Palette.yellow),
    .init(text: "оса", image: "Gulka_054", background: Palette.red),
    
    .init(text: "сатурн", image: "Gulka_010", background: Palette.red),
    .init(text: "юбка", image: "Gulka_010", background: Palette.red),
    
    .init(text: "сапог", image: "Gulka_011", background: Palette.green),
    .init(text: "камень", image: "Gulka_011", background: Palette.green),
    
    .init(text: "рыба", image: "Gulka_009", background: Palette.green),
    .init(text: "сачок", image: "Gulka_009", background: Palette.blue),
    
    .init(text: "салют", image: "Gulka_008", background: Palette.red),
    
    .init(text: "сумка", image: "Gulka_007", background: Palette.red),
    
    .init(text: "туфли", image: "Gulka_006", background: Palette.red),

    
    .init(text: "туча", image: "Gulka_004", background: Palette.blue),
    
    .init(text: "санки", image: "Gulka_003", background: Palette.blue),
    
    .init(text: "пожар", image: "Gulka_001", background: Palette.blue),
    
    .init(text: "лебедь", image: "Gulka_002", background: Palette.yellow),
    
    .init(text: "почта", image: "Gulka_032", background: Palette.red),
    .init(text: "письмо", image: "Gulka_032", background: Palette.red),
    
    .init(text: "поезд", image: "Gulka_033", background: Palette.green),
    .init(text: "билет", image: "Gulka_033", background: Palette.green),
    
    .init(text: "подушка", image: "Gulka_035", background: Palette.red),
    
    .init(text: "посуда", image: "Gulka_034", background: Palette.yellow),
    
    .init(text: "пони", image: "Gulka_014", background: Palette.yellow),
    
    .init(text: "лимон", image: "Gulka_017", background: Palette.yellow),
    
    .init(text: "лужа", image: "Gulka_015", background: Palette.blue),
    
    .init(text: "рука", image: "Gulka_029", background: Palette.red),
    
    .init(text: "луна", image: "Gulka_012", background: Palette.yellow),
    
    .init(text: "собака", image: "Gulka_030", background: Palette.green),
    
    .init(text: "музыка", image: "Gulka_027", background: Palette.yellow),
    
    .init(text: "соль", image: "Gulka_026", background: Palette.red),
    
    .init(text: "ручка", image: "Gulka_025", background: Palette.blue),
    
    .init(text: "сова", image: "Gulka_024", background: Palette.green),
    
    .init(text: "лава", image: "Gulka_022", background: Palette.yellow),
    
    .init(text: "лапша", image: "Gulka_023", background: Palette.red),
    
    .init(text: "лама", image: "Gulka_021", background: Palette.yellow),
    
    .init(text: "ласты", image: "Gulka_020", background: Palette.blue),
    
    .init(text: "факел", image: "Gulka_019", background: Palette.yellow),
    
    .init(text: "лейка", image: "Gulka_018", background: Palette.green),
    
    .init(text: "лупа", image: "Gulka_031", background: Palette.blue),
    
    .init(text: "жаба", image: "Gulka_056", background: Palette.yellow),
    .init(text: "палка", image: "Gulka_056", background: Palette.yellow),
    
    .init(text: "снеговик", image: "Gulka_036", background: Palette.blue),
    
    .init(text: "динозавр", image: "Gulka_039", background: Palette.yellow),
    
    .init(text: "ванна", image: "Gulka_040", background: Palette.blue),
    
    .init(text: "машина", image: "Gulka_041", background: Palette.green),
    
    .init(text: "очки", image: "Gulka_042", background: Palette.red),
    
    .init(text: "вампир", image: "Gulka_043", background: Palette.blue),
    
    .init(text: "мороженое", image: "Gulka_044", background: Palette.yellow),
    
    
    
    .init(text: "нога", image: "Gulka_050", background: Palette.yellow),
    
    
    
    .init(text: "кактус", image: "Gulka_052", background: Palette.blue),
    
    .init(text: "папа", image: "Gulka_053", background: Palette.red),
    
    .init(text: "домик", image: "Gulka_055", background: Palette.green),
    
    
]

/*
 ёж - к
 
 кот - к
 суп - з
 шея - к
 сок - ж
 лес - с
 фея - к
 усы - ж
 яма - з
 пар - к
 дым - з
 мак - ж
 оса - к
 
 рыба - з
 туча - с
 пони - ж
 лужа - с
 рука - к
 луна - ж
 соль - к
 сова - з
 лава - ж
 лама - ж
 лупа - с
 жаба - ж
 нога - ж
 папа - к
 
 юбка - к
 сапог - з
 сачок - с
 салют - к
 сумка - к
 туфли - к
 санки - с
 пожар - с
 почта - к
 билет - з
 лимон - ж
 ручка - с
 лапша - к
 ласты - с
 факел - ж
 лейка - з
 палка - ж
 ванна - с
 очки - п
 домик - ж
 поезд - з
 
 сатурн - к
 камень - з
 лебедь - ж
 письмо - к
 посуда - ж
 собака - з
 музыка - ж
 машина - з
 вампир - с
 кактус - с
 
 подушка - ж
 снеговик - с
 динозавр - ж
 мороженое - с
 
*/
 

let words: [Phrase] = {
//    let allSklads = Array(Set(phrases.flatMap { phrase -> [String] in
//        parseBySklads(text: phrase.text).map{$0.text}
//    }))//.shuffled()
//
//    var notePhrases = allSklads.chunked(into: 25).map { sklads -> Phrase in
//        let text = sklads.joined()
//        return .init(text: text, image: "", background: .black)
//    }
//
//    notePhrases.append(contentsOf: phrases)
//    notePhrases.shuffle()
    return phrases
}()


let phrases2: [String] = [
    "сатурн",
    "юбка",
    
    "сапог",
    "камень",
    
    "рыба",
    "сачок",
    
    "салют",
    
    "сумка",
    "кот",
    
    "туфли",
    
    "суп",
    
    "туча",
    
    "санки",
    
    "пожар",
    
    "лебедь",
    
    "почта",
    "письмо",
    
    "поезд",
    "билет",
    
    "подушка",
    
    "посуда",
    
    "пони",
    
    "лимон",
    
    "лужа",
    
    "рука",
    "шея",
    
    "луна",
    
    "собака",
    
    "сок",
    
    "музыка",
    
    "соль",
    
    "ручка",
    
    "сова",
    
    "лава",
    
    "лапша",
    
    "лама",
    
    "ласты",
    
    "факел",
    
    "лейка",
    
    "лес",
    
    "лупа",
    
    "жаба",
    "палка",
    
    "снеговик",
    
    "фея",
    
    "усы",
    
    "динозавр",
    
    "ванна",
    
    "машина",
    
    "очки",
    
    "вампир",
    
    "мороженое",
    
    "ёж",
    
    "яма",
    
    "пар",
    
    "дым",
    
    "нога",
    
    "мак",
    
    "кактус",
    
    "папа",
    
    "оса",
    
    "домик",
    
    
]
