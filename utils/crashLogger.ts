import * as FileSystem from 'expo-file-system';

class CrashLogger {
    private logFile: string;
    private logs: string[] = [];

    constructor() {
        this.logFile = `${FileSystem.documentDirectory}crash_logs.txt`;
    }

    async log(message: string) {
        const timestamp = new Date().toISOString();
        const logEntry = `[${timestamp}] ${message}`;
        
        console.log(logEntry);
        this.logs.push(logEntry);

        // Zapisz do pliku
        try {
            await FileSystem.appendAsync(this.logFile, logEntry + '\n');
        } catch (error) {
            console.error('Error writing to log file:', error);
        }
    }

    async getLogs(): Promise<string> {
        try {
            return await FileSystem.readAsStringAsync(this.logFile);
        } catch (error) {
            return 'No logs found';
        }
    }

    async clearLogs() {
        try {
            await FileSystem.deleteAsync(this.logFile, { idempotent: true });
            this.logs = [];
        } catch (error) {
            console.error('Error clearing logs:', error);
        }
    }

    async exportLogs(): Promise<string> {
        return this.logFile;
    }
}

export const crashLogger = new CrashLogger();

