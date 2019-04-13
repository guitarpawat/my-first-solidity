pragma solidity ^0.5.0;

contract PassBy {
    
    uint[] public publicStorageArray;
    
    event Logging(string key, uint[] val);
    event StateChanges(string msg);
    
    modifier notEmptyArray(uint[] memory memoryArray) {
        require(memoryArray.length > 0, "array cannot be empty");
        _;
    }
    
    modifier firstElementNot1Or2(uint[] memory memoryArray) {
        require(memoryArray[0] != 1, "array[0] must not be 1");
        require(memoryArray[0] != 2, "array[0] must not be 2");
        _;
    }
    
    
    // Shows that memory -> storage will pass by value, but same type will pass by referemce.
    function f(uint[] memory memoryArray) public notEmptyArray(memoryArray) firstElementNot1Or2(memoryArray) {
        emit Logging("memoryArray", memoryArray);
        publicStorageArray = memoryArray;
        emit Logging("publicStorageArray", publicStorageArray);
        uint[] memory anotherMemoryArray = memoryArray;
        emit Logging("anotherMemoryArray", anotherMemoryArray);
        uint[] storage anotherStorageArray = publicStorageArray;
        emit Logging("anotherStorageArray", anotherStorageArray);
        
        memoryArray[0] = 1;
        emit StateChanges("memoryArray[0] changes to 1");
        emit Logging("memoryArray", memoryArray);
        emit Logging("publicStorageArray", publicStorageArray);
        emit Logging("anotherMemoryArray", anotherMemoryArray);
        emit Logging("anotherStorageArray", anotherStorageArray);
        
        publicStorageArray[0] = 2;
        emit StateChanges("publicStorageArray[0] changes to 2");
        emit Logging("memoryArray", memoryArray);
        emit Logging("publicStorageArray", publicStorageArray);
        emit Logging("anotherMemoryArray", anotherMemoryArray);
        emit Logging("anotherStorageArray", anotherStorageArray);
    }
}