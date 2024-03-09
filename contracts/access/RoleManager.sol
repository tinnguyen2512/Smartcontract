// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Contract quản lý phân quyền
contract RoleManager is AccessControl {
    // Khai báo các role
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant NOTARY_ROLE = keccak256("NOTARY_ROLE");
    bytes32 public constant USER_ROLE = keccak256("USER_ROLE");

    // Hàm khởi tạo, chỉ được gọi một lần khi triển khai contract
    constructor() {
        // Gán quyền ADMIN_ROLE cho người triển khai contract
        _setupRole(ADMIN_ROLE, msg.sender);
    }

    // Hàm để cấp quyền USER_ROLE cho một địa chỉ khác
    function grantNotaryRole(address account) external {
        require(hasRole(ADMIN_ROLE, msg.sender), "Must have ADMIN_ROLE to grant USER_ROLE");
        grantRole(USER_ROLE, account);
    }

    // Hàm kiểm tra quyền NOTARY_ROLE của một địa chỉ
    function checkNotaryRole(address userAddress) external view returns (bool) {
        return hasRole(NOTARY_ROLE, userAddress);
    }
}
