import Foundation

public class Node<Element> {
    var value: Element
    var next: Node?
    
    init(with value : Element, next : Node? = nil) {
        self.value = value
        self.next = next
    }
}

extension Node: CustomStringConvertible{
    public var description: String{
        guard let next = self.next else {
            return "\(String(describing: value))"
        }
        return "\(value) -> \(String(describing: next))"
    }
}

class LinkedList<Element> {
    
    var head : Node<Element>? = nil
    var tail : Node<Element>? = nil
    
    var isEmpty : Bool{
        head == nil
    }
    
    public private(set) var count : Int = 0
    
    // O(1)
    func prepend( _ value : Element) {
        head = Node(with: value, next: head)
        if tail == nil{
            tail = head
        }
        count += 1
    }
    
    // O(1)
    func append( _ value : Element) {
        let node = Node(with: value, next: nil)
        if head == nil{
            head = node
            tail = node
        }else{
            tail?.next = node
            tail = node
        }
        count += 1
    }
    
    // O(n)
    func insert( _ value : Element, atIndex index : Int) {
        if index <= 0 {
            prepend(value)
            return
        }
        
        if index >= count {
            append(value)
            return
        }
        
        var cur : Node? = head
        var i = 0
        
        while i < index-1{
            cur = cur?.next
            i += 1
        }
        let node = Node(with: value, next: cur?.next)
        cur?.next = node
        count += 1
    }
    
    // O(1)
    @discardableResult
    func removeFirst() -> Node<Element>? {
        guard count > 0 else {
            return nil
        }
        let retNode = head
        head = head?.next
        count -= 1
        
        retNode?.next = nil
        return retNode
    }
    
    // O(n)
    @discardableResult
    func removeLast() -> Node<Element>? {
        guard count > 0 else {
            return nil
        }
        var cur : Node<Element>? = head
        var prev : Node<Element>? = nil
        
        while let _ = cur?.next {
            prev = cur
            cur = cur?.next
        }
        let retNode = tail
        prev?.next = nil
        tail = prev
        count -= 1
        
        return retNode
    }
    
    // O(n)
    @discardableResult
    func remove(at index: Int) -> Node<Element>? {
        
        if index == 0 {
            return removeFirst()
        }
        
        if index == count - 1 {
            return removeLast()
        }
        
        guard index > 0 , index < count - 1 else {
            return nil
        }
        
        var cur : Node? = head
        var i = 0
        
        while i < index-1{
            cur = cur?.next
            i += 1
        }
        
        let retNode = cur?.next
        cur?.next = cur?.next?.next
        count -= 1
        retNode?.next = nil
        
        return retNode
    }
    
}

extension LinkedList : CustomStringConvertible{
    var description: String{
        guard let head = head else {
            return "Empty Linked List"
        }
        return "\(head)"
    }
}

extension LinkedList : Sequence {
    
    class LLIterator<Element> : IteratorProtocol{
        var head : Node<Element>?
        init(head :  Node<Element>? = nil){
            self.head = head
        }
        
        func next() -> Element? {
            defer{
                head = head?.next
            }
            return head?.value ?? nil
        }
    }
    
    func makeIterator() -> some IteratorProtocol {
        let iterator = LLIterator(head: head)
        return iterator
    }
}


var list = LinkedList<Int>()
list.append(1)
list.append(2)
list.append(3)
list.append(4)
list.append(5)

list.prepend(0)
list.prepend(-1)
list.prepend(-2)
list.prepend(-3)
list.prepend(-4)

print(list)
