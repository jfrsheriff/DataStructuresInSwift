import Foundation

public class Node<ValueType> {
    var value : ValueType
    var left : Node?
    var right : Node?
    
    var minNode: Node {
        left?.minNode ?? self
    }
    
    var maxNode: Node {
        right?.maxNode ?? self
    }
    
    var height = 0
    
    var leftHeight : Int{
        left?.height ?? -1
    }
    
    var rightHeight : Int{
        right?.height ?? -1
    }
    
    var balanceFactor : Int{
        leftHeight - rightHeight
    }
    
    init(value : ValueType, left : Node? = nil, right : Node? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }
}

extension Node: CustomStringConvertible {
    public var description: String {
        diagram(for: self)
    }
    
    private func diagram(for node: Node?,
                         _ top: String = "",
                         _ root: String = "",
                         _ bottom: String = "") -> String {
        
        guard let node = node else {
            return root + "nil\n"
        }
        if node.left == nil && node.right == nil {
            return root + "\(node.value)\n"
        }
        return diagram(for: node.right, top + " ", top + "┌──", top + "│ ") +
        root +
        "\(node.value)\n" +
        diagram(for: node.left, bottom + "│ ", bottom + "└──", bottom + " ")
    }
}

public protocol NodeTraversalProtocol {
    associatedtype ValueType
    func traversePreOrder(visit : (ValueType) -> Void )
    func traversePostOrder(visit : (ValueType) -> Void )
    func traverseInOrder(visit : (ValueType) -> Void )
}

extension Node : NodeTraversalProtocol {
    
    public func traversePreOrder(visit: (ValueType) -> Void) {
        visit(self.value)
        left?.traversePreOrder(visit: visit)
        right?.traversePreOrder(visit: visit)
    }
    
    public func traversePostOrder(visit: (ValueType) -> Void) {
        left?.traversePostOrder(visit: visit)
        right?.traversePostOrder(visit: visit)
        visit(self.value)
    }
    
    public func traverseInOrder(visit: (ValueType) -> Void) {
        left?.traverseInOrder(visit: visit)
        visit(self.value)
        right?.traverseInOrder(visit: visit)
    }
}

public struct AVLTree<ElementType : Comparable>{
    public private(set) var root : Node<ElementType>?
}

extension AVLTree : CustomStringConvertible{
    public var description: String{
        guard let root = root else{
            return "Empty Tree"
        }
        return String(describing: root)
    }
}

extension AVLTree{
    
    private func balanceTree( _ node : Node<ElementType> ) -> Node<ElementType> {
        
        switch node.balanceFactor{
            case 2 : // Left Subtree is Heavier
                if let left = node.left, left.balanceFactor == -1 {
                    return leftRightRotate(node)
                }else{
                    return rightRotate(node)
                }
                
            case -2 :  // Right Subtree is Heavier
                if let right = node.right, right.balanceFactor == 1 {
                    return rightLeftRotate(node)
                }else{
                    return leftRotate(node)
                }
                
            default :
                return node
        }
    }
    
    private func leftRotate (_ node : Node<ElementType>) -> Node<ElementType> {
        guard let pivot = node.right else {
            return node
        }
        node.right = pivot.left
        pivot.left = node
        
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        node.height = max(node.leftHeight, node.rightHeight) + 1
        
        return pivot
    }
    
    
    private func rightLeftRotate (_ node : Node<ElementType>) -> Node<ElementType> {
        guard let right = node.right else {
            return node
        }
        node.right = rightRotate(right)
        return leftRotate(node)
    }
    
    private func rightRotate (_ node : Node<ElementType>) -> Node<ElementType> {
        guard let pivot = node.left else {
            return node
        }
        
        node.left = pivot.right
        pivot.right = node
        
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        node.height = max(node.leftHeight, node.rightHeight) + 1
        
        return pivot
    }
    
    private func leftRightRotate (_ node : Node<ElementType>) -> Node<ElementType> {
        guard let left = node.left else{
            return node
        }
        
        node.left = leftRotate(left)
        return rightRotate(node)
    }
}

extension AVLTree{
    
    mutating func insert(_ value : ElementType){
        root = insert(from: root, value: value)
    }
    
    mutating func remove(_ value: ElementType) {
        root = remove(from : root, value: value)
    }
    
    private func remove(from node:Node<ElementType>?, value : ElementType ) -> Node<ElementType>? {
        guard let node = node else{
            return nil
        }
        
        if node.value == value{
            if node.left == nil && node.right == nil {
                return nil
            }
            if node.left == nil{
                return node.right
            }
            if node.right == nil{
                return node.left
            }
            if let minValueInRightSubtree = node.right?.minNode.value{
                node.value = minValueInRightSubtree
                node.right = remove(from: node.right, value: minValueInRightSubtree)
            }
        }
        if value < node.value{
            node.left = remove(from: node.left, value: value)
        }else{
            node.right = remove(from: node.right, value: value)
        }
        
        let balancedNode = balanceTree(node)
        balancedNode.height = max(node.leftHeight, node.rightHeight) + 1
        return balancedNode
    }
    
    private func insert(from node:Node<ElementType>? , value : ElementType ) -> Node<ElementType> {
        guard let node = node else{
            return Node(value: value)
        }
        
        if value < node.value{
            node.left = insert(from: node.left , value: value)
        }else {
            node.right = insert(from: node.right , value: value)
        }
        let balancedNode = balanceTree(node)
        balancedNode.height = max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
        return balancedNode
    }
}

extension AVLTree {
    
    func contains(value : ElementType) -> Bool{
        return contains(in: root, value: value)
    }
    
    private func contains(in node : Node<ElementType>? , value : ElementType ) -> Bool{
        guard let node = node else {
            return false
        }
        
        if node.value == value {
            return true
        }
        if value < node.value{
            return contains(in: node.left, value: value)
        }else{
            return contains(in: node.right, value: value)
        }
    }
}


var tree = AVLTree<Int>.init()
tree.insert(1)
tree.insert(2)
tree.insert(3)
tree.insert(4)
tree.insert(5)
tree.insert(6)
tree.insert(7)
tree.insert(8)
tree.insert(9)
tree.insert(10)
tree.insert(11)
tree.insert(12)
tree.insert(13)

print(tree)
print("-------------")
print("Pre order")
tree.root?.traversePreOrder(visit: { val in
    print(val,terminator: " ")
})
print("\n-------------")
print("Post Order")
tree.root?.traversePostOrder(visit: { val in
    print(val,terminator: " ")
})
print("\n-------------")
print("In Order")
tree.root?.traverseInOrder(visit: { val in
    print(val,terminator: " ")
})

print("\n\n-------------")
print("Removing 8")
tree.remove(8)
print(tree)
print("\n\n-------------")
print("Inserting 20")
tree.insert(20)
print( tree)


