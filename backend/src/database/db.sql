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

CREATE TABLE events (
  id INT AUTO_INCREMENT PRIMARY KEY,
  category_id INT NOT NULL,
  title VARCHAR(255) NOT NULL,
  imageUrl VARCHAR(255) NOT NULL,
  subject VARCHAR(255),
  description TEXT,
  date VARCHAR(255) NOT NULL,
  time VARCHAR(255) NOT NULL,
  location VARCHAR(255),
  onsiteOrOnline ENUM('onsite', 'online') NOT NULL,
  eventType VARCHAR(255) NOT NULL,
  FOREIGN KEY (category_id) REFERENCES categories(id)
);


INSERT INTO events (category_id, title, imageUrl, subject, description, date, time, location, onsiteOrOnline, eventType)
VALUES ('6', 'Seminar On Construction', 'https://image.isu.pub/200603113637-ab7453f9b70f4533018f303d48494dae/jpg/page_1_thumb_large.jpg', 'Seminar On Construction for the 2nd year Students', 'In this workshop you are going to learn new things about data science and get a good knowledge about them', '2024-05-03', '8:30 AM', 'University Premises', 'onsite', 'extracurricular');

CREATE TABLE registrations (
  id INT AUTO_INCREMENT PRIMARY KEY,
  event_id INT NOT NULL,
  user_id INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  FOREIGN KEY (event_id) REFERENCES events(id),
  FOREIGN KEY (user_id) REFERENCES user(id),
  UNIQUE KEY unique_user_event (user_id, event_id)
);

