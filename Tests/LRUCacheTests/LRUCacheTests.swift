import XCTest
@testable import LRUCache

final class LRUCacheTests: XCTestCase {

    func testLRUEliminate() {
        let cache = LRUCache<Int, Int>(capacity: 3)
        cache[1] = 1
        cache[2] = 2
        cache[3] = 3
        XCTAssertEqual(cache.count, 2)
        XCTAssertNil(cache[1])
        XCTAssertEqual(cache[2], 2)
        cache[4] = 4
        XCTAssertEqual(cache.count, 2)
        XCTAssertNil(cache[3])
    }

    func testEliminateSize() {
        let cache = LRUCache<Int, Int>(capacity: 5, eliminateSize: 2)
        for i in 0..<5 {
            XCTAssertNil(cache[i])
            cache[i] = i
        }
        XCTAssertEqual(cache.count, 3)
    }

    static var allTests = [
        ("testLRUEliminate", testLRUEliminate),
        ("testEliminateSize", testEliminateSize),
    ]
}
