import Foundation

public struct AdjacencyList<Element : Hashable> : GraphProtocol{

    private var adjacencies : [Vertex<Element> : [Edge<Element>]] = [:]
    
    public var noOfVertices: Int{
        adjacencies.count
    }
    
    public var isEmpty: Bool{
        return adjacencies.isEmpty
    }
    
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

extension AdjacencyList : GraphTraversal{
    public func breadthFirstSearch(from sourceVertex : Vertex<Element> , currentVertexClosure: (Vertex<Element>) -> Void) {
        
        var queue : Queue<Vertex<Element>> = Queue.init()
        queue.enque(sourceVertex)

        var visitedVertex : Set<Vertex<Element>> = [sourceVertex]
    
        while let curVertex = queue.deque() {
            let edges = edges(from:curVertex)
    
            currentVertexClosure(curVertex)
            
            for edge in edges {
                let nextVertex = edge.to
                if !visitedVertex.contains(nextVertex){
                    visitedVertex.insert(nextVertex)
                    queue.enque(nextVertex)
                }
            }
        }
    
    }
    
    public func depthFirstSearch(from sourceVertex : Vertex<Element> , currentVertexClosure: (Vertex<Element>) -> Void) {
        var visitedVertex : Set<Vertex<Element>> = [sourceVertex]
        dfs(from : sourceVertex , currentVertexClosure: currentVertexClosure , visited : &visitedVertex )
    }
    
    
    private func dfs (from sourceVertex : Vertex<Element> , currentVertexClosure: (Vertex<Element>) -> Void, visited : inout Set<Vertex<Element>> ) {
        
        currentVertexClosure(sourceVertex)
        
        let edges = edges(from: sourceVertex)
        for edge in edges{
            let nextVertex = edge.to
            if !visited.contains(nextVertex){
                visited.insert(nextVertex)
                dfs (from : nextVertex ,
                     currentVertexClosure: currentVertexClosure ,
                     visited : &visited )
            }
        }
    }
}


//: ![Graph](graph.png)


var graph = AdjacencyList<String>()

let singapore = graph.createVertex(value: "Singapore")
let tokyo = graph.createVertex(value: "Tokyo")
let hongKong = graph.createVertex(value: "Hong Kong")
let detroit = graph.createVertex(value: "Detroit")
let sanFrancisco = graph.createVertex(value: "San Francisco")
let washingtonDC = graph.createVertex(value: "Washington DC")
let austinTexas = graph.createVertex(value: "Austin Texas")
let seattle = graph.createVertex(value: "Seattle")

graph.addEdge(type: .undirected, from: singapore, to: hongKong, weight:300)
graph.addEdge(type: .undirected, from: singapore, to: tokyo, weight: 500)
graph.addEdge(type: .undirected, from: hongKong, to: tokyo, weight: 250)
graph.addEdge(type: .undirected, from: tokyo, to: detroit, weight: 450)
graph.addEdge(type: .undirected, from: tokyo, to: washingtonDC, weight:300)
graph.addEdge(type: .undirected, from: hongKong, to: sanFrancisco, weight:600)
graph.addEdge(type: .undirected, from: detroit, to: austinTexas, weight:50)
graph.addEdge(type: .undirected, from: austinTexas, to: washingtonDC,weight: 292)
graph.addEdge(type: .undirected, from: sanFrancisco, to: washingtonDC,weight: 337)
graph.addEdge(type: .undirected, from: washingtonDC, to: seattle, weight:277)
graph.addEdge(type: .undirected, from: sanFrancisco, to: seattle, weight:218)
graph.addEdge(type: .undirected, from: austinTexas, to: sanFrancisco,weight: 297)
print(graph)


print("-----BFS-----")
graph.breadthFirstSearch(from: tokyo) { cur in
    print(cur)
}
print("\n")
print("-----DFS-----" )
graph.depthFirstSearch(from: tokyo) { cur in
    print(cur)
}




