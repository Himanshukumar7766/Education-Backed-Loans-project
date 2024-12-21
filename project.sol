
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EducationBackedLoans {
    struct Loan {
        uint256 id;
        address borrower;
        uint256 amount;
        uint256 interestRate;
        uint256 duration; // in months
        bool isRepaid;
    }

    mapping(uint256 => Loan) public loans;
    uint256 public loanCounter;

    event LoanCreated(uint256 id, address borrower, uint256 amount, uint256 interestRate, uint256 duration);
    event LoanRepaid(uint256 id);

    function createLoan(uint256 _amount, uint256 _interestRate, uint256 _duration) public {
        require(_amount > 0, "Loan amount must be greater than zero");
        require(_interestRate > 0, "Interest rate must be greater than zero");
        require(_duration > 0, "Duration must be greater than zero");

        loanCounter++;
        loans[loanCounter] = Loan(loanCounter, msg.sender, _amount, _interestRate, _duration, false);
        
        emit LoanCreated(loanCounter, msg.sender, _amount, _interestRate, _duration);
    }

    function repayLoan(uint256 _id) public {
        Loan storage loan = loans[_id];
        require(loan.borrower == msg.sender, "Only the borrower can repay the loan");
        require(!loan.isRepaid, "Loan already repaid");

        // Here you would implement the actual payment logic (e.g., transfer funds)
        
        loan.isRepaid = true;
        emit LoanRepaid(_id);
    }

    function getLoanDetails(uint256 _id) public view returns (Loan memory) {
        return loans[_id];
    }
}


