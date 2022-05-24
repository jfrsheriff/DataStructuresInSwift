

public enum Visit<T : Hashable >{
    case start
    case edge(Edge<T>)
}


public struct Dijkstra<T: Hashable & Comparable> {
    
    public typealias Graph = AdjacencyList<T>
    let graph : Graph
    
    public init(withGraph graph : Graph){
        self.graph = graph
    }
    
    private func route(to destination : Vertex<T>, with paths : [Vertex<T> : Visit<T>]) -> [Edge<T>]{
        
        var retEdges : [Edge<T>] = []
        var vertex = destination
        
        while let visit = paths[vertex], case .edge(let edge) = visit {
            retEdges = [edge] + retEdges
            vertex = edge.from
        }
        return retEdges
    }
    
    private func distance(to destination: Vertex<T>,
                          with paths: [Vertex<T> : Visit<T>]) -> Double {
        
        let paths = route(to : destination, with : paths)
        let retDistance = paths.reduce(0.0){$0 + ($1.weight ?? 0.0) }
        return retDistance
    }
    
    public func shortestPath(from start: Vertex<T>) -> [Vertex<T> : Visit<T>] {
        var paths : [Vertex<T> : Visit<T>] = [start : .start]
        
        var priorityQueue = PriorityQueue<Vertex<T>>.init { vertex1, vertex2 in
            self.distance(to: vertex1, with: paths) < self.distance(to: vertex2, with: paths)
        }
        
        priorityQueue.enque(start)
        
        while let curVertex = priorityQueue.deque(){
            let edges = graph.edges(from: curVertex)
            
            for edge in edges {
                guard let curEdgeWight = edge.weight else {continue}
                
                if paths[edge.to] == nil ||
                    self.distance(to: edge.from, with: paths) + curEdgeWight <
                    self.distance(to: edge.to, with: paths)  {
                    
                    priorityQueue.enque(edge.to)
                    paths[edge.to] = .edge(edge)
                }
            }
        }
        
        return paths
    }
    
    public func shortestPath(to destination : Vertex<T>,
                             with paths : [Vertex<T> : Visit<T>]) -> [Edge<T>] {
        return route(to : destination , with : paths)
    }
}



//: ![Graph](sampleGraph.png)


var graph = AdjacencyList<String>()

let a = graph.createVertex(value: "A")
let b = graph.createVertex(value: "B")
let c = graph.createVertex(value: "C")
let d = graph.createVertex(value: "D")
let e = graph.createVertex(value: "E")
let f = graph.createVertex(value: "F")
let g = graph.createVertex(value: "G")
let h = graph.createVertex(value: "H")

graph.addEdge(type: .directed, from: a, to: b, weight: 8)
graph.addEdge(type: .directed, from: a, to: f, weight: 9)
graph.addEdge(type: .directed, from: a, to: g, weight: 1)
graph.addEdge(type: .directed, from: b, to: f, weight: 3)
graph.addEdge(type: .directed, from: b, to: e, weight: 1)
graph.addEdge(type: .directed, from: f, to: a, weight: 2)
graph.addEdge(type: .directed, from: h, to: f, weight: 2)
graph.addEdge(type: .directed, from: h, to: g, weight: 5)
graph.addEdge(type: .directed, from: g, to: c, weight: 3)
graph.addEdge(type: .directed, from: c, to: e, weight: 1)
graph.addEdge(type: .directed, from: c, to: b, weight: 3)
graph.addEdge(type: .undirected, from: e, to: c, weight: 8)
graph.addEdge(type: .directed, from: e, to: b, weight: 1)
graph.addEdge(type: .directed, from: e, to: d, weight: 2)

let dijkstra = Dijkstra(withGraph: graph)
let pathsFromA = dijkstra.shortestPath(from: a)
let path = dijkstra.shortestPath(to: d, with: pathsFromA)
for edge in path {
    print("\(edge.from) --|\(edge.weight ?? 0.0)|--> \(edge.to)")
}

