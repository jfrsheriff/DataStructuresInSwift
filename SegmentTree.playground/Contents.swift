
import Foundation

public class SegmentTree<T> {
    
    private var value: T
    private var function: (T, T) -> T
    private var leftBound: Int
    private var rightBound: Int
    private var leftChild: SegmentTree<T>?
    private var rightChild: SegmentTree<T>?
    
    public init(array: [T], leftBound: Int, rightBound: Int, function: @escaping (T, T) -> T) {
        self.leftBound = leftBound
        self.rightBound = rightBound
        self.function = function
        
        if leftBound == rightBound {
            value = array[leftBound]
        } else {
            let middle = (leftBound + rightBound) / 2
            leftChild = SegmentTree<T>(array: array, leftBound: leftBound, rightBound: middle, function: function)
            rightChild = SegmentTree<T>(array: array, leftBound: middle+1, rightBound: rightBound, function: function)
            value = function(leftChild!.value, rightChild!.value)
        }
    }
    
    
    public convenience init(array: [T], function: @escaping (T, T) -> T) {
        self.init(array: array, leftBound: 0, rightBound: array.count-1, function: function)
    }
    
    
    public func query(leftBound: Int, rightBound: Int) -> T {
        if self.leftBound == leftBound && self.rightBound == rightBound {
            return self.value
        }
        
        guard let leftChild = leftChild else { fatalError("leftChild should not be nil") }
        guard let rightChild = rightChild else { fatalError("rightChild should not be nil") }
        
        if leftChild.rightBound < leftBound {
            return rightChild.query(leftBound: leftBound, rightBound: rightBound)
        } else if rightChild.leftBound > rightBound {
            return leftChild.query(leftBound: leftBound, rightBound: rightBound)
        } else {
            let leftResult = leftChild.query(leftBound: leftBound, rightBound: leftChild.rightBound)
            let rightResult = rightChild.query(leftBound:rightChild.leftBound, rightBound: rightBound)
            return function(leftResult, rightResult)
        }
    }
    
    public func replaceItem(at index: Int, withItem item: T) {
        if leftBound == rightBound {
            value = item
        } else if let leftChild = leftChild, let rightChild = rightChild {
            if leftChild.rightBound >= index {
                leftChild.replaceItem(at: index, withItem: item)
            } else {
                rightChild.replaceItem(at: index, withItem: item)
            }
            value = function(leftChild.value, rightChild.value)
        }
    }
}

extension SegmentTree : CustomStringConvertible{
    
    public var description: String {
        diagram(for: self)
    }
    
    private func diagram(for node: SegmentTree?,
                         _ top: String = "",
                         _ root: String = "",
                         _ bottom: String = "") -> String {
        
        guard let node = node else {
            return root + "nil\n"
        }
        if node.leftChild == nil && node.rightChild == nil {
            return root + "\(node.value)\n"
        }
        return diagram(for: node.rightChild, top + " ", top + "┌──", top + "│ ") +
        root +
        "\(node.value)\n" +
        diagram(for: node.leftChild, bottom + "│ ", bottom + "└──", bottom + " ")
    }
    
}



let array = [1, 2, 3, 4]

let sumSegmentTree = SegmentTree(array: array,leftBound: 0, rightBound: array.count-1  , function: +)

sumSegmentTree.query(leftBound: 0, rightBound: 3)  // 1 + 2 + 3 + 4 = 10
sumSegmentTree.query(leftBound: 1, rightBound: 2)  // 2 + 3 = 5
sumSegmentTree.query(leftBound: 0, rightBound: 0)  // just 1
sumSegmentTree.query(leftBound: 3, rightBound: 3)  // just 4

print(sumSegmentTree)


