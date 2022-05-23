
import Foundation

public protocol PriorityQueueProtocol {
    associatedtype Element : Comparable
    
    var isEmpty : Bool {get}
    var count : Int {get}
    var peek : Element? {get}
    
    mutating func enque( _ element : Element)
    mutating func deque() -> Element?
}

public struct PriorityQueue<Element : Comparable> : PriorityQueueProtocol {
    
    private var sourceHeap : Heap<Element>

    public var isEmpty: Bool{
        sourceHeap.isEmpty
    }
    
    public var count: Int{
        sourceHeap.count
    }
    
    public var peek: Element?{
        sourceHeap.peek
    }

    init (withSort sort: @escaping (Element,Element) -> Bool, elements : [Element] = [] ){
        sourceHeap = Heap<Element>.init(withSort: sort, elements: elements)
    }
    
    public mutating func enque(_ element: Element) {
        sourceHeap.add(element)
    }
    
    public mutating func deque() -> Element? {
        sourceHeap.remove()
    }
}
extension PriorityQueue : CustomStringConvertible{
    public var description: String {
        if isEmpty {
            return "Empty Priority Queue"
        }
        return "\(sourceHeap)"
    }
    
    
}


var priorityQueue = PriorityQueue(withSort: <, elements: [13,2,30,6,94,1,2,34,72])
print(priorityQueue)
while !priorityQueue.isEmpty {
  print(priorityQueue.deque()!)
}


