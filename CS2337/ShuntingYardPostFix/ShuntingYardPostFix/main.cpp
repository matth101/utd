/*
ShuntingYardPostFix
11/28/2022
Matthew Hui
This program provides a structured method to transform infix expressions into postfix expressions, and then constructs and displays binary expression trees based off those results.
*/

#include <iostream>
#include <iomanip>
#include <fstream>
#include <string>
#include <sstream>
#include <map>
#include <stack>

using namespace std;

string inputFileNameStr = "expressions.txt";                  // Default location in solution folder

class OperatorMapClass {

private:
    typedef map<char, int>    OperatorPrecedenceMapType;
    OperatorPrecedenceMapType operatorMapObj;

public:

    OperatorMapClass() {
        operatorMapObj.insert(OperatorPrecedenceMapType::value_type('+', 1));
        operatorMapObj.insert(OperatorPrecedenceMapType::value_type('-', 1));
        operatorMapObj.insert(OperatorPrecedenceMapType::value_type('*', 2));
        operatorMapObj.insert(OperatorPrecedenceMapType::value_type('/', 2));
    }//OperatorMapClass ()

    bool isStackOperatorHigherPrecedence(char operatorChar, char operatorStackChar) {
        return((operatorMapObj.count(operatorStackChar))
            &&
            (operatorMapObj.at(operatorStackChar) > operatorMapObj.at(operatorChar))); // so does * technically have lower precedence??
    }//isStackOperatorHigherPrecedence()

    bool isOperator(char token) {
        return operatorMapObj.count(token) != 0;
    }//isOperator()

};//OperatorMapClass

OperatorMapClass  operatorMapObj;

/*
Need to 1) Build actual BET
        2) Write display functions for
            pre
            in
            post
        3) Run the three displays in order in main()
*/
class TreeNode {
    public:
        char value;
        TreeNode* leftChild;
        TreeNode* rightChild;

        TreeNode(char c) {
            value = c;
            leftChild = nullptr;
            rightChild = nullptr;
        }
};

TreeNode* BuildNewNodeObjPtrMethod(char value) {

    // xxx new a new TreeNodeClass pointer
    // set value in new node and left and right pointers
    // return new node pointer
    TreeNode* newNodePointer = new TreeNode(value);
    newNodePointer->value = value;
    newNodePointer->leftChild = nullptr;
    newNodePointer->rightChild = nullptr;

    return newNodePointer;
};

TreeNode* constructTree(string postfix) {
    stack<TreeNode*> stack;

    if (postfix.length() == 0) {
        return nullptr;
    }

    for (char token : postfix) {
        //cout << "traversing postfix" << endl;
        TreeNode* right = nullptr; 
        TreeNode* left = nullptr;
        TreeNode* subtreeRoot = nullptr;
        switch (token) {
        case '+': case '-': case '*': case '/': // if operator, take top as right node and another as the left (should be two operands) and push that as a subtree
            right = stack.top();
            stack.pop();
            left = stack.top();
            stack.pop();

            subtreeRoot = new TreeNode(token);
            subtreeRoot->leftChild = left;
            subtreeRoot->rightChild = right;
            stack.push(subtreeRoot);
            break;
        default: // if operand, just push it on
            TreeNode* newNode = new TreeNode(token);
            stack.push(newNode);
            break;
        }
    }

    //cout << "made tree";

    return stack.top(); // the top at the end should point to root of the tree
}

string buildString = "";

void preorder(TreeNode* treeNode) {
    //if (treeNode) {
    //    buildString += treeNode->value;
    //    preorder(treeNode->leftChild);
    //    preorder(treeNode->rightChild);
    //}
    if (treeNode == nullptr) {
        return;
    }
    buildString += treeNode->value;
    preorder(treeNode->leftChild);
    preorder(treeNode->rightChild);
}

bool areParensRequired(TreeNode* treeNode, char value) { // Checks if we need to group current 
    OperatorMapClass operatorMapObj;
    if (operatorMapObj.isOperator(value) &&
        operatorMapObj.isOperator(treeNode->value) &&
        operatorMapObj.isStackOperatorHigherPrecedence(treeNode->value, value)) {
        buildString += '(';
        return true;
    }
    return false;
}

void inorder(TreeNode* treeNode) { 
    //xxx do in order transversal to build string
    bool parensRequired = false;
    if (treeNode) {
        // xxx check if parens required pass arguments treeNode->left, treeNode->value
        parensRequired = areParensRequired(treeNode->leftChild, treeNode->value);
        inorder(treeNode->leftChild);

        if (parensRequired) {
            buildString += ')';
        }//add ) to buildString

        buildString += treeNode->value;

        parensRequired = areParensRequired(treeNode->rightChild, treeNode->value);
        // xxx check if parens required pass arguments treeNode->right, treeNode->value
        inorder(treeNode->rightChild);

        if (parensRequired) {
            buildString += ')';
        }//add ) to buildString
    }//if
}

void postorder(TreeNode* treeNode) {
    if (treeNode) {
        postorder(treeNode->leftChild);
        postorder(treeNode->rightChild);
        buildString += treeNode->value;
    }
}

class ShuntingYardClass {

public:
    string createPostFixFrom(string infixString) {

        string       outputString="";
        stack <char> operatorStackObj;

        for (char token : infixString) {
            switch (token) {
            case '/': case '*': case '+': case '-':
                while (operatorStackObj.size() != 0 && (operatorStackObj.top() != '(') &&
                    operatorMapObj.isStackOperatorHigherPrecedence(token, operatorStackObj.top())) {

                    outputString.push_back(operatorStackObj.top());
                    operatorStackObj.pop();
                }

                operatorStackObj.push(token);
                break;
            case '(':                 
                // xxx insert code here
                //operatorStackObj.push(token);
                operatorStackObj.push('(');

                // push this token on the stack
                break;
            case ')':
                // xxx insert code here                                                     
                while ((operatorStackObj.top() != '(') && operatorStackObj.size() != 0) {
                    outputString.push_back(operatorStackObj.top());
                    operatorStackObj.pop();
                }
                operatorStackObj.pop(); // pop the closing paren
                break;
            default:                                                         
                // xxx insert code here
                outputString.push_back(token);
                // push back the operand symbol to the output string 
                break;
            }//switch
        }//for
        
         while (operatorStackObj.size() > 0) {
             outputString.push_back(operatorStackObj.top());
             operatorStackObj.pop();
         }//while-end
        
        return(outputString);

    }//postfix()	

};//ShuntingYardClass

int main() {

    ifstream inputFileStreamObj(inputFileNameStr);

    if (inputFileStreamObj.fail()) {
        cout << "File " << inputFileNameStr << " could not be opened !" << endl;
        return (EXIT_FAILURE);
    }//if

    string  infixExpressionStr,
        postfixExpressionStr;

    ShuntingYardClass shuntingYardObj;  

    while (inputFileStreamObj >> infixExpressionStr) {
        cout << "InFix   Expression : " << infixExpressionStr << endl;
        postfixExpressionStr = shuntingYardObj.createPostFixFrom(infixExpressionStr);
        cout << "PostFix Expression : " << postfixExpressionStr << endl << endl;

        TreeNode* expressionTreeRootPtr = constructTree(postfixExpressionStr);

        buildString = "";  
        preorder(expressionTreeRootPtr);
        cout << "Tree  pre-order expression is " << endl << buildString << endl << endl;

        buildString = "";  
        inorder(expressionTreeRootPtr);
        cout << "Tree   in-order expression is " << endl << buildString << endl << endl;

        buildString = "";  
        postorder(expressionTreeRootPtr);
        cout << "Tree post-order expression is " << endl << buildString << endl << endl;

        cout << endl << endl;
    };//while

    inputFileStreamObj.close();

    cout << "Press the enter key once or twice to end." << endl;  inputFileStreamObj.close();

    return EXIT_SUCCESS;

}//main()

