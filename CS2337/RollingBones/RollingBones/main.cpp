/*
Program Name: RollBones
Date:         2022-09-16
Author:       Matthew Hui
Module Purpose
RollBones is a simulation, command-line rendition of the game craps, where a user can bet on the results of two die rolls.
*/

#include<iostream>

using namespace std;

unsigned promptStake();
unsigned promptBet(unsigned stake);
unsigned getRand();
unsigned getDice();
void displayStake(unsigned stake);
void win();
void lose();

int main() {
    unsigned stake, bet, counter{0};
    stake = promptStake();

    do { // Start main game loop.
        displayStake(stake);
        bet = promptBet(stake);

        if (bet == 0) {
            cout << endl << "Player ends Game!" << endl;
            cout << "Roll Count : " << counter << endl;
            cout << "Final Stake Amount : " << stake << endl;
            cout << "Press enter key once or twice to end ...";

            cin.ignore();
            if (cin.get()) {
                return 0;
            }
        }

        int point{ 0 };
        do { // Start betting loop (plays until the round is lost).
            int temp = getDice();
            counter++;
            if (point != 0) { // Check if this is first roll, and then check win/loss conditions
                if (temp == point) {
                    win();
                    stake += bet;
                    break;
                }
                else if (temp == 7) {
                    lose();
                    stake -= bet;
                    break;
                }
                else {
                    cout << "The point is " << point << endl;
                    cout << "Throw em again and hope that luck's on your side!" << endl;
                    continue;
                }
            }
            else if (temp == 7 || temp == 11) {
                win();
                stake += bet;
                break;
            }
            else if (temp == 2 || temp == 3 || temp == 12) {
                lose();
                stake -= bet;
                break;
            }
            else {
                if (point == 0) {
                    point = temp;
                }
                cout << "The point is " << point << endl;
                cout << "Throw em again and hope that luck's on your side!" << endl;
            }
        } while (true);

    } while (stake > 0);

    cout << "Insufficient stake to continue. Thanks for playin' !" << endl;
    cout << "Roll Count : " << counter << endl;
    cout << "Final Stake Amount : " << stake << endl;

    return 0;
}

unsigned promptStake() { // Repeatedly prompt player for a valid stake amount.
    int i{ 0 };
    do {
        cout << "What is your stake amount ? ";
        cin >> i;

        if (i <= 0) {
            cout << endl << "You must enter a numeric, positive amount of money to bet with. Try again!" << endl;
        }
    } while (i <= 0);

    return i;
}

void displayStake(unsigned stake) { // Helper function to repeatedly display the current stake amount.
    cout << endl << "Current Stake Amount : " << stake << endl;
}

unsigned promptBet(unsigned stake) { // Repeatedly prompts and returns valid numerical bet value.
    int bet{ -1 };
    do {
        cout << endl << "What will you bet ? ";
        cin >> bet;

        if (bet < 0) {
            cout << "You must enter a 0 or positive amount of money to bet ! " << endl;
            bet = -1;
        }
        else if (bet > static_cast<int>(stake)) {
            cout << "Insufficient stake for this bet amount !" << endl;
            bet = -1;
        }
    } while (bet < 0);

    return bet;
}

unsigned getRand() { // Returns a whole pseudorandom number between 1 and 6 based on the current time.
    srand(clock());
    return (rand() % 6) + 1;
}

unsigned getDice() { // Returns the result of two simulated die rolls using GetRand().
    cout << endl << "Press enter key once or twice to throw the dice";
    cin.ignore();

    int die1{}, die2{}, sum{};
    if (cin.get()) { // Begin the rolling process.
        die1 = getRand();
        cout << "Die 01 is " << die1 << endl; // needs endl?
        die2 = getRand();
        cout << "Die 02 is " << die2 << endl;;
        sum = die1 + die2;
        cout << "The dice throw results : " << sum << " !" << endl;
    }

    return sum;;
}

void win() { // Alerts the user that they've won.
    cout << endl << "We've got ourselves a winner!" << endl;
}

void lose() { // Alerts the user that they've lost.
    cout << endl << "Too bad, we've got ourselves a loser." << endl;
}