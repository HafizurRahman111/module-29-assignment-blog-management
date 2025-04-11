<template>
    <nav class="topbar d-flex justify-content-between align-items-center p-2 bg-white shadow-sm">
        <div class="search-bar d-flex align-items-center">
            <input type="text" class="form-control search-input" placeholder="Search..." />
            <i class="bi bi-search fs-4 ms-2 text-muted"></i>
        </div>
        <div class="user-profile d-flex align-items-center">
            <div class="d-flex align-items-center me-3">
                <img src="https://via.placeholder.com/40" alt="User Avatar" class="user-avatar rounded-circle me-2" />
                <div class="user-info">
                    <span class="fw-semibold">John Doe</span>
                    <span class="text-muted small">Admin</span>
                </div>
            </div>
            <div class="dropdown" ref="dropdown">
                <button class="btn btn-link text-dark dropdown-toggle d-flex align-items-center" type="button"
                    id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="bi bi-chevron-down fs-5 me-2"></i>
                </button>
                <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 rounded-3 p-2">
                    <li><a class="dropdown-item d-flex align-items-center" href="/profile">
                            <i class="bi bi-person-circle fs-5 me-2"></i>Profile
                        </a></li>
                    <li><a class="dropdown-item d-flex align-items-center" href="/settings">
                            <i class="bi bi-gear-fill fs-5 me-2"></i>Settings
                        </a></li>
                    <li>
                        <hr class="dropdown-divider" />
                    </li>
                    <li><a class="dropdown-item d-flex align-items-center" href="/logout">
                            <i class="bi bi-box-arrow-right fs-5 me-2"></i>Logout
                        </a></li>
                </ul>
            </div>
        </div>
    </nav>
</template>

<script setup>
import { onMounted, ref } from 'vue';

const dropdown = ref(null);

onMounted(() => {
    // Ensure the dropdown element is initialized
    if (dropdown.value) {
        const dropdownElement = dropdown.value.querySelector('.dropdown-toggle');
        // Initialize Bootstrap dropdown
        new bootstrap.Dropdown(dropdownElement);
    }
});
</script>


<style scoped>
.topbar {
    position: sticky;
    top: 0;
    z-index: 1000;
    background-color: #ffffff;
    border-bottom: 1px solid #e5e7eb;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.search-bar {
    display: flex;
    align-items: center;
    width: 250px;
    max-width: 250px;
}

.search-input {
    border-radius: 25px;
    border: 1px solid #e5e7eb;
    padding: 0.5rem 1rem;
    font-size: 14px;
    transition: border-color 0.3s;
}

.search-input:focus {
    border-color: #4f46e5;
}

.user-profile {
    display: flex;
    align-items: center;
}

.user-avatar {
    width: 40px;
    height: 40px;
    object-fit: cover;
    border-radius: 50%;
    border: 2px solid #4f46e5;
    transition: border-color 0.3s;
}

.user-avatar:hover {
    border-color: #4f46e5;
}

.user-info {
    display: flex;
    flex-direction: column;
    margin-left: 8px;
}

.dropdown-menu {
    min-width: 200px;
    border-radius: 8px;
    box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
}

.dropdown-item {
    padding: 0.5rem 1rem;
    font-size: 15px;
    transition: background-color 0.3s ease;
}

.dropdown-item:hover {
    background-color: #f3f4f6;
    color: #4f46e5;
}

.dropdown-toggle {
    background: transparent;
    border: none;
    color: #4f46e5;
    transition: color 0.3s ease;
}

.dropdown-toggle:hover {
    color: #1f2937;
}
</style>
