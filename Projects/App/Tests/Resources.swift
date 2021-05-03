import XCTest
@testable import App

class Resources: XCTestCase {
    func testForMissedSoundFiles() throws {
        let sklads = getAllSoundFilenames(phrases: phrases)
        let missed = sklads.compactMap { sklad -> String? in
            let resource = Bundle.main.path(forResource: sklad, ofType: "caf")
            if resource == nil {
                return sklad
            }
            return nil
        }
        
        missed.forEach { miss in
            print(miss)
        }
        
        XCTAssertTrue(missed.isEmpty, "Found missed sound files for \(missed.count) sklads: \(missed)")
    }
    
    func getAllSoundFilenames(phrases: [Phrase]) -> [SoundFilename] {
        let set = phrases.reduce(Set<String>()) { set, phrase -> Set<String> in
            let array = parseBySklads(text: phrase.text)
            let strings = array.map { part -> String in
                part.soundFilename
            }
            
            let add = Set(strings)
            return set.union(add)
        }
        
        let sorted = Array(set).sorted()
        
        return sorted
    }

}
