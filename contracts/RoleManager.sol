// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";

contract RoleManager is AccessControl {
    // Định nghĩa các role
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant NOTARY_ROLE = keccak256("NOTARY_ROLE");
    bytes32 public constant USER_ROLE = keccak256("USER_ROLE");

    // Hàm khởi tạo
    constructor() {
        // Gán quyền ADMIN_ROLE cho người triển khai contract
        _setupRole(ADMIN_ROLE, msg.sender);
    }

    // Hàm để cấp quyền USER_ROLE cho một địa chỉ khác
    function grantNotaryRole(address account) external {
        require(hasRole(ADMIN_ROLE, msg.sender), "Must have ADMIN_ROLE to grant USER_ROLE");
        grantRole(USER_ROLE, account);
    }

    // Hàm để kiểm tra xem một địa chỉ có quyền NOTARY_ROLE hay không
    function hasNotaryRole(address userAddress) external view returns (bool) {
        return hasRole(NOTARY_ROLE, userAddress);
    }
}
