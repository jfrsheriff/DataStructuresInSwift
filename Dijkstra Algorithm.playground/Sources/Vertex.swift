
public struct Vertex<Element>{
    public var index : Int
    public var value : Element
    public init(withIndex index : Int, value : Element) {
        self.index = index
        self.value = value
    }
}

extension Vertex : Hashable where Element : Hashable{}
extension Vertex : Equatable where Element : Equatable{}

extension Vertex : Comparable where Element : Comparable{
    
    public static func < (lhs: Vertex<Element>, rhs: Vertex<Element>) -> Bool {
        lhs.value < rhs.value
    }
}

extension Vertex : CustomStringConvertible{
    public var description: String {
        "\(value)"
    }
}


