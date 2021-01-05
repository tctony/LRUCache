import Foundation
import DoublyLinkedList

public class LRUCache<Key, Value> where Key: Hashable {

    private let capacity: Int
    private let eliminateSize: Int

    private struct KVPair {
        let key: Key
        var value: Value
    }

    private var cache = [Key: DoublyLinkedList<KVPair>.Node]()
    private var list = DoublyLinkedList<KVPair>()

    public init(capacity: Int, eliminateSize: Int = 1) {
        precondition(capacity > 0 && eliminateSize > 0 && eliminateSize <= capacity)

        self.capacity = capacity
        self.eliminateSize = eliminateSize
    }

    public var count: Int {
        return self.cache.count
    }

    public subscript(key: Key) -> Value? {
        get {
            if let node = self.cache[key] {
                self.list.remove(node)
                self.list.insert(node)
                return node.value.value
            } else {
                return nil
            }
        }
        set(newValue) {
            var node = self.cache[key]

            if newValue != nil {
                if node != nil {
                    node!.value.value = newValue!
                    self.list.remove(node!)
                    self.list.insert(node!)
                } else {
                    node = .init(value: KVPair(key: key, value: newValue!))
                    self.cache[key] = node!
                    self.list.insert(node!)

                    if self.count >= self.capacity {
                        while self.count > self.capacity - self.eliminateSize {
                            if let tail = self.list.removeTail() {
                                self.cache[tail.value.key] = nil
                            } else {
                                break
                            }
                        }
                    }
                }

            } else {
                if node != nil {
                    self.cache[key] = nil
                    self.list.remove(node!)
                }
            }
        }
    }
}
