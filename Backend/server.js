const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
const port = 3000;

app.use(bodyParser.json());
app.use(cors());

const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'flutter',
  connectionLimit: 10
});

pool.getConnection((err, connection) => {
  if (err) {
    console.error('Error connecting to database:', err.stack);
    return;
  }
  console.log('Connected to database');
  connection.release();
});

app.post('/login', (req, res) => {
  const { username, password } = req.body;

  pool.query(
    'SELECT * FROM fl WHERE USERNAME = ? AND PASSWORD = ?',
    [username, password],
    (err, results) => {
      if (err) {
        console.error('Error executing query:', err);
        res.status(500).json({ message: 'Internal server error' });
        return;
      }

      if (results.length === 0) {
        res.status(401).json({ message: 'Invalid credentials' });
        return;
      }

      // If login is successful, return user data
      const user = {
        username: results[0].USERNAME,
        name: results[0].NAME,
        email: results[0].EMAIL_ID
      };
      res.json(user);
    }
  );
});
app.post('/register', (req, res) => {
  const { name, username, email, password } = req.body;

  pool.query(
    'INSERT INTO fl (NAME, USERNAME, EMAIL_ID, PASSWORD) VALUES (?, ?, ?, ?)',
    [name, username, email, password],
    (err, results) => {
      if (err) {
        console.error('Error executing query:', err);
        res.status(500).json({ message: 'Internal server error' });
        return;
      }
      res.status(200).json({ message: 'User registered successfully' });
    }
  );
});


app.listen(port, () => {
  console.log(`Server is running on 10.10.85.135:${port}`);
});
