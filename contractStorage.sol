pragma solidity ^0.6.1;

contract ConStorage {

  enum MemberState {beginner, intermediate, certified}

  enum AssignmentTask {inactive, pending, cancelled, completed}

  enum Grade{average}
    
  MemberState public state = MemberState.beginner;
    
  // uint testScores = 0;
  // uint consistency;
  uint grading;
  uint rating = 0;
  bool isAdmin = false;
  uint studentId = 1100;
  uint adminId = 2200;
  bool isAStudent = false;

  struct Students{
      bytes32 f_Name;
      bytes32 l_Name;
      bytes32 email;
      uint id;
      uint rating;
    }

  struct Admins{
    bytes32 name;
    bytes32 userEmail;
    uint id;
    }

  address owner;
  Students[] public studentList;
  Admins[] public adminList;
  bytes32[] public deletedAdmins;

    mapping(address => Students) public students;
    mapping(bytes32 => bool) public isAdminList;
    mapping(uint => Admins) public admin;
    mapping(address => Admins) public adminAddr;
    mapping(uint => Students) nameCount;
    mapping(uint => Admins) adminCount;
    // mapping(address => bool) public isMember;
    //mapping(uint => uint) grading; not needed.
    // mapping(address => MemberState)internal userLevel;
    // mapping(address => uint) public balanceOf;
    
}