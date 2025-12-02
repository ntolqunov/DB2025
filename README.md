# E-Learning Management System

A comprehensive E-learning Management System built with React and TypeScript, featuring role-based authentication for students, teachers, and teacher assistants.

## Features

### 🎓 Role-Based Access Control
- **Students**: Access courses, view schedules, browse library, submit assignments
- **Teachers**: Create and manage courses, assign tasks, grade students, track attendance
- **Teacher Assistants**: Support teachers with grading and course management

### 📚 Core Modules
- **Dashboard**: Overview of all activities and quick access to modules
- **Courses**: Browse and manage online courses with module tracking
- **Schedule**: View class timetables and events
- **Library**: Access digital books and learning resources
- **Tasks/Assignments**: Create, submit, and track assignments
- **Disciplines**: Monitor grades and attendance

## Tech Stack

- **Frontend**: React 18 with TypeScript
- **Styling**: Tailwind CSS
- **Icons**: Lucide React
- **State Management**: React Hooks
- **Routing**: Component-based navigation

## Project Structure

```
├── components/
│   ├── Login.tsx           # Role selection and authentication
│   ├── Header.tsx          # Navigation header
│   ├── Dashboard.tsx       # Main dashboard
│   ├── Courses.tsx         # Course management
│   ├── Schedule.tsx        # Class schedule
│   ├── Library.tsx         # Digital library
│   ├── Tasks.tsx           # Assignment management
│   └── Disciplines.tsx     # Grades and attendance
├── styles/
│   └── globals.css         # Global styles and Tailwind config
├── lib/
│   └── api.ts              # API utilities (ready for backend integration)
└── App.tsx                 # Main application component
```

## Getting Started

### Prerequisites
- Node.js 16+ installed
- npm or yarn package manager

### Installation

1. Clone the repository:
```bash
git clone https://github.com/YOUR_USERNAME/elearning-management-system.git
cd elearning-management-system
```

2. Install dependencies:
```bash
npm install
```

3. Start the development server:
```bash
npm run dev
```

4. Open your browser and navigate to `http://localhost:5173`

## Usage

1. **Select Your Role**: Choose between Student, Teacher, or Teacher Assistant
2. **Login**: Enter your credentials (currently accepts any credentials for demo)
3. **Navigate**: Use the header navigation to access different modules
4. **Explore**: Each module has role-specific features and permissions

## Current Status

✅ Complete frontend implementation (11 components, ~2,850 lines)  
✅ Role-based UI and permissions  
✅ Responsive design for all devices  
✅ Mock data for demonstration  
⏳ Backend integration ready (Supabase setup files included)

## Future Enhancements

- [ ] Backend integration with Supabase
- [ ] Real authentication system
- [ ] Database persistence
- [ ] File upload functionality
- [ ] Real-time notifications
- [ ] Video conferencing integration
- [ ] Advanced analytics and reporting

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the [MIT License](LICENSE).

## Contact

For questions or feedback, please open an issue on GitHub.
