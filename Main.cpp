#include <fstream>
#include <iostream>
#include <unordered_map>
#include <string>
#include <bitset>
using namespace std;

int main() {
    ifstream inFile("MIPS_instructions.txt"); // Open the input file
    ofstream outFile("Binary_instructions.txt"); // Open the output file

    if (!inFile) { // Check if the input file was opened successfully
        cerr << "Unable to open MIPS file\n";
        return 1; // Return with error code 1
    }

    if (!outFile) { // Check if the output file was opened successfully
        cerr << "Unable to open Binary file\n";
        return 1; // Return with error code 1
    }

    string instruction;
    string binaryInstruction;
    string operation;
    string rest, rs, rt, rd, r3;

    unordered_map<string, string> registerMap = {
    {"$0", "00000"}, {"$1", "00001"}, {"$2", "00010"}, {"$3", "00011"}, {"$4", "00100"}, {"$5", "00101"}, {"$6", "00110"},
    {"$7", "00111"}, {"$8", "01000"}, {"$9", "01001"}, {"$10", "01010"}, {"$11", "01011"}, {"$12", "01100"}, {"$13", "01101"},
    {"$14", "01110"}, {"$15", "01111"}, {"$16", "10000"}, {"$17", "10001"}, {"$18", "10010"}, {"$19", "10011"}, {"$20", "10100"},
    {"$21", "10101"}, {"$22", "10110"}, {"$23", "10111"}, {"$24", "11000"}, {"$25", "11001"}, {"$26", "11010"}, {"$27", "11011"},
    {"$28", "11100"}, {"$29", "11101"}, {"$30", "11110"}, {"$31", "11111"}
    };

    unordered_map<string, string> functMap = {
        {"NOP", "00000000"}, {"SHRHI", "00000001"}, {"AU", "00000010"}, {"SHRHI", "00000001"}, {"CNT1H", "00000011"}, {"AHS", "00000100"},
        {"OR", "00000101"}, {"BCW", "00000110"}, {"MAXWS", "00000111"}, {"MINWS", "00001000"}, {"MLHU", "00001001"}, {"MLHSS", "00001010"},
        {"AND", "00001011"}, {"INVB", "00001100"}, {"ROTW", "00001101"}, {"SFWU", "00001110"}, {"SFHS", "00001111"}
    };

    int num;

    while (getline(inFile, instruction)) { // Read lines from the input file
        string binaryInstruction;

        // Split the instruction into its components
        operation = instruction.substr(0, instruction.find(" "));

        // **************** Load Immediate FORMAT: LI loadIndex, immediate, rd ***************************
        if (operation == "LI") {
            rest = instruction.substr(instruction.find(" ") + 1);
            rs = rest.substr(0, rest.find(","));
            rest = rest.substr(rest.find(",") + 1);
            rt = rest.substr(0, rest.find(","));
            rd = rest.substr(rest.find(",") + 2);

            num = stoi(rs); // Convert the string to an integer
            bitset<3> binaryrs(num); // Convert the integer to a binary string
            rs = binaryrs.to_string();

            num = stoi(rt); // Convert the string to an integer
            bitset<16> binaryrt(num); // Convert the integer to a binary string
            rt = binaryrt.to_string();

            binaryInstruction = "0" + rs + rt + registerMap[rd];
        }
        //********************** R4 FORMAT: instruction rs3, rs2, rs1, rd *******************************
        else if(operation == "SIMAL" || operation == "SIMAH" || operation == "SIMSL" || operation == "SIMSH"
              || operation == "SLIMAL" || operation == "SLIMAH" || operation == "SLIMSL" || operation == "SLIMSH") {

            rest = instruction.substr(instruction.find(" ") + 1);
            rs = rest.substr(0, rest.find(","));
            rest = rest.substr(rest.find(",") + 2);
            rt = rest.substr(0, rest.find(","));
            rest = rest.substr(rest.find(",") + 2);
            rd = rest.substr(0, rest.find(","));
            r3 = rest.substr(rest.find(",") + 2);

            if (operation == "SIMAL") {
                binaryInstruction = "10000" + registerMap[rs] + registerMap[rt] + registerMap[rd] + registerMap[r3];
            }
            if (operation == "SIMAH") {
                binaryInstruction = "10001" + registerMap[rs] + registerMap[rt] + registerMap[rd] + registerMap[r3];
            }
            if (operation == "SIMSL") {
                binaryInstruction = "10010" + registerMap[rs] + registerMap[rt] + registerMap[rd] + registerMap[r3];
            }
            if (operation == "SIMSH") {
                binaryInstruction = "10011" + registerMap[rs] + registerMap[rt] + registerMap[rd] + registerMap[r3];
            }
            if (operation == "SLIMAL") {
                binaryInstruction = "10100" + registerMap[rs] + registerMap[rt] + registerMap[rd] + registerMap[r3];
            }
            if (operation == "SLIMAH") {
                binaryInstruction = "10101" + registerMap[rs] + registerMap[rt] + registerMap[rd] + registerMap[r3];
            }
            if (operation == "SLIMSL") {
                binaryInstruction = "10110" + registerMap[rs] + registerMap[rt] + registerMap[rd] + registerMap[r3];
            }
            if (operation == "SLIMSH") {
                binaryInstruction = "10111" + registerMap[rs] + registerMap[rt] + registerMap[rd] + registerMap[r3];
            }
        }
        //*************************** R3 FORMAT: instruction rs2, rs1, rd ****************************************************
        else {
            rest = instruction.substr(instruction.find(" ") + 1);
            rs = rest.substr(0, rest.find(","));
            rest = rest.substr(rest.find(",") + 2);
            rt = rest.substr(0, rest.find(","));
            rd = rest.substr(rest.find(",") + 2);
            binaryInstruction = "11" + functMap[operation] + registerMap[rs] + registerMap[rt] + registerMap[rd];
        }


        outFile << binaryInstruction << "\n"; // Write each line to the output file
    }

    inFile.close(); // Close the input file
    outFile.close(); // Close the output file

    return 0; // Return successfully
}
