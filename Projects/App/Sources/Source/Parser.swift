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
    .init(text: "сату`рн", image: "Gulka_010", background: Palette.red),
    .init(text: "ю`бка", image: "Gulka_010", background: Palette.red),
    
    .init(text: "сапо`г", image: "Gulka_011", background: Palette.green),
    .init(text: "ка`мень", image: "Gulka_011", background: Palette.green),
    
    .init(text: "ры`ба", image: "Gulka_009", background: Palette.blue),
    .init(text: "сачо`к", image: "Gulka_009", background: Palette.blue),
    
    .init(text: "салю`т", image: "Gulka_008", background: Palette.red),
    
    .init(text: "су`мка", image: "Gulka_007", background: Palette.red),
    .init(text: "ко`т", image: "Gulka_007", background: Palette.red),
    
    .init(text: "ту`фли", image: "Gulka_006", background: Palette.red),
    
    .init(text: "су`п", image: "Gulka_005", background: Palette.green),
    
    .init(text: "ту`ча", image: "Gulka_004", background: Palette.blue),
    
    .init(text: "са`нки", image: "Gulka_003", background: Palette.blue),
    
    .init(text: "пожа`р", image: "Gulka_001", background: Palette.blue),
    
    .init(text: "ле`бедь", image: "Gulka_002", background: Palette.yellow),
    
    .init(text: "по`чта", image: "Gulka_032", background: Palette.red),
    .init(text: "письмо``", image: "Gulka_032", background: Palette.red),
    
    .init(text: "по`езд", image: "Gulka_033", background: Palette.green),
    .init(text: "биле`т", image: "Gulka_033", background: Palette.green),
    
    .init(text: "поду`шка", image: "Gulka_035", background: Palette.red),
    
    .init(text: "посу`да", image: "Gulka_034", background: Palette.yellow),
    
    .init(text: "по`ни", image: "Gulka_014", background: Palette.yellow),
    
    .init(text: "лимо`н", image: "Gulka_017", background: Palette.yellow),
    
    .init(text: "лу`жа", image: "Gulka_015", background: Palette.blue),
    
    .init(text: "рука`", image: "Gulka_029", background: Palette.red),
    .init(text: "ше`я", image: "Gulka_029", background: Palette.red),
    
    .init(text: "луна`", image: "Gulka_012", background: Palette.yellow),
    
    .init(text: "соба`ка", image: "Gulka_030", background: Palette.green),
    
    .init(text: "со`к", image: "Gulka_028", background: Palette.green),
    
    .init(text: "му`зыка", image: "Gulka_027", background: Palette.yellow),
    
    .init(text: "со`ль", image: "Gulka_026", background: Palette.yellow),
    
    .init(text: "ру`чка", image: "Gulka_025", background: Palette.blue),
    
    .init(text: "сова`", image: "Gulka_024", background: Palette.green),
    
    .init(text: "ла`ва", image: "Gulka_022", background: Palette.yellow),
    
    .init(text: "лапша`", image: "Gulka_023", background: Palette.red),
    
    .init(text: "ла`ма", image: "Gulka_021", background: Palette.yellow),
    
    .init(text: "ла`сты", image: "Gulka_020", background: Palette.blue),
    
    .init(text: "фа`кел", image: "Gulka_019", background: Palette.yellow),
    
    .init(text: "ле`йка", image: "Gulka_018", background: Palette.green),
    
    .init(text: "ле`с", image: "Gulka_057", background: Palette.green),
    
    .init(text: "лу`па", image: "Gulka_031", background: Palette.blue),
    
    .init(text: "жа`ба", image: "Gulka_056", background: Palette.yellow),
    .init(text: "па`лка", image: "Gulka_056", background: Palette.yellow),
    
    .init(text: "снегови`к", image: "Gulka_036", background: Palette.blue),
    
    .init(text: "фе`я", image: "Gulka_037", background: Palette.red),
    
    .init(text: "усы`", image: "Gulka_038", background: Palette.green),
    
    .init(text: "диноза`вр", image: "Gulka_039", background: Palette.yellow),
    
    .init(text: "ва`нна", image: "Gulka_040", background: Palette.blue),
    
    .init(text: "маши`на", image: "Gulka_041", background: Palette.green),
    
    .init(text: "очки`", image: "Gulka_042", background: Palette.red),
    
    .init(text: "вампи`р", image: "Gulka_043", background: Palette.blue),
    
    .init(text: "моро`женое", image: "Gulka_044", background: Palette.yellow),
    
    .init(text: "ё`ж", image: "Gulka_046", background: Palette.red),
    
    .init(text: "я`ма", image: "Gulka_047", background: Palette.green),
    
    .init(text: "па`р", image: "Gulka_048", background: Palette.red),
    
    .init(text: "ды`м", image: "Gulka_049", background: Palette.green),
    
    .init(text: "нога`", image: "Gulka_050", background: Palette.yellow),
    
    .init(text: "ма`к", image: "Gulka_051", background: Palette.green),
    
    .init(text: "ка`ктус", image: "Gulka_052", background: Palette.blue),
    
    .init(text: "па`па", image: "Gulka_053", background: Palette.red),
    
    .init(text: "оса`", image: "Gulka_054", background: Palette.red),
    
    .init(text: "до`мик", image: "Gulka_055", background: Palette.green),
    
    
]

/*
 
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
    "сату`рн",
    "ю`бка",
    
    "сапо`г",
    "ка`мень",
    
    "ры`ба",
    "сачо`к",
    
    "салю`т",
    
    "су`мка",
    "ко`т",
    
    "ту`фли",
    
    "су`п",
    
    "ту`ча",
    
    "са`нки",
    
    "пожа`р",
    
    "ле`бедь",
    
    "по`чта",
    "письмо``",
    
    "по`езд",
    "биле`т",
    
    "поду`шка",
    
    "посу`да",
    
    "по`ни",
    
    "лимо`н",
    
    "лу`жа",
    
    "рука`",
    "ше`я",
    
    "луна`",
    
    "соба`ка",
    
    "со`к",
    
    "му`зыка",
    
    "со`ль",
    
    "ру`чка",
    
    "сова`",
    
    "ла`ва",
    
    "лапша`",
    
    "ла`ма",
    
    "ла`сты",
    
    "фа`кел",
    
    "ле`йка",
    
    "ле`с",
    
    "лу`па",
    
    "жа`ба",
    "па`лка",
    
    "снегови`к",
    
    "фе`я",
    
    "усы`",
    
    "диноза`вр",
    
    "ва`нна",
    
    "маши`на",
    
    "очки`",
    
    "вампи`р",
    
    "моро`женое",
    
    "ё`ж",
    
    "я`ма",
    
    "па`р",
    
    "ды`м",
    
    "нога`",
    
    "ма`к",
    
    "ка`ктус",
    
    "па`па",
    
    "оса`",
    
    "до`мик",
    
    
]
