import XCTest
import SnapshotTesting
@testable import App

class Snapshots: XCTestCase {
    
    func test_iPhone65_Dym() {
        let view = PageView()
        view.render(props: Self.dymProps)
        view.frame = Self.iPhone65
        assertSnapshot(matching: view, as: .image)
    }
    
    func test_iPhone65_Luna() {
        let view = PageView()
        view.render(props: Self.lunaProps)
        view.frame = Self.iPhone65
        assertSnapshot(matching: view, as: .image)
    }
    
    func test_iPhone65_Kaktus() {
        let view = PageView()
        view.render(props: Self.kaktusProps)
        view.frame = Self.iPhone65
        assertSnapshot(matching: view, as: .image)
    }
    
    func test_iPhone55_Dym() {
        let view = PageView()
        view.render(props: Self.dymProps)
        view.frame = Self.iPhone55
        assertSnapshot(matching: view, as: .image)
    }
    
    func test_iPhone55_Luna() {
        let view = PageView()
        view.render(props: Self.lunaProps)
        view.frame = Self.iPhone55
        assertSnapshot(matching: view, as: .image)
    }
    
    func test_iPhone55_Kaktus() {
        let view = PageView()
        view.render(props: Self.kaktusProps)
        view.frame = Self.iPhone55
        assertSnapshot(matching: view, as: .image)
    }
    
    func test_iPad_Dym() {
        let view = PageView()
        view.render(props: Self.dymProps)
        view.frame = Self.iPadPro3
        assertSnapshot(matching: view, as: .image)
    }
    
    func test_iPad_Luna() {
        let view = PageView()
        view.render(props: Self.lunaProps)
        view.frame = Self.iPadPro3
        assertSnapshot(matching: view, as: .image)
    }
    
    func test_iPad_Kaktus() {
        let view = PageView()
        view.render(props: Self.kaktusProps)
        view.frame = Self.iPadPro3
        assertSnapshot(matching: view, as: .image)
    }
}

extension Snapshots {
    
    static let scale = UIScreen.main.scale
    
    static let iPhone65 = CGRect(x: 0, y: 0, width: 1284/scale, height: 2778/scale)
    static let iPhone55 = CGRect(x: 0, y: 0, width: 1242/scale, height: 2208/scale)
    static let iPadPro3 = CGRect(x: 0, y: 0, width: 2048/scale, height: 2732/scale)
    
    static let iPhone65SafeArea: UIEdgeInsets = .init(top: 44, left: 0, bottom: 34, right: 0)
    static let iPhone55SafeArea: UIEdgeInsets = .init(top: 20, left: 0, bottom: 0, right: 0)
    static let iPadPro3SafeArea: UIEdgeInsets = .init(top: 20, left: 0, bottom: 20, right: 0)
    
    static let dymProps = PageView.Props(
        index: 0,
        image: "Gulka_049",
        text: "Дым",
        currentStringPart: nil,
        keyboard: .init(keys: [
            .init(text: "ды", onTap: .empty),
            .init(text: "м", onTap: .empty),
        ]),
        background: Palette.green
    )
    
    static let lunaProps = PageView.Props(
        index: 0,
        image: "Gulka_012",
        text: "Дым",
        currentStringPart: nil,
        keyboard: .init(keys: [
            .init(text: "лу", onTap: .empty),
            .init(text: "на", onTap: .empty),
        ]),
        background: Palette.yellow
    )
    
    static let kaktusProps = PageView.Props(
        index: 0,
        image: "Gulka_052",
        text: "Кактус",
        currentStringPart: nil,
        keyboard: .init(keys: [
            .init(text: "ка", onTap: .empty),
            .init(text: "к", onTap: .empty),
            .init(text: "ту", onTap: .empty),
            .init(text: "с", onTap: .empty),
        ]),
        background: Palette.blue
    )
    
}
