class User {
  constructor(id, username, password, name, email, role) {
    this.id = id;
    this.username = username;
    this.password = password;
    this.name = name;
    this.email = email;
    this.role = role;
  }
}

module.exports = User;
