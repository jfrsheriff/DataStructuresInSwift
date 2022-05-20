
protocol QueueProtocol {
    
    associatedtype Element
    var isEmpty : Bool {get}
    var count : Int {get}
    
    mutating func enque(_ value: Element)
    mutating func deque() -> Element?
    func peek() -> Element?
}

public struct Queue<T> : QueueProtocol{
    
    private var source : [T] = []

    var isEmpty: Bool{
        source.isEmpty
    }
    var count: Int{
        source.count
    }
    
    mutating func enque(_ value : T) {
        source.append(value)
    }
    
    mutating func deque() -> T? {
        guard !isEmpty else {
            return nil
        }
        return source.removeFirst()
    }
    
    func peek() -> T? {
        source.first
    }
}

extension Queue : CustomStringConvertible{
    public var description: String{
        guard !isEmpty else{
            return "Empty Queue"
        }
        return source.reduce("") { partialResult, cur in
            if partialResult.isEmpty {
                return "\(cur)"
            }else{
                return partialResult + " <-- " + "\(cur)"
            }
        }
    }
}

extension Queue:ExpressibleByArrayLiteral{
    public init(arrayLiteral elements: T...) {
        self.source = elements
    }
}

var queue : Queue<Character> = Queue.init()
let startingValue = Int(("A" as UnicodeScalar).value) // 65

(0..<10).forEach { val in
    queue.enque(Character(UnicodeScalar(val + startingValue)!))
}
print(queue)
