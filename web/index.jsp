<%-- 
    Document   : admin.jsp
    Created on : 9 Sept 2025, 11:38:47 pm
    Author     : sidhi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sidhi's Online Store - Home</title>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/main-styles.css">

        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    </head>
    <body>
        <!-- Header with Navigation -->
        <header class="header">
            <div class="container">
                <div class="nav-brand">
                    <i class="fas fa-shopping-cart"></i>
                    <h1>Sidhi's Store</h1>
                </div>

                <!-- Search Bar -->
                <div class="search-container">
                    <i class="fas fa-search search-icon"></i>
                    <input type="text" id="searchInput" placeholder="Search products...">
                    <button type="button" id="searchBtn">Search</button>
                </div>

                <!-- Navigation Links -->
                <nav class="nav-links">
                    <a href="<%= request.getContextPath()%>/index.jsp" class="nav-link active">
                        <i class="fas fa-home"></i>
                        <span>Home</span>
                    </a>
                    <a href="<%= request.getContextPath()%>/cart.jsp" class="nav-link">
                        <i class="fas fa-shopping-cart"></i>
                        <span>Cart</span>
                        <span class="cart-count" id="cartCount">0</span>
                    </a>

                    <a href="#" class="nav-link">
                        <i class="fas fa-box"></i>
                        <span>Orders</span>
                    </a>
                    <a href="#" class="nav-link">
                        <i class="fas fa-map-marker-alt"></i>
                        <span>Addresses</span>
                    </a>
                    <a href="<%= request.getContextPath()%>//login.jsp" class="nav-link">
                        <i class="fas fa-user"></i>
                        <span>Account</span>
                    </a>
                </nav>
            </div>
        </header>

        <!-- Main Content -->
        <main class="main-content">
            <!-- Hero Slider Section -->
            <section class="hero-slider">
                <div class="slider-container">
                    <div class="slide active" data-bg="linear-gradient(135deg, #667eea 0%, #764ba2 100%)">
                        <div class="container">
                            <div class="slide-content">
                                <div class="slide-text">
                                    <span class="slide-badge">New Collection</span>
                                    <h1>Premium Electronics</h1>
                                    <p>Discover the latest in technology with our curated selection of premium electronic devices</p>
                                    <div class="slide-actions">
                                        <a href="#electronics" class="btn-hero primary">Shop Electronics</a>
                                        <a href="#featured" class="btn-hero secondary">View Deals</a>
                                    </div>
                                </div>
                                <div class="slide-image">
                                    <img src="https://images.unsplash.com/photo-1468495244123-6c6c332eeece?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" alt="Electronics" loading="lazy">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="slide" data-bg="linear-gradient(135deg, #f093fb 0%, #f5576c 100%)">
                        <div class="container">
                            <div class="slide-content">
                                <div class="slide-text">
                                    <span class="slide-badge">Fashion Week</span>
                                    <h1>Trendy Clothing</h1>
                                    <p>Step into style with our latest fashion collections designed for the modern lifestyle</p>
                                    <div class="slide-actions">
                                        <a href="#clothing" class="btn-hero primary">Shop Fashion</a>
                                        <a href="#new-arrivals" class="btn-hero secondary">New Arrivals</a>
                                    </div>
                                </div>
                                <div class="slide-image">
                                    <img src="https://images.unsplash.com/photo-1441986300917-64674bd600d8?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" alt="Fashion" loading="lazy">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="slide" data-bg="linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)">
                        <div class="container">
                            <div class="slide-content">
                                <div class="slide-text">
                                    <span class="slide-badge">Home & Garden</span>
                                    <h1>Transform Your Space</h1>
                                    <p>Create your perfect home with our extensive collection of home and garden essentials</p>
                                    <div class="slide-actions">
                                        <a href="#home" class="btn-hero primary">Shop Home</a>
                                        <a href="#bestsellers" class="btn-hero secondary">Best Sellers</a>
                                    </div>
                                </div>
                                <div class="slide-image">
                                    <img src="https://images.unsplash.com/photo-1586023492125-27b2c045efd7?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80" alt="Home" loading="lazy">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Slider Navigation -->
                <button class="slider-btn prev" id="prevSlide">
                    <i class="fas fa-chevron-left"></i>
                </button>
                <button class="slider-btn next" id="nextSlide">
                    <i class="fas fa-chevron-right"></i>
                </button>

                <!-- Slider Indicators -->
                <div class="slider-indicators">
                    <span class="indicator active" data-slide="0"></span>
                    <span class="indicator" data-slide="1"></span>
                    <span class="indicator" data-slide="2"></span>
                </div>
            </section>

            <!-- Quick Stats Section -->
            <section class="stats-section">
                <div class="container">
                    <div class="stats-grid">
                        <div class="stat-item">
                            <div class="stat-icon">
                                <i class="fas fa-users"></i>
                            </div>
                            <div class="stat-content">
                                <h3 class="stat-number" data-target="50000">0</h3>
                                <p>Happy Customers</p>
                            </div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-icon">
                                <i class="fas fa-box"></i>
                            </div>
                            <div class="stat-content">
                                <h3 class="stat-number" data-target="10000">0</h3>
                                <p>Products Sold</p>
                            </div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-icon">
                                <i class="fas fa-star"></i>
                            </div>
                            <div class="stat-content">
                                <h3 class="stat-number" data-target="4.9">0</h3>
                                <p>Average Rating</p>
                            </div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-icon">
                                <i class="fas fa-shipping-fast"></i>
                            </div>
                            <div class="stat-content">
                                <h3 class="stat-number" data-target="24">0</h3>
                                <p>Hour Shipping</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Category Showcase -->
            <section class="categories-section">
                <div class="container">
                    <div class="section-header">
                        <h2>Shop by Category</h2>
                        <p>Explore our wide range of product categories</p>
                    </div>

                    <div class="categories-grid">
                        <div class="category-card" data-category="electronics">
                            <div class="category-image">
                                <img src="https://images.unsplash.com/photo-1498049794561-7780e7231661?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" alt="Electronics" loading="lazy">
                                <div class="category-overlay">
                                    <i class="fas fa-laptop"></i>
                                    <span class="category-count">500+ Items</span>
                                </div>
                            </div>
                            <div class="category-content">
                                <h3>Electronics</h3>
                                <p>Latest gadgets and tech accessories</p>
                                <a href="#electronics" class="category-link">Shop Now <i class="fas fa-arrow-right"></i></a>
                            </div>
                        </div>

                        <div class="category-card" data-category="clothing">
                            <div class="category-image">
                                <img src="https://images.unsplash.com/photo-1445205170230-053b83016050?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" alt="Clothing" loading="lazy">
                                <div class="category-overlay">
                                    <i class="fas fa-tshirt"></i>
                                    <span class="category-count">300+ Items</span>
                                </div>
                            </div>
                            <div class="category-content">
                                <h3>Fashion & Clothing</h3>
                                <p>Trendy outfits for every occasion</p>
                                <a href="#clothing" class="category-link">Shop Now <i class="fas fa-arrow-right"></i></a>
                            </div>
                        </div>

                        <div class="category-card" data-category="books">
                            <div class="category-image">
                                <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" alt="Books" loading="lazy">
                                <div class="category-overlay">
                                    <i class="fas fa-book"></i>
                                    <span class="category-count">1000+ Items</span>
                                </div>
                            </div>
                            <div class="category-content">
                                <h3>Books & Media</h3>
                                <p>Expand your knowledge and imagination</p>
                                <a href="#books" class="category-link">Shop Now <i class="fas fa-arrow-right"></i></a>
                            </div>
                        </div>

                        <div class="category-card" data-category="home">
                            <div class="category-image">
                                <img src="https://images.unsplash.com/photo-1556228453-efd6c1ff04f6?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" alt="Home" loading="lazy">
                                <div class="category-overlay">
                                    <i class="fas fa-home"></i>
                                    <span class="category-count">750+ Items</span>
                                </div>
                            </div>
                            <div class="category-content">
                                <h3>Home & Garden</h3>
                                <p>Everything for your perfect home</p>
                                <a href="#home" class="category-link">Shop Now <i class="fas fa-arrow-right"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Featured Products Section -->
            <section class="featured-section" id="featured">
                <div class="container">
                    <div class="section-header">
                        <h2>Featured Products</h2>
                        <p>Handpicked items just for you</p>
                    </div>

                    <div class="featured-tabs">
                        <button class="tab-btn active" data-tab="bestsellers">Best Sellers</button>
                        <button class="tab-btn" data-tab="new-arrivals">New Arrivals</button>
                        <button class="tab-btn" data-tab="on-sale">On Sale</button>
                    </div>

                    <div class="products-carousel" id="featuredProducts">
                        <!-- Featured products will be loaded here dynamically -->
                    </div>
                </div>
            </section>

            <!-- Newsletter Section -->
            <section class="newsletter-section">
                <div class="container">
                    <div class="newsletter-content">
                        <div class="newsletter-text">
                            <h2>Stay Updated</h2>
                            <p>Subscribe to our newsletter and be the first to know about new products, exclusive deals, and special offers!</p>
                        </div>
                        <div class="newsletter-form">
                            <form id="newsletterForm" class="subscribe-form">
                                <div class="input-group">
                                    <input type="email" id="newsletterEmail" placeholder="Enter your email address" required>
                                    <button type="submit" class="subscribe-btn">
                                        <i class="fas fa-paper-plane"></i>
                                        Subscribe
                                    </button>
                                </div>
                            </form>
                            <div class="newsletter-benefits">
                                <div class="benefit">
                                    <i class="fas fa-percent"></i>
                                    <span>Exclusive Discounts</span>
                                </div>
                                <div class="benefit">
                                    <i class="fas fa-bell"></i>
                                    <span>Early Access</span>
                                </div>
                                <div class="benefit">
                                    <i class="fas fa-gift"></i>
                                    <span>Special Offers</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Testimonials Section -->
            <section class="testimonials-section">
                <div class="container">
                    <div class="section-header">
                        <h2>What Our Customers Say</h2>
                        <p>Real reviews from satisfied customers</p>
                    </div>

                    <div class="testimonials-grid">
                        <div class="testimonial-card">
                            <div class="testimonial-content">
                                <div class="testimonial-rating">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                </div>
                                <p>"Amazing quality products and super fast delivery! I've been shopping here for months and never been disappointed."</p>
                            </div>
                            <div class="testimonial-author">
                                <img src="https://images.unsplash.com/photo-1494790108755-2616b612b993?ixlib=rb-4.0.3&auto=format&fit=crop&w=60&q=80" alt="Customer" loading="lazy">
                                <div class="author-info">
                                    <h4>Sarah Johnson</h4>
                                    <p>Verified Customer</p>
                                </div>
                            </div>
                        </div>

                        <div class="testimonial-card">
                            <div class="testimonial-content">
                                <div class="testimonial-rating">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                </div>
                                <p>"Excellent customer service and a great variety of products. The website is easy to navigate and checkout is seamless."</p>
                            </div>
                            <div class="testimonial-author">
                                <img src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&auto=format&fit=crop&w=60&q=80" alt="Customer" loading="lazy">
                                <div class="author-info">
                                    <h4>Michael Chen</h4>
                                    <p>Verified Customer</p>
                                </div>
                            </div>
                        </div>

                        <div class="testimonial-card">
                            <div class="testimonial-content">
                                <div class="testimonial-rating">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                </div>
                                <p>"Best online shopping experience I've had. High quality products, competitive prices, and outstanding support."</p>
                            </div>
                            <div class="testimonial-author">
                                <img src="https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&auto=format&fit=crop&w=60&q=80" alt="Customer" loading="lazy">
                                <div class="author-info">
                                    <h4>Emily Rodriguez</h4>
                                    <p>Verified Customer</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Filters and Products Section -->
            <section class="filters-section" id="productsSection">
                <div class="container">
                    <div class="section-header">
                        <h2>All Products</h2>
                        <p>Browse our complete collection</p>
                    </div>

                    <div class="filters-container">
                        <div class="filters-sidebar">
                            <div class="filter-group">
                                <h4>Categories</h4>
                                <div class="category-filters">
                                    <label class="filter-checkbox">
                                        <input type="checkbox" value="" checked>
                                        <span class="checkmark"></span>
                                        All Categories
                                    </label>
                                    <label class="filter-checkbox">
                                        <input type="checkbox" value="electronics">
                                        <span class="checkmark"></span>
                                        Electronics
                                    </label>
                                    <label class="filter-checkbox">
                                        <input type="checkbox" value="clothing">
                                        <span class="checkmark"></span>
                                        Clothing
                                    </label>
                                    <label class="filter-checkbox">
                                        <input type="checkbox" value="books">
                                        <span class="checkmark"></span>
                                        Books
                                    </label>
                                    <label class="filter-checkbox">
                                        <input type="checkbox" value="home">
                                        <span class="checkmark"></span>
                                        Home & Garden
                                    </label>
                                </div>
                            </div>

                            <div class="filter-group">
                                <h4>Price Range</h4>
                                <div class="price-slider">
                                    <input type="range" id="priceMin" min="0" max="1000" value="0" class="slider">
                                    <input type="range" id="priceMax" min="0" max="1000" value="1000" class="slider">
                                    <div class="price-values">
                                        <span id="minPrice">$0</span>
                                        <span id="maxPrice">$1000</span>
                                    </div>
                                </div>
                            </div>

                            <div class="filter-group">
                                <h4>Rating</h4>
                                <div class="rating-filters">
                                    <label class="filter-checkbox">
                                        <input type="checkbox" value="5">
                                        <span class="checkmark"></span>
                                        <div class="rating-stars">
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                        </div>
                                    </label>
                                    <label class="filter-checkbox">
                                        <input type="checkbox" value="4">
                                        <span class="checkmark"></span>
                                        <div class="rating-stars">
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="far fa-star"></i>
                                        </div>
                                        & Up
                                    </label>
                                </div>
                            </div>

                            <button class="clear-filters-btn" id="clearFilters">
                                <i class="fas fa-times"></i>
                                Clear All Filters
                            </button>
                        </div>

                        <div class="products-content">
                            <div class="products-toolbar">
                                <div class="products-info">
                                    <span id="productsCount">Showing 1-12 of 156 products</span>
                                </div>
                                <div class="products-controls">
                                    <div class="view-toggle">
                                        <button class="view-btn active" data-view="grid">
                                            <i class="fas fa-th"></i>
                                        </button>
                                        <button class="view-btn" data-view="list">
                                            <i class="fas fa-list"></i>
                                        </button>
                                    </div>
                                    <select id="sortFilter" class="sort-select">
                                        <option value="name">Sort by Name</option>
                                        <option value="price-low">Price: Low to High</option>
                                        <option value="price-high">Price: High to Low</option>
                                        <option value="rating">Highest Rated</option>
                                        <option value="newest">Newest First</option>
                                    </select>
                                </div>
                            </div>

                            <div class="products-grid" id="productsGrid">
                                <!-- Products will be loaded here dynamically -->
                            </div>

                            <!-- Pagination -->
                            <div class="pagination" id="pagination">
                                <button class="page-btn" id="prevPage" disabled>
                                    <i class="fas fa-chevron-left"></i>
                                </button>
                                <div class="page-numbers" id="pageNumbers">
                                    <!-- Page numbers will be generated dynamically -->
                                </div>
                                <button class="page-btn" id="nextPage">
                                    <i class="fas fa-chevron-right"></i>
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Loading indicator -->
                    <div class="loading" id="loading">
                        <i class="fas fa-spinner fa-spin"></i>
                        <p>Loading products...</p>
                    </div>

                    <!-- No products found -->
                    <div class="no-products" id="noProducts" style="display: none;">
                        <div class="no-products-icon">
                            <i class="fas fa-search"></i>
                        </div>
                        <h3>No products found</h3>
                        <p>Try adjusting your search or filters to find what you're looking for</p>
                        <button class="clear-filters-btn" onclick="clearAllFilters()">
                            Clear All Filters
                        </button>
                    </div>
                </div>
            </section>

            <!-- Back to Top Button -->
            <button class="back-to-top" id="backToTop">
                <i class="fas fa-chevron-up"></i>
            </button>
        </main>

        <!-- Footer -->
        <footer class="footer">
            <div class="container">
                <div class="footer-content">
                    <div class="footer-section">
                        <h4>About Sidhi's Store</h4>
                        <p>Your trusted online shopping destination with quality products and excellent service.</p>
                    </div>
                    <div class="footer-section">
                        <h4>Customer Service</h4>
                        <ul>
                            <li><a href="#">Contact Us</a></li>
                            <li><a href="#">FAQ</a></li>
                            <li><a href="#">Returns</a></li>
                            <li><a href="#">Shipping Info</a></li>
                        </ul>
                    </div>
                    <div class="footer-section">
                        <h4>Follow Us</h4>
                        <div class="social-links">
                            <a href="#"><i class="fab fa-facebook"></i></a>
                            <a href="#"><i class="fab fa-twitter"></i></a>
                            <a href="#"><i class="fab fa-instagram"></i></a>
                        </div>
                    </div>
                </div>
                <div class="footer-bottom">
                    <p>&copy; 2024 Sidhi's Online Store. All rights reserved.</p>
                </div>
            </div>
        </footer>

        <!-- Notification container -->
        <div class="notification-container" id="notificationContainer"></div>

        <script src="../main-script.js"></script>
        <script>
            // Product fetching and management
            let allProducts = [];
            let currentCategory = 'all';
            
            // Load products when page loads
            document.addEventListener('DOMContentLoaded', function() {
                loadProducts();
                setupCategoryFilters();
                updateCartCount();
            });

            function loadProducts(category = null) {
                const loading = document.getElementById('loading');
                const grid = document.getElementById('productsGrid');
                const noProducts = document.getElementById('noProducts');
                
                loading.style.display = 'block';
                grid.innerHTML = '';
                noProducts.style.display = 'none';

                let url = '<%= request.getContextPath() %>/products';
                if (category && category !== 'all') {
                    url += '?action=category&category=' + category;
                }

                fetch(url)
                    .then(response => response.json())
                    .then(products => {
                        allProducts = products;
                        displayProducts(products);
                        updateProductsCount(products.length);
                        loading.style.display = 'none';
                    })
                    .catch(error => {
                        console.error('Error loading products:', error);
                        loading.innerHTML = '<p style="color: red;">Failed to load products. Please try again.</p>';
                    });
            }

            function displayProducts(products) {
                const grid = document.getElementById('productsGrid');
                grid.innerHTML = '';

                if (products.length === 0) {
                    document.getElementById('noProducts').style.display = 'block';
                    return;
                }

                products.forEach(product => {
                    const productCard = document.createElement('div');
                    productCard.className = 'product-card';
                    productCard.innerHTML = `
                        <div class="product-image-container">
                            <img src="${getImageUrl(product.imageUrl)}" alt="${product.name}" class="product-image" onerror="this.src='${getDefaultImage()}'">
                            <div class="product-actions">
                                <button class="quick-view-btn" onclick="quickView(${product.id})">
                                    <i class="fas fa-eye"></i>
                                </button>
                                <button class="add-to-cart-btn" onclick="addToCart(${product.id})" ${product.stock <= 0 ? 'disabled' : ''}>
                                    <i class="fas fa-shopping-cart"></i>
                                </button>
                            </div>
                        </div>
                        <div class="product-info">
                            <div class="product-category">${product.category}</div>
                            <h3 class="product-title">${product.name}</h3>
                            <p class="product-description">${product.description || ''}</p>
                            <div class="product-price">$${product.price}</div>
                            <div class="product-stock ${product.stock <= 0 ? 'out-of-stock' : product.stock <= 10 ? 'low-stock' : ''}">
                                ${product.stock <= 0 ? 'Out of Stock' : product.stock <= 10 ? 'Low Stock (' + product.stock + ')' : 'In Stock'}
                            </div>
                        </div>
                    `;
                    grid.appendChild(productCard);
                });
            }

            function setupCategoryFilters() {
                const categoryCards = document.querySelectorAll('.category-card');
                const categoryFilters = document.querySelectorAll('.filter-checkbox input[type="checkbox"]');
                
                // Setup category card clicks
                categoryCards.forEach(card => {
                    card.addEventListener('click', function() {
                        const category = this.dataset.category;
                        if (category) {
                            currentCategory = category;
                            loadProducts(category);
                            // Scroll to products section
                            document.getElementById('productsSection').scrollIntoView({ behavior: 'smooth' });
                        }
                    });
                });
                
                // Setup filter checkboxes
                categoryFilters.forEach(filter => {
                    filter.addEventListener('change', function() {
                        filterProducts();
                    });
                });
            }

            function filterProducts() {
                const categoryFilters = document.querySelectorAll('.category-filters input[type="checkbox"]:checked');
                const selectedCategories = Array.from(categoryFilters).map(f => f.value).filter(v => v);
                
                let filteredProducts = allProducts;
                
                if (selectedCategories.length > 0 && !selectedCategories.includes('')) {
                    filteredProducts = allProducts.filter(product => 
                        selectedCategories.includes(product.category)
                    );
                }
                
                displayProducts(filteredProducts);
                updateProductsCount(filteredProducts.length);
            }

            function addToCart(productId) {
                let cart = JSON.parse(localStorage.getItem('cart') || '[]');
                
                const existingItem = cart.find(item => item.id === productId);
                if (existingItem) {
                    existingItem.quantity += 1;
                } else {
                    const product = allProducts.find(p => p.id === productId);
                    if (product) {
                        cart.push({
                            id: productId,
                            name: product.name,
                            price: product.price,
                            quantity: 1,
                            imageUrl: product.imageUrl
                        });
                    }
                }
                
                localStorage.setItem('cart', JSON.stringify(cart));
                updateCartCount();
                
                // Show notification
                showNotification('Product added to cart!', 'success');
            }

            function quickView(productId) {
                const product = allProducts.find(p => p.id === productId);
                if (product) {
                    alert(`Product: ${product.name}\nPrice: $${product.price}\nCategory: ${product.category}\nStock: ${product.stock}\n\n${product.description || 'No description available'}`);
                }
            }

            function updateCartCount() {
                const cart = JSON.parse(localStorage.getItem('cart') || '[]');
                const count = cart.reduce((sum, item) => sum + item.quantity, 0);
                document.getElementById('cartCount').textContent = count;
            }

            function updateProductsCount(count) {
                const productsCount = document.getElementById('productsCount');
                if (productsCount) {
                    productsCount.textContent = `Showing 1-${count} of ${count} products`;
                }
            }

            function getImageUrl(imageUrl) {
                if (!imageUrl || imageUrl === 'null' || imageUrl.trim() === '') {
                    return getDefaultImage();
                }
                
                if (imageUrl.startsWith('http')) {
                    return imageUrl;
                }
                
                return '<%= request.getContextPath() %>/' + imageUrl;
            }

            function getDefaultImage() {
                return 'https://via.placeholder.com/300x200?text=No+Image';
            }

            function showNotification(message, type = 'info') {
                const container = document.getElementById('notificationContainer');
                const notification = document.createElement('div');
                notification.className = `notification ${type}`;
                notification.innerHTML = `
                    <span>${message}</span>
                    <button onclick="this.parentElement.remove()">&times;</button>
                `;
                container.appendChild(notification);
                
                setTimeout(() => {
                    notification.remove();
                }, 3000);
            }

            function clearAllFilters() {
                const checkboxes = document.querySelectorAll('.filter-checkbox input[type="checkbox"]');
                checkboxes.forEach(cb => cb.checked = cb.value === '');
                loadProducts();
            }
        </script>
        <style>
            .product-card {
                border: 1px solid #ddd;
                border-radius: 8px;
                overflow: hidden;
                transition: transform 0.2s, box-shadow 0.2s;
                background: white;
                margin-bottom: 1rem;
            }
            .product-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            }
            .product-image-container {
                position: relative;
                overflow: hidden;
            }
            .product-image {
                width: 100%;
                height: 200px;
                object-fit: cover;
            }
            .product-actions {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                display: flex;
                gap: 0.5rem;
                opacity: 0;
                transition: opacity 0.2s;
            }
            .product-card:hover .product-actions {
                opacity: 1;
            }
            .quick-view-btn, .add-to-cart-btn {
                padding: 0.5rem;
                border: none;
                border-radius: 50%;
                background: rgba(255,255,255,0.9);
                cursor: pointer;
                transition: background 0.2s;
            }
            .add-to-cart-btn {
                background: #27ae60;
                color: white;
            }
            .add-to-cart-btn:hover {
                background: #219a52;
            }
            .product-info {
                padding: 1rem;
            }
            .product-category {
                background: #3498db;
                color: white;
                padding: 0.25rem 0.5rem;
                border-radius: 4px;
                font-size: 0.8rem;
                display: inline-block;
                margin-bottom: 0.5rem;
            }
            .product-title {
                font-size: 1.1rem;
                font-weight: bold;
                margin-bottom: 0.5rem;
            }
            .product-price {
                color: #e74c3c;
                font-size: 1.2rem;
                font-weight: bold;
                margin: 0.5rem 0;
            }
            .product-stock {
                font-size: 0.9rem;
                color: #27ae60;
            }
            .product-stock.low-stock {
                color: #f39c12;
            }
            .product-stock.out-of-stock {
                color: #e74c3c;
            }
            .notification {
                background: #2ecc71;
                color: white;
                padding: 1rem;
                margin-bottom: 0.5rem;
                border-radius: 4px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .notification.error {
                background: #e74c3c;
            }
            .notification button {
                background: none;
                border: none;
                color: white;
                font-size: 1.2rem;
                cursor: pointer;
            }
        </style>
    </body>
</html>

