
public enum EdgeType {
    case directed, undirected
}

public struct Edge<Element>{
    public var from : Vertex<Element>
    public var to : Vertex<Element>
    public var weight : Double?
    
    public init(from : Vertex<Element> , to : Vertex<Element> , weight : Double? = nil ) {
        self.from = from
        self.to = to
        self.weight = weight
    }
}

