<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Airline Reservation System</title>

    <link rel="stylesheet" href="css/style.css">

	<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;700&display=swap" rel="stylesheet">
	

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">

</head>
<body>
    <!-- Sticky Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
        <div class="container">
            <a class="navbar-brand" href="#">S.P. Airline Reservation System</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="#about">About</a></li>
                    <li class="nav-item"><a class="nav-link" href="#services">Services</a></li>
                    <li class="nav-item"><a class="nav-link" href="#offers">Offers</a></li>
                    <li class="nav-item"><a class="nav-link" href="#destinations">Destinations</a></li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Login</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="adminLogin.jsp">Admin Login</a></li>
                            <li><a class="dropdown-item" href="customerLogin.jsp">Customer Login</a></li>
                            <li><a class="dropdown-item" href="staffLogin.jsp">Staff Login</a></li>
                            <li><a class="dropdown-item" href="managerLogin.jsp">Manager Login</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Carousel -->
    <div id="mainCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="images/flight1.jpg" class="d-block w-100" alt="Flight">
                <div class="carousel-caption">
                    <h5>Welcome to Airline System</h5>
                    <p>Book your next adventure with us!</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="images/flight2.jpg" class="d-block w-100" alt="Flight">
                <div class="carousel-caption">
                    <h5>Exclusive Offers</h5>
                    <p>Save big on domestic and international flights.</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="images/flight3.jpg" class="d-block w-100" alt="Flight">
                <div class="carousel-caption">
                    <h5>Unmatched Comfort</h5>
                    <p>Experience the luxury of flying with us.</p>
                </div>
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#mainCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#mainCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </button>
    </div>

    <!-- Flight Booking Form (Overlay with z-index) -->
    <div class="overlay-form">
        <form>
            <div class="segment">
                <h2>Book Your Flight</h2>
            </div>
            <div class="input-group">
                <select>
                    <option value="" disabled selected>From</option>
                    <option>Mumbai</option>
                    <option>Delhi</option>
                    <option>Bangalore</option>
                    <option>Chennai</option>
                </select>
                <select>
                    <option value="" disabled selected>To</option>
                    <option>New York</option>
                    <option>Dubai</option>
                    <option>London</option>
                    <option>Paris</option>
                </select>
                <input type="date" id="date" min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
            </div>
            <button id="book-now-btn" type="button" onclick="location.href='customerLogin.jsp'">Book Now</button>
        </form>
    </div>
    
    <!-- Services Section -->
    <div id="services" class="container mt-5">
        <h2 class="text-center">Our Services</h2>
        <div class="row d-flex align-items-stretch mt-4">
            <div class="col-md-4">
                <div class="card h-100 service-card">
                    <img src="images/service1.webp" class="card-img-top" alt="Book a Flight">
                    <div class="card-body">
                        <h5 class="card-title">Book a Flight</h5>
                        <p class="card-text">Easily book your flights with our user-friendly platform.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100 service-card">
                    <!-- <img src="images/" class="card-img-top w-100" style="max-height: 250px; object-fit: cover;" alt="Book a Flight"> -->
                    <img src="images/service2.png" class="card-img-top" alt="Check-In">
                    <div class="card-body">
                        <h5 class="card-title">Check-In</h5>
                        <p class="card-text">Avoid long lines with our seamless online check-in.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100 service-card">
                    <img src="images/service3.jpg" class="card-img-top" alt="Manage Booking">
                    <div class="card-body">
                        <h5 class="card-title">Manage Booking</h5>
                        <p class="card-text">Modify or cancel your bookings with ease.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Active Flights Idea Dropped --> 
    <!-- <div class="container">
        <h2 class="text-center"> Active Flights </h2>
        <table class="table table-bordered flight-table">
            <thead class="table-dark">
                <tr>
                    <th>Flight Number</th>
                    <th>Origin</th>
                    <th>Destination</th> -->... <!-- Action column for the button -->
                    <!-- <th>Action</th> 
                </tr>
            </thead>
            <tbody id="flightTableBody"> -->
                <!-- Dynamic rows will be inserted here -->
            <!-- </tbody>
        </table> -->
    <!-- </div> -->

    <!-- Our Destinations Section -->
    <div id="destinations" class="container mt-5">
        <h2 class="text-center">Popular Destinations</h2>
        <div class="owl-carousel owl-theme mt-4">
            <div class="item">
                <img src="images/destination1.jpg" class="img-fluid" alt="Destination 1">
                <h5 class="text-center mt-2">Paris, France</h5>
            </div>
            <div class="item">
                <img src="images/destination6.webp" class="img-fluid" alt="Destination 5">
                <h5 class="text-center mt-2">New Delhi, India</h5>
            </div>
            <div class="item">
                <img src="images/destination2.jpg" class="img-fluid" alt="Destination 2">
                <h5 class="text-center mt-2">Tokyo, Japan</h5>
            </div>
            <div class="item">
                <img src="images/destination3.jpg" class="img-fluid" alt="Destination 3">
                <h5 class="text-center mt-2">New York, USA</h5>
            </div>
            <div class="item">
                <img src="images/destination4.jpg" class="img-fluid" alt="Destination 4">
                <h5 class="text-center mt-2">Sydney, Australia</h5>
            </div>
            <div class="item">
                <img src="images/destination5.jpg" class="img-fluid" alt="Destination 5">
                <h5 class="text-center mt-2">Cape Town, South Africa</h5>
            </div>

        </div>
    </div>

    <!-- Offers Section -->... <div id="offers" class="container mt-5">
        <h2 class="text-center">Current Offers</h2>
        <div class="row mt-4">
            <div class="col-md-6">
                <img src="images/offer1.jpg" class="img-fluid" alt="Offer 1">
                <p class="mt-2" href="customerLogin.jsp">Save 20% on international flights this month!</p>
            </div>
            <div class="col-md-6">
                <img src="images/offer2.jpg" class="img-fluid" alt="Offer 2">
                <p class="mt-2" href="customerLogin.jsp">Special discounts on group bookings!</p>
            </div>
        </div>
    </div>


    <!-- About Section -->
    <div id="about" class="about-section">
        <div class="container">
            <h2>About Us</h2>
            <p>Welcome to our Airline System! We are committed to providing the best travel experience with world-class services and unparalleled comfort. Our goal is to make flying accessible, convenient, and enjoyable for everyone.</p>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <div class="container text-center">
            <p>&copy; 2025 S.P. Airline Reservation System. All Rights Reserved.</p>
            <a href="#about">About Us</a> | <a href="#services">Services</a> | <a href="#offers">Offers</a>
        </div>
    </footer>

    <script src="script.js"></script> <!-- Link to external JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
    <script>
        $(document).ready(function() {
            $(".owl-carousel").owlCarousel({
                loop: true,
                margin: 10,
                nav: false,
                dots: true,
                autoplay: true,
                autoplayTimeout: 3000,
                responsive: {
                    0: { items: 1 },
                    600: { items: 2 },
                    1000: { items: 3 }
                }
            });
        });
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
