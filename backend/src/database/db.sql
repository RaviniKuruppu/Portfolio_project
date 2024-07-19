CREATE TABLE user (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  role ENUM('user', 'admin', 'systemadmin') NOT NULL
);

CREATE TABLE categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL UNIQUE,
  color VARCHAR(255) DEFAULT 'orange'
);

INSERT INTO categories (title, color) VALUES ('CSE', 'pink');
INSERT INTO categories (title, color) VALUES ('Civil', 'blue');
INSERT INTO categories (title, color) VALUES ('ENTC', 'orange');
INSERT INTO categories (title, color) VALUES ('Electrical', 'yellow');
INSERT INTO categories (title, color) VALUES ('Material', 'purple');
INSERT INTO categories (title, color) VALUES ('Chemical', 'green');
INSERT INTO categories (title, color) VALUES ('Mechanical', 'red');
INSERT INTO categories (title, color) VALUES ('Textile', 'brown');

