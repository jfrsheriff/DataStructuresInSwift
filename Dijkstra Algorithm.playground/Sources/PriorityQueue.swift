

public protocol HeapProtocol {
    
    associatedtype ElementType
    var peek : ElementType? {get}
    var count : Int { get }
    var isEmpty : Bool { get }
    
    var sort : (ElementType,ElementType) -> Bool {get set}
    
    mutating func add(_ element : ElementType)
    mutating func remove() -> ElementType?
    
}


public struct Heap <Element : Comparable>: HeapProtocol{
    
    private var source : [Element] = []
    
    public var peek: Element? {
        if isEmpty{
            return nil
        }
        return source.first
    }
    
    public var count: Int{
        source.count
    }
    public var isEmpty: Bool{
        source.isEmpty
    }
    
    public var sort: (Element, Element) -> Bool
    
    init(withSort sort: @escaping (Element , Element) -> Bool , elements : [Element] = [] ){
        self.sort = sort
        self.source = elements
        
        guard !elements.isEmpty else{
            return
        }
        
        for index in stride(from: elements.count/2 - 1, through: 0, by: -1){
            heapifyDown(from: index)
        }
    }
    
    private func parent(of index : Int) -> Int {
        return (index - 1 ) / 2
    }
    
    private func leftChild(of index : Int) -> Int {
        return 2*index + 1
    }
    
    private func rightChild(of index : Int) -> Int {
        return 2*index + 2
    }
    
    public mutating func add(_ element: Element) {
        source.append(element)
        heapifyUp(from: count-1)
    }
    
    public mutating func remove() -> Element? {
        guard !isEmpty else{
            return nil
        }
        source.swapAt(0, count-1)
        defer{
            heapifyDown(from: 0)
        }
        return source.removeLast()
    }
    
    private mutating func heapifyUp(from index : Int){
        var curIndex = index
        var parentIndex = parent(of: curIndex)
        while parentIndex >= 0 {
            if sort(source[curIndex],source[parentIndex]) {
                source.swapAt(curIndex, parentIndex)
                curIndex = parentIndex
                parentIndex = parent(of: curIndex)
            }else{
                break
            }
        }
    }
    
    private mutating func heapifyDown(from index : Int){
        var curIndex = index
        while curIndex <= count - 1{
            let leftChildIndex = leftChild(of: curIndex)
            let rightChildIndex = rightChild(of: curIndex)
            
            var destinationIndex = curIndex
            
            if leftChildIndex <= count - 1 {
                if sort(source[leftChildIndex],source[destinationIndex]) {
                    destinationIndex = leftChildIndex
                }
            }
            
            if rightChildIndex <= count - 1 {
                if sort(source[rightChildIndex],source[destinationIndex]) {
                    destinationIndex = rightChildIndex
                }
            }
            
            if destinationIndex == curIndex{
                break
            }else{
                source.swapAt(curIndex, destinationIndex)
                curIndex = destinationIndex
            }
        }
    }
}

extension Heap : CustomStringConvertible{
    public var description: String{
        diagram(for: 0)
    }
    
    private func diagram(for index: Int,
                             _ top: String = "",
                             _ root: String = "",
                            _ bottom: String = "") -> String {
        
        guard index <= count-1 else{
            return root + "nil\n"
        }
        
        if leftChild(of: index) >= count && rightChild(of: index) >= count {
            return root + "\(source[index])\n"
        }
        
        return diagram(for: rightChild(of: index), top + " ", top + "┌──", top + "│ ") +
        root + "\(source[index])\n" +
        diagram(for: leftChild(of: index), bottom + "│ ", bottom + "└──", bottom + " ")
    }
}

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

    public init (withSort sort: @escaping (Element,Element) -> Bool, elements : [Element] = [] ){
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
