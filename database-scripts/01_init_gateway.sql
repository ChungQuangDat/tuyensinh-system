-- 1. Tạo Database Gateway
CREATE DATABASE IF NOT EXISTS tuyensinh_gateway CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE tuyensinh_gateway;

-- 2. Bảng Phân quyền (Roles)
CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) NOT NULL UNIQUE, -- VD: SYSTEM_ADMIN, ADMIN_TINH, GIAO_VIEN, HOC_SINH
    name VARCHAR(100) NOT NULL
);

-- 3. Bảng Người dùng (Users) - Dùng chung cho toàn hệ thống
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    role_id INT NOT NULL,
    province_code VARCHAR(20) NULL, -- NULL nếu là System Admin hoặc Học sinh (học sinh chọn tỉnh khi nộp hồ sơ)
    status TINYINT DEFAULT 1, -- 1: Hoạt động, 0: Khóa
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(id)
);

-- 4. Bảng Mapping Tỉnh - Năm học - Node (Trái tim điều hướng của hệ thống)
CREATE TABLE province_node_mapping (
    id INT AUTO_INCREMENT PRIMARY KEY,
    province_code VARCHAR(20) NOT NULL, -- VD: NGHE_AN, HA_TINH, HAI_PHONG
    province_name VARCHAR(100) NOT NULL,
    school_year VARCHAR(20) NOT NULL,   -- VD: 2026-2027
    node_code VARCHAR(50) NOT NULL,     -- VD: NODE_01, NODE_02
    db_name VARCHAR(100) NOT NULL,      -- Tên database thực tế: tuyensinh_node01
    UNIQUE KEY uk_province_year (province_code, school_year)
);

-- 5. Thêm dữ liệu mẫu ban đầu để test
INSERT INTO roles (code, name) VALUES 
('SYSTEM_ADMIN', 'Quản trị hệ thống'),
('ADMIN_TINH', 'Quản trị cấp Tỉnh/Thành phố'),
('ADMIN_SO_PHONG', 'Quản trị Sở/Phòng GD'),
('ADMIN_TRUONG', 'Quản trị Trường học'),
('GIAO_VIEN', 'Giáo viên duyệt hồ sơ'),
('HOC_SINH', 'Học sinh / Phụ huynh');

-- Tạo sẵn 1 tài khoản System Admin (mật khẩu tạm để 123456) và 1 Học sinh
INSERT INTO users (username, password, full_name, role_id, province_code) VALUES 
('sysadmin', '123456', 'Quản Trị Hệ Thống', 1, NULL),
('admin_nghean', '123456', 'Admin Sở GD Nghệ An', 2, 'NGHE_AN'),
('hocsinh01', '123456', 'Nguyễn Văn A', 6, NULL);

-- Cấu hình bản đồ điều hướng cho Nghệ An và Hà Tĩnh
INSERT INTO province_node_mapping (province_code, province_name, school_year, node_code, db_name) VALUES 
('NGHE_AN', 'Tỉnh Nghệ An', '2026-2027', 'NODE_01', 'tuyensinh_node01'),
('HA_TINH', 'Tỉnh Hà Tĩnh', '2026-2027', 'NODE_02', 'tuyensinh_node02');