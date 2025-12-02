# Backend API Setup Guide

This guide will help you connect your database to the E-Learning Management System.

## Database Schema

You'll need the following tables in your database:

### 1. Users Table
```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  role ENUM('student', 'teacher', 'assistant') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

### 2. Courses Table
```sql
CREATE TABLE courses (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  instructor VARCHAR(255) NOT NULL,
  instructor_id INT REFERENCES users(id),
  description TEXT,
  duration VARCHAR(50),
  thumbnail VARCHAR(500),
  rating DECIMAL(3,2) DEFAULT 0,
  category VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### 3. Enrollments Table
```sql
CREATE TABLE enrollments (
  id SERIAL PRIMARY KEY,
  student_id INT REFERENCES users(id),
  course_id INT REFERENCES courses(id),
  progress INT DEFAULT 0,
  enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(student_id, course_id)
);
```

### 4. Library Table
```sql
CREATE TABLE library_books (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  author VARCHAR(255) NOT NULL,
  category VARCHAR(100),
  pages INT,
  format VARCHAR(50),
  thumbnail VARCHAR(500),
  file_url VARCHAR(500),
  downloads INT DEFAULT 0,
  views INT DEFAULT 0,
  uploaded_by INT REFERENCES users(id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### 5. Tasks/Assignments Table
```sql
CREATE TABLE tasks (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  course_id INT REFERENCES courses(id),
  description TEXT,
  due_date DATE NOT NULL,
  priority ENUM('high', 'medium', 'low') DEFAULT 'medium',
  points INT DEFAULT 0,
  created_by INT REFERENCES users(id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### 6. Task Submissions Table
```sql
CREATE TABLE task_submissions (
  id SERIAL PRIMARY KEY,
  task_id INT REFERENCES tasks(id),
  student_id INT REFERENCES users(id),
  status ENUM('pending', 'in-progress', 'completed') DEFAULT 'pending',
  submission_url VARCHAR(500),
  grade INT,
  submitted_at TIMESTAMP,
  UNIQUE(task_id, student_id)
);
```

### 7. Schedule Table
```sql
CREATE TABLE schedule (
  id SERIAL PRIMARY KEY,
  course_id INT REFERENCES courses(id),
  title VARCHAR(255) NOT NULL,
  instructor VARCHAR(255),
  day ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'),
  time TIME NOT NULL,
  duration VARCHAR(50),
  location VARCHAR(255),
  type ENUM('lecture', 'lab', 'online', 'exam') DEFAULT 'lecture'
);
```

### 8. Disciplines Table
```sql
CREATE TABLE disciplines (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  instructor VARCHAR(255),
  instructor_id INT REFERENCES users(id),
  credits INT NOT NULL,
  color VARCHAR(50)
);
```

### 9. Student Grades Table
```sql
CREATE TABLE student_grades (
  id SERIAL PRIMARY KEY,
  student_id INT REFERENCES users(id),
  discipline_id INT REFERENCES disciplines(id),
  current_grade DECIMAL(5,2),
  attendance INT DEFAULT 0,
  UNIQUE(student_id, discipline_id)
);
```

## API Endpoints

Your backend API should implement these endpoints:

### Authentication
- `POST /api/auth/login` - Login user
  - Body: `{ email, password, role }`
  - Returns: `{ token, name, role, userId }`

- `GET /api/auth/me` - Get current user
  - Headers: `Authorization: Bearer <token>`
  - Returns: `{ id, name, email, role }`

### Courses
- `GET /api/courses` - Get all courses
- `GET /api/courses/:id` - Get course by ID
- `POST /api/courses` - Create course (teacher only)
- `PUT /api/courses/:id` - Update course (teacher only)
- `DELETE /api/courses/:id` - Delete course (teacher only)

### Library
- `GET /api/library?category=&search=` - Get all library items
- `GET /api/library/:id` - Get library item by ID
- `POST /api/library` - Upload new book (teacher only)

### Tasks
- `GET /api/tasks?status=` - Get all tasks
- `GET /api/tasks/:id` - Get task by ID
- `POST /api/tasks` - Create task (teacher only)
- `PUT /api/tasks/:id` - Update task
- `PATCH /api/tasks/:id/status` - Update task status

### Schedule
- `GET /api/schedule?day=` - Get schedule by day
- `GET /api/schedule` - Get all schedule
- `POST /api/schedule` - Create schedule entry (teacher only)

### Disciplines
- `GET /api/disciplines` - Get all disciplines
- `GET /api/disciplines/:id` - Get discipline by ID
- `GET /api/disciplines/:id/progress` - Get student progress

### Students (Teacher only)
- `GET /api/students` - Get all students
- `GET /api/students/:id` - Get student by ID
- `POST /api/students` - Create student account
- `PUT /api/students/:id` - Update student

## Example Backend Implementation (Node.js/Express)

```javascript
const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const mysql = require('mysql2/promise');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

// Database connection
const pool = mysql.createPool({
  host: 'your-database-host',
  user: 'your-database-user',
  password: 'your-database-password',
  database: 'your-database-name',
  waitForConnections: true,
  connectionLimit: 10
});

// JWT Secret
const JWT_SECRET = 'your-secret-key-change-this';

// Middleware to verify JWT token
const authenticateToken = (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  if (!token) {
    return res.status(401).json({ message: 'Access token required' });
  }

  jwt.verify(token, JWT_SECRET, (err, user) => {
    if (err) {
      return res.status(403).json({ message: 'Invalid token' });
    }
    req.user = user;
    next();
  });
};

// Login endpoint
app.post('/api/auth/login', async (req, res) => {
  try {
    const { email, password, role } = req.body;

    // Get user from database
    const [users] = await pool.query(
      'SELECT * FROM users WHERE email = ? AND role = ?',
      [email, role]
    );

    if (users.length === 0) {
      return res.status(401).json({ message: 'Invalid credentials' });
    }

    const user = users[0];

    // Verify password
    const validPassword = await bcrypt.compare(password, user.password_hash);
    if (!validPassword) {
      return res.status(401).json({ message: 'Invalid credentials' });
    }

    // Generate JWT token
    const token = jwt.sign(
      { userId: user.id, email: user.email, role: user.role },
      JWT_SECRET,
      { expiresIn: '24h' }
    );

    res.json({
      token,
      name: user.name,
      role: user.role,
      userId: user.id
    });
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ message: 'Server error' });
  }
});

// Get current user
app.get('/api/auth/me', authenticateToken, async (req, res) => {
  try {
    const [users] = await pool.query(
      'SELECT id, name, email, role FROM users WHERE id = ?',
      [req.user.userId]
    );

    if (users.length === 0) {
      return res.status(404).json({ message: 'User not found' });
    }

    res.json(users[0]);
  } catch (error) {
    console.error('Get user error:', error);
    res.status(500).json({ message: 'Server error' });
  }
});

// Get all courses
app.get('/api/courses', authenticateToken, async (req, res) => {
  try {
    let query = 'SELECT * FROM courses';
    
    if (req.user.role === 'student') {
      query = `
        SELECT c.*, e.progress 
        FROM courses c
        LEFT JOIN enrollments e ON c.id = e.course_id AND e.student_id = ?
      `;
    }

    const [courses] = await pool.query(query, [req.user.userId]);
    res.json(courses);
  } catch (error) {
    console.error('Get courses error:', error);
    res.status(500).json({ message: 'Server error' });
  }
});

// Get all tasks
app.get('/api/tasks', authenticateToken, async (req, res) => {
  try {
    const { status } = req.query;
    
    let query = `
      SELECT t.*, ts.status, ts.grade, ts.submitted_at
      FROM tasks t
      LEFT JOIN task_submissions ts ON t.id = ts.task_id AND ts.student_id = ?
    `;
    
    const params = [req.user.userId];
    
    if (status && status !== 'all') {
      query += ' WHERE ts.status = ?';
      params.push(status);
    }

    const [tasks] = await pool.query(query, params);
    res.json(tasks);
  } catch (error) {
    console.error('Get tasks error:', error);
    res.status(500).json({ message: 'Server error' });
  }
});

// Start server
const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
  console.log(`API server running on port ${PORT}`);
});
```

## Environment Variables

Create a `.env` file in your frontend:

```
NEXT_PUBLIC_API_URL=http://your-backend-url.com/api
```

## Testing the API

Use tools like Postman or curl to test your endpoints:

```bash
# Login
curl -X POST http://localhost:3001/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"student@example.com","password":"password123","role":"student"}'

# Get courses (with token)
curl -X GET http://localhost:3001/api/courses \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

## Next Steps

1. Set up your database with the provided schema
2. Implement the backend API endpoints
3. Update the `API_BASE_URL` in `/lib/api.ts` with your backend URL
4. Test each endpoint
5. The frontend will automatically use your API instead of mock data
