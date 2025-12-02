import { useState } from 'react';
import { Login } from './components/Login';
import { Header } from './components/Header';
import { Dashboard } from './components/Dashboard';
import { Courses } from './components/Courses';
import { Schedule } from './components/Schedule';
import { Library } from './components/Library';
import { Tasks } from './components/Tasks';
import { Disciplines } from './components/Disciplines';

type UserRole = 'student' | 'teacher' | 'assistant' | null;
type View = 'dashboard' | 'courses' | 'schedule' | 'library' | 'tasks' | 'disciplines';

export default function App() {
  const [userRole, setUserRole] = useState<UserRole>(null);
  const [currentView, setCurrentView] = useState<View>('dashboard');
  const [userName, setUserName] = useState('');

  const handleLogin = (role: UserRole, name: string) => {
    setUserRole(role);
    setUserName(name);
  };

  const handleLogout = () => {
    setUserRole(null);
    setUserName('');
    setCurrentView('dashboard');
  };

  if (!userRole) {
    return <Login onLogin={handleLogin} />;
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <Header 
        currentView={currentView} 
        onNavigate={setCurrentView}
        userName={userName}
        userRole={userRole}
        onLogout={handleLogout}
      />
      
      <main className="container mx-auto px-4 py-6">
        {currentView === 'dashboard' && <Dashboard onNavigate={setCurrentView} userRole={userRole} />}
        {currentView === 'courses' && <Courses userRole={userRole} />}
        {currentView === 'schedule' && <Schedule userRole={userRole} />}
        {currentView === 'library' && <Library userRole={userRole} />}
        {currentView === 'tasks' && <Tasks userRole={userRole} />}
        {currentView === 'disciplines' && <Disciplines userRole={userRole} />}
      </main>
    </div>
  );
}