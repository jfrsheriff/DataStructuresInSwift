# DataStructuresInSwift
Most Commonly Used Data Structures Implemented in Swift

**Queue :**

Provides the following variables and methods, 

    var isEmpty : Bool {get}
    var count : Int {get}
    
    mutating func enque(_ value: Element)
    mutating func deque() -> Element?
    func peek() -> Element?
    
    
    
**Stack :**

Provides the following variables and methods, 

    var isEmpty : Bool {get}
    var count : Int {get}
    
    mutating func push(_ value : Element)
    mutating func pop() -> Element?
    func peek() -> Element?


**Trie :** 

Provides the following variables and methods, 

    public private(set) var allWordsCollection : Set<CollectionType> 
    public var count: Int
    public var isEmpty: Bool
    
    public func insert(_ collection : CollectionType)
    public func contains(_ collection : CollectionType) -> Bool
    public func hasPrefix(_ collection : CollectionType) -> Bool
    func remove(_ collection : CollectionType) 
    func collections(withPrefix prefix : CollectionType) -> [CollectionType] 
  
  
**Singly Linked List :**

Provides the following variables and methods, 

    var isEmpty : Bool
    public private(set) var count : Int = 0

    func prepend( _ value : Element)
    func append( _ value : Element)
    func insert( _ value : Element, atIndex index : Int)
    func removeFirst() -> Node<Element>?
    func removeLast() -> Node<Element>?
    func remove(at index: Int) -> Node<Element>?
  
