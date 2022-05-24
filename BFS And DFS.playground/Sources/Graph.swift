
public protocol GraphProtocol{
    associatedtype Element
    
    var noOfVertices : Int {get}
    var isEmpty : Bool {get}
    
    mutating func createVertex(value : Element) -> Vertex<Element>
    mutating func addDirectedEdge(from : Vertex<Element> , to : Vertex<Element>, weight : Double?)
    mutating func addUnDirectedEdge(from : Vertex<Element> , to : Vertex<Element>, weight : Double?)
    mutating func addEdge(type : EdgeType,
                          from : Vertex<Element> ,
                          to : Vertex<Element>,
                          weight : Double?)
    func edges(from : Vertex<Element>) -> [Edge<Element>]
    func weight(from : Vertex<Element>, to : Vertex<Element>) -> Double?
    
}

public protocol GraphTraversal {
    associatedtype Element
    func breadthFirstSearch(from sourceVertex : Vertex<Element> , currentVertexClosure: (Vertex<Element>) -> Void)
    func depthFirstSearch(from sourceVertex : Vertex<Element> , currentVertexClosure: (Vertex<Element>) -> Void)
}
