import XCTest
@testable import App

class ParserTests: XCTestCase {
    func testParseBySkladWithoutAccent() throws {
        let mashina = parseBySklads(text: "МаШиНа")
        let mashinaStrings = mashina.map { $0.text }
        XCTAssertEqual(["ма", "ши", "на"], mashinaStrings)
        XCTAssertFalse(mashina[0].isAccent)
        XCTAssertFalse(mashina[1].isAccent)
        XCTAssertFalse(mashina[2].isAccent)
    }
    
    func testParseBySkladsWithAccent1() throws {
        let mashina = parseBySklads(text: "МаШи`На")
        let mashinaStrings = mashina.map { $0.text }
        XCTAssertEqual(["ма", "ши", "на"], mashinaStrings)
        XCTAssertFalse(mashina[0].isAccent)
        XCTAssertTrue(mashina[1].isAccent)
        XCTAssertFalse(mashina[2].isAccent)
    }
    
    func testParseBySkladsWithAccent2() throws {
        let mashina = parseBySklads(text: "у`дарение")
        let mashinaStrings = mashina.map { $0.text }
        XCTAssertEqual(["у", "да", "ре", "ни", "е"], mashinaStrings)
        XCTAssertTrue(mashina[0].isAccent)
        XCTAssertFalse(mashina[1].isAccent)
        XCTAssertFalse(mashina[2].isAccent)
        XCTAssertFalse(mashina[3].isAccent)
        XCTAssertFalse(mashina[4].isAccent)
    }
    
    func testParseBySkladsWithAccent3() throws {
        let mashina = parseBySklads(text: "папа`")
        let mashinaStrings = mashina.map { $0.text }
        XCTAssertEqual(["па", "па"], mashinaStrings)
        XCTAssertFalse(mashina[0].isAccent)
        XCTAssertTrue(mashina[1].isAccent)
    }
}
