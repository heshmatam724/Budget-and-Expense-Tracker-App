// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BudgetTracker {
    struct Budget {
        string name;         // Name of the budget
        uint totalAmount;    // Total budgeted amount
        uint spentAmount;    // Amount already spent
    }

    mapping(address => Budget[]) private budgets;

    // Function to add a new budget
    function addBudget(string memory name, uint totalAmount) public {
        budgets[msg.sender].push(Budget({
            name: name,
            totalAmount: totalAmount,
            spentAmount: 0
        }));
    }

    // Function to add an expense to a specific budget
    function addExpense(uint budgetIndex, uint amount) public {
        require(budgetIndex < budgets[msg.sender].length, "Invalid budget index.");
        require(amount <= budgets[msg.sender][budgetIndex].totalAmount - budgets[msg.sender][budgetIndex].spentAmount, "Insufficient budget.");

        budgets[msg.sender][budgetIndex].spentAmount += amount;
    }

    // Function to get budget details
    function getBudgetDetails(uint budgetIndex) public view returns (string memory, uint, uint) {
        require(budgetIndex < budgets[msg.sender].length, "Invalid budget index.");

        Budget memory b = budgets[msg.sender][budgetIndex];
        return (b.name, b.totalAmount, b.spentAmount);
    }
}
