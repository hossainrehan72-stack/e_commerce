// Basic functionality for login page
document.addEventListener('DOMContentLoaded', function() {
    // Password toggle functionality
    const passwordToggle = document.getElementById('passwordToggle');
    const passwordInput = document.getElementById('password');
    
    if (passwordToggle && passwordInput) {
        passwordToggle.addEventListener('click', function() {
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            
            // Toggle icon
            const icon = this.querySelector('i');
            if (icon) {
                icon.classList.toggle('fa-eye');
                icon.classList.toggle('fa-eye-slash');
            }
        });
    }
    
    // Form validation
    const loginForm = document.getElementById('loginForm');
    if (loginForm) {
        loginForm.addEventListener('submit', function(e) {
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            
            if (!email || !password) {
                alert('Please fill in all fields');
                e.preventDefault();
            }
        });
    }
});

// Toggle admin key field in register form
function toggleKeyField() {
    const roleSelect = document.getElementById('role');
    const keyField = document.getElementById('keyField');
    
    if (roleSelect && keyField) {
        if (roleSelect.value === 'admin') {
            keyField.style.display = 'block';
        } else {
            keyField.style.display = 'none';
        }
    }
}
