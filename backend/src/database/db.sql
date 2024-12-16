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
VALUES ('2', 'Seminar On Construction', 'https://image.isu.pub/200603113637-ab7453f9b70f4533018f303d48494dae/jpg/page_1_thumb_large.jpg', 'Seminar On Construction for the 2nd year Students', 'In this workshop you are going to learn new things about data science and get a good knowledge about them', '2024-05-03', '8:30 AM', 'University Premises', 'onsite', 'extracurricular');
INSERT INTO events (category_id, title, imageUrl, subject, description, date, time, location, onsiteOrOnline, eventType) 
VALUES (
    '1', 
    'Workshop On Data Science', 
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQheClSWu0TLd3pBR8YhXXtj5_HOw4d17Uq2g&s.jpg', 
    'Workshop On data Science for the 2nd year Students', 
    'In this workshop you are going to learn new things about data science and get a good knowledge about them', 
    '2024-05-04', 
    '10:30 AM', 
    'University Premises', 
    'online', 
    'academic'
);

INSERT INTO events (category_id, title, imageUrl, subject, description, date, time, location, onsiteOrOnline, eventType) 
VALUES (
    '2', 
    'Workshop On Sustainable Energy sources', 
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbiVmFh5x8Kdxi3zRwm64BT94zdq0fWN5UkQ&s.jpg', 
    'Workshop On Sustainable Energy sources for the 2nd year Students', 
    'In this workshop you are going to learn new things about data science and get a good knowledge about them', 
    '2024-05-08', 
    '9:30 AM', 
    'University Premises', 
    'online', 
    'extracurricular'
);


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

INSERT INTO user (username, password, name, email, role) 
VALUES ('johndoe', '$2a$10$MNaom4wq1JkWc41a9wnycerQLGlekUlAyQ5o4owvuBERVW3WGE3Hy', 'John Doe', 'john.doe@example.com', 'admin');
INSERT INTO user (username, password, name, email, role) 
VALUES ('test1', '$2a$10$7Zi3POxvO1HDkQWBPlFUiewCElbe0vUnz1uO/ZPi8K2T5OQTcFziO', 'test user', 'test1@gamil.com', 'user');

