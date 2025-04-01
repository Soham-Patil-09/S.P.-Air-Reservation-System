// Sample flight data without status
const flightData = [
    { origin: "Mumbai", destination: "Delhi" },
    { origin: "Delhi", destination: "Bangalore" },
    { origin: "Chennai", destination: "Kolkata" },
    { origin: "Goa", destination: "Mumbai" },
    { origin: "Hyderabad", destination: "Pune" },
    { origin: "Ahmedabad", destination: "Lucknow" },
];

const tableBody = document.getElementById("flightTableBody");
let index = 0;

// Function to update the table
function updateTable() {
    if (tableBody.rows.length >= 4) {
        // Add the move-up animation for all existing rows before removing the topmost row
        const rows = tableBody.querySelectorAll('tr');
        rows.forEach(row => {
            row.classList.add("move-up");
        });

        // Wait for the animation to finish before deleting the row
        setTimeout(() => {
            tableBody.deleteRow(0); // Delete the first row (oldest one)
        }, 500); // Match the animation duration (0.5s)
    }

    // Generate flight number based on city initials and a random number
    const flight = flightData[index];
    const flightNumber = flight.origin.charAt(0).toUpperCase() + flight.destination.charAt(0).toUpperCase() + Math.floor(Math.random() * 900 + 100); // Example: "MD103"

    // Add a new row from flightData
    const row = tableBody.insertRow(-1);
    row.classList.add("fade-in-row"); // Apply row animation
    row.innerHTML = `
        <td>${flightNumber}</td>
        <td>${flight.origin}</td>
        <td>${flight.destination}</td>
        <td><button class="btn btn-primary" onclick="redirectToLogin()">Buy Ticket</button></td>
    `;

    // Increment index and reset if it exceeds data length
    index = (index + 1) % flightData.length;
}

// Redirect function for the Buy Ticket button
function redirectToLogin() {
    window.location.href = "login.html"; // Adjust this URL to your login page
}

// Update the table every 2 seconds
setInterval(updateTable, 2500);


 // Set the minimum date to today
document.getElementById('date').min = new Date().toISOString().split('T')[0];

