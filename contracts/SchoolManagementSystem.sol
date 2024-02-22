// SPDX-License-Identifier:UNLICENSED
pragma solidity ^0.8.2;

error ALREADY_REGISTERED();

contract SchoolManagmentSystem {

    struct staffrecord {
        string Name;
        uint age;
        address add;
        string subject;
    }

    struct studentrecord {
        string Name;
        uint age;
        string class;
        address add;
        string grade;
    }
    
    mapping(address=>string[]) school;
    
    mapping(address => mapping (address => staffrecord)) staffdatabase;

    mapping(address => mapping (address => studentrecord)) studentdatabase;
    
    
    address Principal;

    constructor(){
        Principal = msg.sender;
    }

    event studentRegisteredSuccessfully (string _studentName);
    event staffRegisteredSuccessfully (string _staffName);
    event SchoolCreatedSuccessfully (string _schoolName);

    function createSchool(string calldata _schoolName) external{
        school[msg.sender].push(_schoolName);

        Principal = msg.sender;

        emit SchoolCreatedSuccessfully(_schoolName);
    }

    function registerStaff(string calldata _staffName, uint _staffAge, address _staffaddress, string calldata _subject) external {
        require(msg.sender == Principal, "you are not the Principal");
        if(staffdatabase[Principal][_staffaddress].add == _staffaddress){
            revert ALREADY_REGISTERED();
        }

        staffdatabase[Principal][_staffaddress] = staffrecord(_staffName, _staffAge, _staffaddress, _subject);

        emit staffRegisteredSuccessfully(_staffName);
    
    }

    function registerStudent(string calldata _studentName, uint _studentAge, string calldata _studentclass, address _studentaddress) external {
        require(msg.sender == Principal, "you are not the Principal");

        if(studentdatabase[Principal][_studentaddress].add == _studentaddress){
            revert ALREADY_REGISTERED();
        }

        studentdatabase[Principal][_studentaddress] = studentrecord(_studentName, _studentAge, _studentclass, _studentaddress, "0");
        
        emit studentRegisteredSuccessfully(_studentName);
    }

    function updateStudentGrade(address _studentaddress, address _staffaddress, string calldata _grade) external {
        require(msg.sender == staffdatabase[Principal][_staffaddress].add, "You're not a Staff");
        require(_studentaddress == studentdatabase[Principal][_studentaddress].add, "Student Not Registered");
        

        studentdatabase[Principal][_studentaddress].grade = _grade;
    }

    function removeStudent(address _studentaddress) external {
        require(msg.sender == Principal);
        
        delete studentdatabase[Principal][_studentaddress];
    }

    function removeStaff(address _staffaddress) external  {
        require(msg.sender == Principal);
        
        delete staffdatabase[Principal][_staffaddress];
    }

    function getStaff(address _staffaddress) external view returns (staffrecord memory){
        return staffdatabase[Principal][_staffaddress];
    }
    
    function getStudent(address _studentaddress) external view returns (studentrecord memory){
        return studentdatabase[Principal][_studentaddress];
    }

}