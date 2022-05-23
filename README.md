# Data Structures In Swift
Most Commonly Used Data Structures Implemented in Swift

<img src="https://user-images.githubusercontent.com/10083385/169782180-74b17a45-81bd-46b1-95c0-6f4700e6b970.png" width="500" height="500">


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
  
  
  **AVL Tree :**

Node Provides the following variables and methods, 

    func traversePreOrder(visit : (ValueType) -> Void )
    func traversePostOrder(visit : (ValueType) -> Void )
    func traverseInOrder(visit : (ValueType) -> Void )
    
AVL Provides the following variables and methods, 

    func insert(_ value : ElementType)
    func remove(_ value: ElementType) 
    func contains(value : ElementType) -> Bool
    
    
  **Heap :**
  
Provides the following variables and methods, 

    var peek : ElementType? {get}
    var count : Int { get }
    var isEmpty : Bool { get }
    
    var sort : (ElementType,ElementType) -> Bool {get set}
    
    mutating func add(_ element : ElementType)
    mutating func remove() -> ElementType?
