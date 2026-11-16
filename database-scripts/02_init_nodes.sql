-- ==========================================
-- KHỞI TẠO NODE_01 (DÀNH CHO TỈNH NGHỆ AN)
-- ==========================================
CREATE DATABASE IF NOT EXISTS tuyensinh_node01 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE tuyensinh_node01;

CREATE TABLE schools (
    id INT AUTO_INCREMENT PRIMARY KEY,
    school_code VARCHAR(20) NOT NULL UNIQUE,
    school_name VARCHAR(150) NOT NULL,
    education_level VARCHAR(50) NOT NULL -- MAM_NON, CAP_1, CAP_2, CAP_3
);

CREATE TABLE admission_periods (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    school_year VARCHAR(20) NOT NULL,
    education_level VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'OPEN' -- OPEN, CLOSED
);

CREATE TABLE student_applications (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    student_user_id BIGINT NOT NULL, -- Liên kết logic với id ở bảng users bên Gateway DB
    period_id INT NOT NULL,
    school_id INT NOT NULL,
    student_full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    status VARCHAR(30) DEFAULT 'PENDING', -- PENDING (Chờ duyệt), APPROVED (Trúng tuyển), REJECTED (Từ chối)
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (period_id) REFERENCES admission_periods(id),
    FOREIGN KEY (school_id) REFERENCES schools(id)
);

-- Dữ liệu mẫu cho Nghệ An
INSERT INTO schools (school_code, school_name, education_level) VALUES 
('NA_THPT_PBC', 'THPT Chuyên Phan Bội Châu', 'CAP_3'),
('NA_THCS_DT', 'THCS Đặng Thai Mai', 'CAP_2');

INSERT INTO admission_periods (title, school_year, education_level, start_date, end_date) VALUES 
('Tuyển sinh vào lớp 10 năm học 2026-2027', '2026-2027', 'CAP_3', '2026-06-01', '2026-06-30');


-- ==========================================
-- KHỞI TẠO NODE_02 (DÀNH CHO TỈNH HÀ TĨNH)
-- ==========================================
CREATE DATABASE IF NOT EXISTS tuyensinh_node02 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE tuyensinh_node02;

CREATE TABLE schools (
    id INT AUTO_INCREMENT PRIMARY KEY,
    school_code VARCHAR(20) NOT NULL UNIQUE,
    school_name VARCHAR(150) NOT NULL,
    education_level VARCHAR(50) NOT NULL
);

CREATE TABLE admission_periods (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    school_year VARCHAR(20) NOT NULL,
    education_level VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'OPEN'
);

CREATE TABLE student_applications (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    student_user_id BIGINT NOT NULL,
    period_id INT NOT NULL,
    school_id INT NOT NULL,
    student_full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    status VARCHAR(30) DEFAULT 'PENDING',
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (period_id) REFERENCES admission_periods(id),
    FOREIGN KEY (school_id) REFERENCES schools(id)
);

-- Dữ liệu mẫu cho Hà Tĩnh
INSERT INTO schools (school_code, school_name, education_level) VALUES 
('HT_THPT_CHUYEN', 'THPT Chuyên Hà Tĩnh', 'CAP_3');