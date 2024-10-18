// userDAO.js (Data Access Object inside the models folder)
const db = require('./databaseConnection');

class UserDAO {
    async getUserById(id) {
        const query = `SELECT * FROM users WHERE id = ?`;
        const [rows] = await db.execute(query, [id]);
        return rows[0];
    }

    async createUser(userData) {
        const query = `INSERT INTO users (name, email) VALUES (?, ?)`;
        const result = await db.execute(query, [userData.name, userData.email]);
        return result.insertId;
    }

    // Additional CRUD functions can go here (updateUser, deleteUser, etc.)
}

module.exports = new UserDAO();