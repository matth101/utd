/*
Program Name: Calculate Interest
Date: 2022-11-29
Author: Matthew Hui
Module Purpose
This program explores the process of hashing by parsing text input into a hash table and displaying the data, implemented with an unordered map.
*/

#include <iostream>
#include <iomanip>
#include <sstream>
#include <fstream>
#include <unordered_map>
#include <string>

using namespace std;

// Defaults in solution folder
string inputFileNameStr = "namesids.txt";

//define namePair using C++  pair template class (2 strings - first & last name)
typedef pair<string, string> namePair;

//define stl::hash function for namePair keys
namespace std {

    template<> 
    class hash <namePair> {
    public:
        size_t operator() (const namePair& namePair) const {
            return hash<string>() (namePair.first) ^ hash<string>() (namePair.second);
        }//size_t operator()
    };//class hash

}//namespace std


void displayHashTableLookupResult(pair<string, string> namePair, unordered_map<pair<string, string>, unsigned int>& hashTable) {

    //$$ use stringstream object to display lookup result
    
    //$$ display the result id or
    //$$ a message that indicates if there is not a entry in the hash table 
    stringstream stringStreamObj;
    stringStreamObj << setw(20) << left << namePair.first << setw(20) << left << namePair.second;
    cout << stringStreamObj.str();

    if (hashTable[namePair]) {
        cout << setw(29) << left << hashTable[namePair] << endl;
    }
    else {
        cout << "There is no hash table entry." << endl;
    }
};


int main(int argc, char* argv[]) {

    //define hashTable as namepair keys and integer value identifications (open address linear probe)
    unordered_map<namePair, unsigned int> hashTable;

    //Put in the hash table the namePair keys and associated number ids from text file
    ifstream inputFileStreamObj(inputFileNameStr);

    // $$ Check if file can be opened
    if (inputFileStreamObj.fail()) {
        cout << "File " << inputFileNameStr << " could not be opened !" << endl;
        return (EXIT_FAILURE);
    }//if

    string   firstName, lastname;
    unsigned id;

    while (inputFileStreamObj) {
        inputFileStreamObj >> firstName >> lastname >> id;
        hashTable[namePair(firstName, lastname)] = id;
    }

    // $$ read in to hash table namePair(firstName, lastname)] and set to id from file


    // $$ range based for loop to display elements in the hash table map, namePair keys along with ids
    for (pair<namePair, unsigned int> element : hashTable) {
        cout << setw(20) << left << element.first.first;
        cout << setw(20) << left << element.first.second;
        cout << setw(20) << left << element.second << endl;
    }

    cout << endl << endl;

    //$$ look up 6 ids in hash table, 2 of each are not in the table

    displayHashTableLookupResult(namePair("Aubrey", "Graham"), hashTable);
    displayHashTableLookupResult(namePair("Robyn", "Fenty"), hashTable);
    displayHashTableLookupResult(namePair("Matthew", "Hui"), hashTable);
    displayHashTableLookupResult(namePair("Barack", "Obama"), hashTable);
    displayHashTableLookupResult(namePair("Scott", "Dollinger"), hashTable);
    displayHashTableLookupResult(namePair("Monica", "Lewinsky"), hashTable);

    //$$ freeze screen with Press enter key once or twice to end code
    cout << "Press enter once or twice to end the program." << endl;
    cin.ignore();
    cin.get();

    return 0;
}

