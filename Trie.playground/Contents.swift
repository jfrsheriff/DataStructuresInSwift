
public class TrieNode<Element : Hashable> {
    
    var key : Element?
    weak var parent : TrieNode?
    
    var isLast : Bool = false
    var children : [Element : TrieNode] = [:]
    
    init (key : Element? ,
          parent : TrieNode? = nil,
          children : [Element : TrieNode] = [:] ,
          isLast : Bool = false){
        
        self.key = key
        self.parent = parent
        self.children = children
        self.isLast = isLast
    }
}


public class Trie<CollectionType : Collection & Hashable> where CollectionType.Element : Hashable {
    
    public typealias Node = TrieNode<CollectionType.Element>
    
    public var root : Node = Node(key: nil, parent: nil)
    
    public private(set) var allWordsCollection : Set<CollectionType> = []
    
    public var count: Int {
        allWordsCollection.count
    }
    
    public var isEmpty: Bool {
        allWordsCollection.isEmpty
    }
    
    public func insert(_ collection : CollectionType){
        var current = root
        for value in collection{
            guard let child = current.children[value] else{
                let node = TrieNode.init(key: value,parent: current)
                current.children[value] = node
                current = node
                continue
            }
            current = child
        }
        allWordsCollection.insert(collection)
        current.isLast = true
    }
    
    public func contains(_ collection : CollectionType) -> Bool{
        
        var current = root
        for value in collection {
            guard let child = current.children[value] else{
                return false
            }
            current = child
        }
        return current.isLast
    }
    
    public func hasPrefix(_ collection : CollectionType) -> Bool{
        var current = root
        for value in collection {
            guard let child = current.children[value] else{
                return false
            }
            current = child
        }
        return true
    }
    
    func remove(_ collection : CollectionType){
        var current = root
        for value in collection {
            guard let child = current.children[value] else{
                return
            }
            current = child
        }
        
        current.isLast = false
        allWordsCollection.remove(collection)
        
        while let parent = current.parent,
              let curKey = current.key,
              current.isLast == false,
              current.children.count == 0 {
            parent.children.removeValue(forKey: curKey)
            current = parent
        }
    }
}

public extension Trie where CollectionType: RangeReplaceableCollection {
    
    func collections(withPrefix prefix : CollectionType) -> [CollectionType] {
        var current = root
        for value in prefix {
            guard let child = current.children[value] else{
                return []
            }
            current = child
        }
        return getCollection(startingWith: prefix, fromNode: current)
    }
    
    private func getCollection(startingWith prefix : CollectionType,
                               fromNode node : Node) -> [CollectionType] {
        var retCollection : [CollectionType] = []
        
        if node.isLast {
            retCollection.append(prefix)
        }
        
        for childNode in node.children.values {
            guard let childKey = childNode.key else{
                continue
            }
            var prefix = prefix
            prefix.append(childKey)
            
            let newCollections = getCollection(startingWith: prefix,
                                               fromNode: childNode)
            retCollection.append(contentsOf: newCollections)
        }
        return retCollection
    }
}
