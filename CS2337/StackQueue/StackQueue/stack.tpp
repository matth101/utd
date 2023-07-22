// Template class Stack based on a singly linked list
template <class Type>
class StackListClass {
private:

  // The structure describing the node
  template <class Type>
  struct NodeStackStruct {
    Type data;
    NodeStackStruct<Type>* nextNodePtr;
  };

  NodeStackStruct<Type>* stackTopNodePtr = nullptr;         // stack top pointer
   unsigned               stackNodeCount = 0;               // stack node count

   /*
Name: AllocateNodeSafeMemory(void)
Function Purpose : add item to the queue
Function Design:   allocates new memory for in a dynamic memory
                   if not sucessful memory allocation, states the reason and exits
Inputs:            void
Outputs:           NodeStackStruct<Type>*
*/
  NodeStackStruct<Type>* allocateNodeSafeMemory(void) {
    NodeStackStruct<Type>* newMemoryPtr;
    try {
        newMemoryPtr = new NodeStackStruct<Type>;
        return newMemoryPtr;
    } 
    catch(bad_alloc e) {
        std::cout << e.what() << endl;
        exit(EXIT_FAILURE);
    } 
  }

  /*
Name: CopyToStackFrom
Function Purpose : Copy to a newly formed queue 
Function Design:   allocates new memory for a new array to contain a copy of the queue
Inputs:            const StackListClass& srcStackListRef  -source stack
Outputs:           void
                   const StackListClass& targetStackListRef  - target stack
*/
  void copyToStackFrom(const StackListClass& srcStackListRef) {
      NodeStackStruct<Type>* srcTransversePtr = srcStackListRef.stackTopNodePtr;
      NodeStackStruct<Type>* targetNodePtr;
      NodeStackStruct<Type>* targetTrailer = nullptr;

      stackTopNodePtr = targetTrailer;
      stackNodeCount = 0;
      while (srcTransversePtr != nullptr) { // begin passing through source; if you pass in a nullptr, this while protects it
          targetNodePtr = allocateNodeSafeMemory(); // build the copied element
          targetNodePtr->data = srcTransversePtr->data;
          targetNodePtr->nextNodePtr = nullptr;

          if (stackTopNodePtr == nullptr) { // if this is an empty list (i.e. the first element)
              stackTopNodePtr = targetNodePtr; // new element is the top
              targetTrailer = targetNodePtr;
          }
          else { // if list isn't empty
              targetTrailer->nextNodePtr = targetNodePtr; 
              targetTrailer = targetTrailer->nextNodePtr; // make trailer point to new element 
          }

          srcTransversePtr = srcTransversePtr->nextNodePtr;
          stackNodeCount++;
      }
  }

public:
  // default constructor
  StackListClass() { stackTopNodePtr = nullptr; }

  // copy constructor
  StackListClass(const StackListClass& stackListRef) {
      copyToStackFrom(stackListRef);
  }

/*
Name: Push
Function Purpose : add passed item to the stack top
Function Design:   allocates new memory for new stack top
                   use AllocateNodeSafeMemory()
                   adjust stack node count
Inputs:            Type data- the item to put on the stack top 
Outputs:           void
*/
  void Push(Type data) {
    NodeStackStruct<Type> *newNode = allocateNodeSafeMemory();
    newNode->data = data;
    if (getstackNodeCount() == 0) {
        newNode->nextNodePtr = nullptr;
    }
    else {
        newNode->nextNodePtr = stackTopNodePtr;
    }
    stackTopNodePtr = newNode;
    stackNodeCount++;
  }

/*
Name: Pop()
Function Purpose : take item out of stack top
Function Design:   deallocates old sstack top
Inputs:            none
Outputs:           TYPE - the removed item from the top of the stack
*/
  Type Pop() {
      if (stackTopNodePtr == nullptr) {
          return 0;
      }

      NodeStackStruct<Type>* prevStackTopPtr;
      Type data;
      data = stackTopNodePtr->data;
      prevStackTopPtr = stackTopNodePtr;
      stackTopNodePtr = stackTopNodePtr->nextNodePtr;
      delete prevStackTopPtr;

      stackNodeCount--;
      return data;
  }

  // Get number nodes in the stack
  unsigned getstackNodeCount() {
    return stackNodeCount;
  }

/*
Name: Clear
Function Purpose : Clears the stack  - removes all elements from the stack
Function Design:   if the stack is not empty, it deallocates the stack
Inputs:            called by the object that invokes it
Outputs:           void
                   clears the stack that invokes it
*/
  void Clear() {
      NodeStackStruct<Type>* tranversePtr = stackTopNodePtr;
      NodeStackStruct<Type>* nodeDeletePtr;

      while (tranversePtr != nullptr) {
          nodeDeletePtr = tranversePtr;
          tranversePtr = tranversePtr->nextNodePtr; // move onto the next element
          delete nodeDeletePtr;
      }

      stackTopNodePtr = nullptr; // reset
      stackNodeCount = 0;
  }

  // = operator
  StackListClass<Type>& operator=(const StackListClass<Type>& stackListRef) {
    // if target stack not empty, then clear it
    if (stackTopNodePtr != nullptr) 
        Clear();
    copyToStackFrom(stackListRef);

    return *this;
  }

  // Display the stack
  void Display(const char* objName) {
    cout << "Object: " << objName << endl;

    if (stackTopNodePtr != nullptr) {
      NodeStackStruct<Type>* tranversePtr;
      cout << "top:" << endl;
      tranversePtr = stackTopNodePtr;

      while (tranversePtr != nullptr) {
        cout << tranversePtr->data << endl;
        tranversePtr = tranversePtr->nextNodePtr;
      }
    }//if
    else
      cout << "stack is empty." << endl;

    cout << "stack node count : " << getstackNodeCount() << endl;
    cout << endl << endl;
  }

  // destructor
  ~StackListClass() { Clear(); }
};
