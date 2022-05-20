
private protocol StackProtocol {
    associatedtype Element
    
    var isEmpty : Bool {get}
    var count : Int {get}
    
    mutating func push(_ value : Element)
    mutating func pop() -> Element?
    func peek() -> Element?
}

public struct Stack<T> : StackProtocol,Sequence,IteratorProtocol {

    public typealias Element = T

    private var iteratorIndex = 0
    
    public mutating func next() -> T? {
        if iteratorIndex == count{
            return nil
        }
        defer{
            iteratorIndex += 1
        }
        return source[count-iteratorIndex-1]
    }
    
    private var source : [T] = []
    
    var isEmpty: Bool{
        source.isEmpty
    }
    
    var count: Int{
        source.count
    }
    
    mutating func push(_ value: T) {
        source.append(value)
    }
    
    mutating func pop() -> T?{
        guard !self.isEmpty else{
            return nil
        }
        return source.removeLast()
    }
    
    func peek() -> T?{
        guard !self.isEmpty else{
            return nil
        }
        return source.last
    }
}

extension Stack : ExpressibleByArrayLiteral{
    public init(arrayLiteral elements: T...) {
        source = elements
    }
}

extension Stack:CustomStringConvertible {
    public var description: String {
        guard !source.isEmpty else{
            return "Empty Stack"
        }
        return source.reduce("") { prev, cur in
            if prev.isEmpty{
                return "\(cur)"
            }else{
                return "\(prev) --> \(cur)"
            }
        }
    }
}

var stack : Stack<Character> = []

let startingValue = Int(("A" as UnicodeScalar).value)
(0..<10).forEach { val in
    let charValue = val + startingValue
    let unicodeVal = UnicodeScalar(charValue)!
    let char : Character = Character(unicodeVal)
    stack.push(char)
}

print(stack)

