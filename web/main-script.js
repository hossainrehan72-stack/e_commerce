// Basic functionality for main pages
document.addEventListener('DOMContentLoaded', function() {
    
    // Simple search functionality
    const searchBtn = document.getElementById('searchBtn');
    const searchInput = document.getElementById('searchInput');
    
    if (searchBtn && searchInput) {
        searchBtn.addEventListener('click', function() {
            const query = searchInput.value.trim();
            if (query) {
                alert('Search functionality coming soon! You searched for: ' + query);
            }
        });
        
        // Search on Enter key
        searchInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                searchBtn.click();
            }
        });
    }
    
    // Simple cart functionality
    let cartCount = 0;
    const cartCountElement = document.getElementById('cartCount');
    
    // Update cart count display
    function updateCartCount() {
        if (cartCountElement) {
            cartCountElement.textContent = cartCount;
        }
    }
    
    // Initialize cart page if we're on it
    if (window.location.pathname.includes('cart.jsp')) {
        initializeCartPage();
    }
    
    updateCartCount();
});


function showUsers() {
    const section = document.getElementById("usersSection");
    section.style.display = "block";

    // Clear existing rows except header
    const table = document.getElementById("usersTable");
    table.innerHTML = `<tr>
        <th>ID</th>
        <th>Username</th>
        <th>Email</th>
        <th>Role</th>
    </tr>`;

    // AJAX request to fetch users
    const xhr = new XMLHttpRequest();
    xhr.open("GET", "fetchUsers.jsp", true); // JSP file that returns user data
    xhr.onload = function() {
        if (this.status === 200) {
            const users = JSON.parse(this.responseText); // Expecting JSON array
            users.forEach(user => {
                const row = table.insertRow();
                row.insertCell(0).innerText = user.id;
                row.insertCell(1).innerText = user.username;
                row.insertCell(2).innerText = user.email;
                row.insertCell(3).innerText = user.role;
            });
        }
    };
    xhr.send();
}


// Initialize cart page functionality
function initializeCartPage() {
    const emptyCart = document.getElementById('emptyCart');
    const cartItemsList = document.getElementById('cartItemsList');
    const cartSummary = document.getElementById('cartSummary');
    const cartActions = document.getElementById('cartActions');
    const cartItemsCount = document.getElementById('cartItemsCount');
    
    // Show empty cart state
    if (emptyCart) {
        emptyCart.style.display = 'flex';
    }
    
    if (cartItemsList) {
        cartItemsList.style.display = 'none';
    }
    
    if (cartSummary) {
        cartSummary.style.display = 'none';
    }
    
    if (cartActions) {
        cartActions.style.display = 'none';
    }
    
    if (cartItemsCount) {
        cartItemsCount.textContent = 'You have 0 items in your cart';
    }
}
