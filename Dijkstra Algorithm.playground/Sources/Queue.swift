
private protocol QueueProtocol {
    
    associatedtype Element
    var isEmpty : Bool {get}
    var count : Int {get}
    
    mutating func enque(_ value: Element)
    mutating func deque() -> Element?
    func peek() -> Element?
}

public struct Queue<T> : QueueProtocol,Sequence,IteratorProtocol{
   
    public typealias Element = T

    private var source : [T] = []

    public var isEmpty: Bool{
        source.isEmpty
    }
    public var count: Int{
        source.count
    }
    
    private var index = 0
    
    public mutating func next() -> T? {
        guard index < count else {
            return nil
        }
        defer{
            index += 1
        }
        return source[index]
    }
    
    public mutating func enque(_ value : T) {
        source.append(value)
    }
    
    public mutating func deque() -> T? {
        guard !isEmpty else {
            return nil
        }
        return source.removeFirst()
    }
    
    public func peek() -> T? {
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

