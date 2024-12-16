## Installation

To install and run the system locally, follow these steps:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/RaviniKuruppu/Portfolio_project.git
2. **Install dependencies:**
   ```bash
   cd backend
   npm install
3. **Start the application:**
   ```bash
   npm start
### Database Setup

#### Create a MySQL Database Schema
1. Open your MySQL client (e.g., MySQL Workbench or terminal).
2. Create a new schema named `eventhub`:
   ```sql
   CREATE DATABASE eventhub;
   USE eventhub;
3. Execute the `db.sql`  file to set up tables and initial data.
   ```sql
   SOURCE /backend/src/database/db.sql;
   

4. Edit the `.env` file to include your MySQL username and password.

### Steps to Set Up and Run Your Flutter Project

1. **Ensure Flutter is Installed**  
   Run the following command to check if Flutter is installed and properly set up:  
   ```bash
   flutter doctor
   ```
2. **Navigate to Your Project Directory**  
   Change to your project directory using:  
   ```bash
   cd eventhub
   ```
3. **Fetch Dependencies**  
   Run the following command to install all required dependencies:  
   ```bash
   flutter pub get
   ```
4. **Run the Flutter App**  
   Start the app by running:  
   ```bash
   flutter run
   ```
5. **Select Chrome as the Device**  
   When prompted, select the Chrome browser to run your app as a web application.
