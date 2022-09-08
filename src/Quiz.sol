// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Quiz{
    struct Quiz_item {
      uint id;
      string question;
      string answer;
      uint min_bet;
      uint max_bet;
   }
    
    address public owner;
    mapping(uint => mapping(address => uint256)) public bets;
    uint public vault_balance;
    mapping(uint => Quiz_item) public quizs;
    uint private quizQty; //퀴즈 개수
    mapping (address => uint256) public balances;
    
    constructor () {
        owner = msg.sender;
        Quiz_item memory q;
        q.id = 1;
        q.question = "1+1=?";
        q.answer = "2";
        q.min_bet = 1 ether;
        q.max_bet = 2 ether;
        addQuiz(q);
    }

    function addQuiz(Quiz_item memory q) public {
        require(msg.sender == owner);
        quizs[q.id] = q;
        quizQty += 1;
    }

    function getAnswer(uint quizId) public view returns (string memory){
        require(msg.sender == owner);
        return quizs[quizId].answer;
    }

    function getQuiz(uint quizId) public view returns (Quiz_item memory) {
        Quiz_item memory quiz = quizs[quizId];
        quiz.answer = "";
        return quiz;
    }

    function getQuizNum() public view returns (uint){
        return quizQty;
    }
    
    function betToPlay(uint quizId) public payable {
        Quiz_item memory quiz = quizs[quizId];
        uint256 amount = msg.value; //송금한 wei의 수량
        require(betAmount >= quiz.min_bet);
        require(betAmount <= quiz.max_bet);
        bets[index][msg.sender] += betAmount;
        //bets[quizId] quiz마다 사용자가 베팅이 가능한데, index마다 부여한 베팅값
    }

    function solveQuiz(uint quizId, string memory ans) public returns (bool) {
        Quiz_item memory quiz = quizs[quizId];
        uint index = quildId - 1;//index semantics
        if(keccak256(bytes(quiz.answer)) == keccak256(bytes(ans!))){
           balances[msg.sender] += bets[index][msg.sender]
           return true; 
        }
        else{
           bets[index][msg.sender] = 0;
           vault_balance += bets[index][msg.sender];
           return false;
        }    
    }

    function claim() public {
        uint256 balance = balances[msg.sender];
        balances[msg.sender] = 0;
        //vault_balance -= amount;
        payable(msg.sender).transfer(amount);
    }

    receive() external payable{
        //vault_balance += msg.value;
    }

}
