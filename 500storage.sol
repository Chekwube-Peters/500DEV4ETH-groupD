pragma solidity ^0.6.1;

contract ConStorage {

  enum MemberState {beginner, intermediate, certified}

  enum Tasks {none, pending, cancelled, completed}

  enum StudentStatus {inactive, active}

  enum Grades{None, Good, Great, Outstanding, Epic, Legendary}
    
  MemberState state = MemberState.beginner;
  StudentStatus status = StudentStatus.inactive;
  Tasks task = Tasks.none;
  Grades currentGrade = Grades.None;

    
  // uint testScores = 0;
  // uint consistency;
  uint grading;
  uint ratings = 0;
  // bool isAdmin = false;
  uint studentId = 1100;
  uint adminId = 2200;
  string msg_1 = "active";
  string msg_2 = "inactive";
  // bool isAStudent = false;

  struct Students{
      bytes32 f_Name;
      bytes32 l_Name;
      bytes32 email;
      uint id;
      uint8 rating;
      bool isActivated;
      uint32 age;
      uint8 grade;
      string githubLink;
    }

  struct Admins{
    bytes32 name;
    bytes32 userEmail;
    uint id;
    bool isActivated;
    }

  address owner;
  Students[] public studentList;
  Admins[2] public adminList;
  string[] public links;


    mapping(address => Students) public students;
    mapping(bytes32 => bool) public isAdminList;
    mapping(address => Admins) public adminsList;
    mapping(address => bool) public isAdmin;
    mapping(uint => Students) nameCount;
    mapping(uint => Admins) adminCount;
    mapping(address => uint) public reward;
    mapping(bytes32 => Students) getStudentByEmail;
    // mapping(address => bool) public isMember;
    //mapping(uint => uint) grading; not needed.
    // mapping(address => MemberState)internal userLevel;
    // mapping(address => uint) public balanceOf;
    
}