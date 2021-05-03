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
    .init(text: "сату`рн", image: "Gulka_001", background: Palette.red),
    .init(text: "балери`на", image: "Gulka_001", background: Palette.red),
    .init(text: "ю`бка", image: "Gulka_001", background: Palette.red),
    
    .init(text: "сапо`г", image: "Gulka_002", background: Palette.green),
    .init(text: "ка`мень", image: "Gulka_002", background: Palette.green),
    .init(text: "молоде`ц", image: "Gulka_002", background: Palette.green),
    
    .init(text: "ры`ба", image: "Gulka_003", background: Palette.yellow),
    .init(text: "сачо`к", image: "Gulka_003", background: Palette.yellow),
    .init(text: "живи`", image: "Gulka_003", background: Palette.yellow),
    
    .init(text: "салю`т", image: "Gulka_004", background: Palette.green),
    .init(text: "ура`", image: "Gulka_004", background: Palette.green),
    .init(text: "пра`здник", image: "Gulka_004", background: Palette.green),
    
    .init(text: "су`мка", image: "Gulka_005", background: Palette.red),
    .init(text: "е`дет", image: "Gulka_005", background: Palette.red),
    .init(text: "ко`тик", image: "Gulka_005", background: Palette.red),
    
    .init(text: "ту`фли", image: "Gulka_006", background: Palette.blue),
    .init(text: "краси`вые", image: "Gulka_006", background: Palette.blue),
    .init(text: "каблуки`", image: "Gulka_006", background: Palette.blue),
    
    .init(text: "су`п", image: "Gulka_007", background: Palette.yellow),
    .init(text: "горячо`", image: "Gulka_007", background: Palette.yellow),
    .init(text: "поле`зно", image: "Gulka_007", background: Palette.yellow),
    
    .init(text: "ту`ча", image: "Gulka_008", background: Palette.blue),
    .init(text: "сержу`сь", image: "Gulka_008", background: Palette.blue),
    .init(text: "бу`ка", image: "Gulka_008", background: Palette.blue),
    
    .init(text: "са`нки", image: "Gulka_009", background: Palette.green),
    .init(text: "эгеге`й", image: "Gulka_009", background: Palette.green),
    .init(text: "ката`ться", image: "Gulka_009", background: Palette.green),
    
    .init(text: "пожа`р", image: "Gulka_010", background: Palette.blue),
    .init(text: "помоги`те", image: "Gulka_010", background: Palette.blue),
    .init(text: "беда`", image: "Gulka_010", background: Palette.blue),
    
    .init(text: "ле`бедь", image: "Gulka_011", background: Palette.red),
    .init(text: "люблю`", image: "Gulka_011", background: Palette.red),
    .init(text: "похо`ж", image: "Gulka_011", background: Palette.red),
    
    .init(text: "по`чта", image: "Gulka_012", background: Palette.green),
    .init(text: "ба`бушке", image: "Gulka_012", background: Palette.green),
    .init(text: "письмо`", image: "Gulka_012", background: Palette.green),
    
    .init(text: "по`езд", image: "Gulka_013", background: Palette.red),
    .init(text: "биле`т", image: "Gulka_013", background: Palette.red),
    .init(text: "путеше`ствие", image: "Gulka_013", background: Palette.red),
    
    .init(text: "поду`шка", image: "Gulka_014", background: Palette.yellow),
    .init(text: "спа`ть", image: "Gulka_014", background: Palette.yellow),
    .init(text: "хорошо`", image: "Gulka_014", background: Palette.yellow),
    
    .init(text: "посу`да", image: "Gulka_015", background: Palette.red),
    .init(text: "табуре`тка", image: "Gulka_015", background: Palette.red),
    .init(text: "мо`ю", image: "Gulka_015", background: Palette.red),
    
    .init(text: "по`ни", image: "Gulka_016", background: Palette.green),
    .init(text: "вса`дник", image: "Gulka_016", background: Palette.green),
    .init(text: "чё`лка", image: "Gulka_016", background: Palette.green),
    
    .init(text: "лимо`н", image: "Gulka_017", background: Palette.yellow),
    .init(text: "ки`слый", image: "Gulka_017", background: Palette.yellow),
    .init(text: "язы`к", image: "Gulka_017", background: Palette.yellow),
    
    .init(text: "лу`жа", image: "Gulka_018", background: Palette.red),
    .init(text: "смотрит", image: "Gulka_018", background: Palette.red),
    .init(text: "мокро", image: "Gulka_018", background: Palette.red),
    
    .init(text: "рука", image: "Gulka_019", background: Palette.yellow),
    .init(text: "шея", image: "Gulka_019", background: Palette.yellow),
    .init(text: "дышать", image: "Gulka_019", background: Palette.yellow),
    
    .init(text: "луна", image: "Gulka_020", background: Palette.yellow),
    .init(text: "дразнит", image: "Gulka_020", background: Palette.yellow),
    .init(text: "непохож", image: "Gulka_020", background: Palette.yellow),
    
    .init(text: "собака", image: "Gulka_021", background: Palette.green),
    .init(text: "копает", image: "Gulka_021", background: Palette.green),
    .init(text: "хороший", image: "Gulka_021", background: Palette.green),
    
    .init(text: "сок", image: "Gulka_022", background: Palette.red),
    .init(text: "пить", image: "Gulka_022", background: Palette.red),
    .init(text: "вкусный", image: "Gulka_022", background: Palette.red),
    
    .init(text: "радио", image: "Gulka_023", background: Palette.blue),
    .init(text: "музыка", image: "Gulka_023", background: Palette.blue),
    .init(text: "слушаю", image: "Gulka_023", background: Palette.blue),
    
    .init(text: "соль", image: "Gulka_024", background: Palette.red),
    .init(text: "вкусно", image: "Gulka_024", background: Palette.red),
    .init(text: "сыпать", image: "Gulka_024", background: Palette.red),
    
    .init(text: "ручка", image: "Gulka_025", background: Palette.yellow),
    .init(text: "каракуля", image: "Gulka_025", background: Palette.yellow),
    .init(text: "рисовать", image: "Gulka_025", background: Palette.yellow),
    
    .init(text: "сова", image: "Gulka_026", background: Palette.green),
    .init(text: "похож", image: "Gulka_026", background: Palette.green),
    .init(text: "друзья", image: "Gulka_026", background: Palette.green),
    
    .init(text: "лава", image: "Gulka_027", background: Palette.yellow),
    .init(text: "помогите", image: "Gulka_027", background: Palette.yellow),
    .init(text: "подушка", image: "Gulka_027", background: Palette.yellow),
    
    .init(text: "лапша", image: "Gulka_028", background: Palette.yellow),
    .init(text: "палочки", image: "Gulka_028", background: Palette.yellow),
    .init(text: "ест", image: "Gulka_028", background: Palette.yellow),
    
    .init(text: "лама", image: "Gulka_029", background: Palette.green),
    .init(text: "люблю", image: "Gulka_029", background: Palette.green),
    .init(text: "ест", image: "Gulka_029", background: Palette.green),
    
    .init(text: "ласты", image: "Gulka_030", background: Palette.yellow),
    .init(text: "палки", image: "Gulka_030", background: Palette.yellow),
    .init(text: "молодец", image: "Gulka_030", background: Palette.yellow),
    
    .init(text: "факел", image: "Gulka_031", background: Palette.red),
    .init(text: "огонь", image: "Gulka_031", background: Palette.red),
    .init(text: "зажигай", image: "Gulka_031", background: Palette.red),
    
    .init(text: "фасоль", image: "Gulka_032", background: Palette.yellow),
    .init(text: "вода", image: "Gulka_032", background: Palette.yellow),
    .init(text: "забота", image: "Gulka_032", background: Palette.yellow),
    
    .init(text: "лес", image: "Gulka_033", background: Palette.yellow),
    .init(text: "гулять", image: "Gulka_033", background: Palette.yellow),
    .init(text: "дубы", image: "Gulka_033", background: Palette.yellow),
    
    .init(text: "лупа", image: "Gulka_034", background: Palette.green),
    .init(text: "мелочь", image: "Gulka_034", background: Palette.green),
    .init(text: "жук", image: "Gulka_034", background: Palette.green),
]

let words: [Phrase] = {
    let allSklads = Array(Set(phrases.flatMap { phrase -> [String] in
        parseBySklads(text: phrase.text).map{$0.text}
    }))//.shuffled()
    
    var notePhrases = allSklads.chunked(into: 25).map { sklads -> Phrase in
        let text = sklads.joined()
        return .init(text: text, image: "", background: .black)
    }
    notePhrases.append(contentsOf: phrases)
    notePhrases.shuffle()
    return notePhrases
}()

//
//let phrases: [Phrase] = [
//    .init(text: "фу! кислый!", image:"limon", background: Palette.red),
//    .init(text: "ой! кто это?", image:"luzha", background: Palette.green),
//    .init(text: "какой красивый!", image:"lebed'", background: Palette.blue),
//    .init(text: "я похож на луну?", image:"luna", background: Palette.yellow),
//    .init(text: "наберу грибов", image:"les", background: .red),
//    .init(text: "вот ты где!", image:"", background: .red),
//    .init(text: "эй! поехали!", image:"", background: .red),
//    .init(text: "мамочки! горим!", image:"", background: .red),
//    .init(text: "я - молодец", image:"", background: .red),
//    .init(text: "баю-бай", image:"", background: .red),
//    .init(text: "еду к бабушке!", image:"", background: .red),
//    .init(text: "письмо деду морозу", image:"", background: .red),
//    .init(text: "нос замёрз", image:"", background: .red),
//    .init(text: "не весело", image:"", background: .red),
//    .init(text: "там моркова", image:"", background: .red),
//    .init(text: "я как папа!", image:"", background: .red),
//    .init(text: "не бойся, кот!", image:"", background: .red),
//    .init(text: "ба-бах", image:"", background: .red),
//    .init(text: "я и мой брат", image:"", background: .red),
//    .init(text: "рисую змею", image:"", background: .red),
//    .init(text: "принимаю соль", image:"", background: .red),
//    .init(text: "надо погромче!", image:"", background: .red),
//    .init(text: "закончился", image:"", background: .red),
//    .init(text: "отпусти", image:"", background: .red),
//    .init(text: "гав-гав!", image:"", background: .red),
//
//]
