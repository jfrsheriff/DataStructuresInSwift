
public protocol UnionFindProtocol {
    associatedtype Element
    
    var noOfUniqueSets : Int {get}
    mutating func addNewSetWith(element : Element)
    mutating func setOf(_ element : Element) -> Int?
    mutating func areInSameSet(element1 : Element , element2 : Element) -> Bool
    mutating func unionSetContaining(element1 : Element, element2 : Element)
}


public struct UnionFind<T:Hashable> : UnionFindProtocol{
        
    private var indexDictionary : [T:Int] = [:]
    
    private var parent : [Int] = []
    private var size : [Int] = []
    
    public var noOfUniqueSets: Int {
        return Set(parent).count
    }
    
    public init() {}
    
    public mutating func addNewSetWith(element: T) {
        indexDictionary[element] = parent.count
        parent.append(parent.count)
        size.append(1)
    }
    
    public mutating func setOf(_ element : T) -> Int? {
        if let index = indexDictionary[element]{
            return setOfElementAt(index: index)
        }else{
            return nil
        }
    }
    
    private mutating func setOfElementAt(index : Int) -> Int{
        if index == parent[index] {
            return index
        }
        parent[index] = setOfElementAt(index: parent[index])
        return parent[index]
    }
    
    public mutating func areInSameSet(element1: T, element2: T) -> Bool {
        return setOf(element1) == setOf(element2) && setOf(element1) != nil
    }
    
    public mutating func unionSetContaining(element1: T, element2: T) {
        
        if let firstParent = setOf(element1) , let secondParent = setOf(element2){
            if firstParent != secondParent{

                if size[firstParent] < size[secondParent]{
                    parent[firstParent] = secondParent
                    size[secondParent] += size[firstParent]
                    size[firstParent] = 0

                }else{
                    parent[secondParent] = firstParent
                    size[firstParent] += size[secondParent]
                    size[secondParent] = 0

                }
            }
        }
    }
}

extension UnionFind : CustomStringConvertible{
    public var description: String{
        return "\n Parents : \(parent) \n Size Of Sets : \(size)"
    }
}

var uf = UnionFind<String>.init()

uf.addNewSetWith(element: "a")
uf.addNewSetWith(element: "b")
uf.addNewSetWith(element: "c")
uf.addNewSetWith(element: "d")
uf.addNewSetWith(element: "e")
uf.addNewSetWith(element: "f")
uf.addNewSetWith(element: "g")
uf.addNewSetWith(element: "h")
uf.addNewSetWith(element: "i")

print(uf)
uf.unionSetContaining(element1: "a", element2: "b")
print(uf)

