
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

public struct AdjacencyList<Element : Hashable> : GraphProtocol{

    private var adjacencies : [Vertex<Element> : [Edge<Element>]] = [:]
    
    public var noOfVertices: Int{
        adjacencies.count
    }
    
    public var isEmpty: Bool{
        return adjacencies.isEmpty
    }
    
    public init(){}
    
    public mutating func createVertex(value: Element) -> Vertex<Element> {
        let vertex : Vertex<Element> = Vertex.init(withIndex: noOfVertices, value: value)
        adjacencies[vertex] = []
        return vertex
    }
    
    public mutating func addDirectedEdge(from: Vertex<Element>, to: Vertex<Element>, weight: Double?) {
        let edge = Edge.init(from: from, to: to, weight: weight)
        adjacencies[from,default: []].append(edge)
    }
    
    public mutating func addUnDirectedEdge(from: Vertex<Element>, to: Vertex<Element>, weight: Double?) {
        addDirectedEdge(from: from, to: to, weight: weight)
        addDirectedEdge(from: to, to: from, weight: weight)
    }
    
    public mutating func addEdge(type: EdgeType, from: Vertex<Element>, to: Vertex<Element>, weight: Double?) {
        switch type {
            case .directed:
                addDirectedEdge(from: from, to: to, weight: weight)
            case .undirected:
                addUnDirectedEdge(from: from, to: to, weight: weight)
        }
    }
    
    public func edges(from: Vertex<Element>) -> [Edge<Element>] {
        adjacencies[from] ?? []
    }
    
    public func weight(from: Vertex<Element>, to: Vertex<Element>) -> Double? {
        let edges = edges(from: from)
        let weight = edges.first {$0.to == to}?.weight
        return weight
    }
}

extension AdjacencyList : CustomStringConvertible{
    public var description: String {
        var retStr = ""
        
        for (vertex,edges) in adjacencies{
            
            var edgeStr = ""
            
            for (index,edge) in edges.enumerated() {
                if index == edges.count - 1{
                    edgeStr.append("\(edge.to)")
                }else{
                    edgeStr.append("\(edge.to), ")
                }
            }
            
            retStr.append("\(vertex) ---> [ \(edgeStr) ]\n")
            
        }
        return retStr
    }
}

