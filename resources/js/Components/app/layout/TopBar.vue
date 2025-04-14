<template>
    <nav class="topbar d-flex justify-content-between align-items-center p-2 bg-white shadow-sm">
        <!-- Search Bar -->
        <div class="search-bar d-flex align-items-center">
            <input type="text" class="form-control search-input" placeholder="Search..." />
            <i class="bi bi-search fs-4 ms-2 text-muted"></i>
        </div>

        <!-- Right Section: Notification + Profile -->
        <div class="d-flex align-items-center">
            <!-- Notification Dropdown -->
            <div class="dropdown me-3" ref="notificationDropdown">
                <button class="btn btn-link text-dark position-relative" type="button" data-bs-toggle="dropdown"
                    :aria-label="unreadNotifications.length > 0 ? 'You have unread notifications' : 'No unread notifications'">
                    <!-- Bell Icon -->
                    <i class="bi bi-bell-fill fs-4"></i>
                    <!-- Badge for unread notifications -->
                    <span v-if="unreadNotifications.length"
                        class="position-absolute top-0 start-200 badge rounded-pill bg-danger"
                        :style="{ transform: 'translate(-70%, -0%)' }">
                        {{ unreadNotifications.length }}
                    </span>
                </button>
                <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 rounded-3 p-3" style="max-width: 350px;">
                    <!-- No notifications message -->
                    <li v-if="unreadNotifications.length === 0" class="dropdown-item text-muted text-center">
                        No new notifications
                    </li>

                    <!-- Loop through notifications -->
                    <li v-for="(notification, index) in unreadNotifications.slice(0, 3)" :key="index"
                        class="dropdown-item d-flex align-items-start">
                        <div class="notification-item w-100">
                            <!-- Title and Type -->
                            <div class="d-flex justify-content-between mb-2">
                                <strong class="notification-title">{{ notification.title }}</strong>
                                <span class="badge bg-primary text-white small">{{ notification.type }}</span>
                            </div>

                            <!-- Message and Timestamp -->
                            <p class="mb-0 small text-muted">{{ truncateMessage(notification.message, 5) }}</p>
                            <small class="text-muted">{{ formatRelativeTime(notification.created_at) }}</small>
                        </div>
                    </li>

                    <!-- Divider -->
                    <li>
                        <hr class="dropdown-divider" />
                    </li>

                    <!-- View All Link -->
                    <li>
                        <a href="/notifications" class="dropdown-item text-center text-primary">
                            <small>View All</small>
                        </a>
                    </li>
                </ul>

            </div>

            <!-- User Profile Dropdown -->
            <div class="user-profile d-flex align-items-center">
                <div class="d-flex align-items-center me-3">
                    <img :src="user.profile_pic ? `/${user.profile_pic}` : `https://api.dicebear.com/7.x/initials/svg?seed=${user.username}`"
                        alt="User Avatar" class="user-avatar rounded-circle me-2" />

                    <div class="user-info">
                        <span v-if="user" class="fw-semibold">{{ user.username }}</span>

                        <!-- <span class="text-muted small">{{ user.role ?? 'User' }}</span> -->
                    </div>
                </div>
                <div class="dropdown" ref="userDropdown">
                    <button class="btn btn-link text-dark dropdown-toggle d-flex align-items-center" type="button"
                        data-bs-toggle="dropdown">
                        <i class="bi bi-chevron-down fs-5 me-2"></i>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 rounded-3 p-2">
                        <li><a class="dropdown-item d-flex align-items-center" href="/dashboard/profile">
                                <i class="bi bi-person-circle fs-5 me-2"></i>Profile
                            </a></li>
                        <li><a class="dropdown-item d-flex align-items-center" href="/dashboard/settings">
                                <i class="bi bi-gear-fill fs-5 me-2"></i>Settings
                            </a></li>
                        <li>
                            <hr class="dropdown-divider" />
                        </li>
                        <li>
                            <Link href="/logout" method="post" as="button"
                                class="dropdown-item d-flex align-items-center text-danger">
                            <i class="bi bi-box-arrow-right fs-5 me-2"></i>
                            Logout
                            </Link>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { Link, usePage } from '@inertiajs/vue3';
import dayjs from 'dayjs';
import relativeTime from 'dayjs/plugin/relativeTime';
dayjs.extend(relativeTime);

const { user } = usePage().props.auth;
const unreadNotifications = ref(usePage().props.notifications.unreadNotifications || []);
const isLoading = ref(true);

console.log(user);

function formatRelativeTime(date) {
    return dayjs(date).fromNow();
}

function truncateMessage(message, wordLimit) {
    let words = message.split(' ');
    if (words.length > wordLimit) {
        return words.slice(0, wordLimit).join(' ') + '...';
    }
    return message;
}

// Fetch notifications from the backend API
const fetchNotifications = async () => {
    console.log("Starting to fetch notifications...");
    isLoading.value = true; // Set loading to true at the start

    try {
        // Fetch notifications from your backend (replace '/notifications-fetch' with your actual API route)
        const response = await fetch('/notifications-fetch'); // Adjust the URL accordingly

        // Check if the response is ok (status 200-299)
        if (!response.ok) {
            throw new Error(`Failed to fetch notifications. Status: ${response.status}`);
        }

        const data = await response.json(); // Parse the JSON response
        console.log("Parsed response data:", data);

        // Ensure the data is an array and filter unread notifications
        if (Array.isArray(data)) {
            const filteredNotifications = data.filter(n => n.read_at === null);
            console.log("Unread notifications:", filteredNotifications);
            unreadNotifications.value = filteredNotifications; // Update ref value directly
        } else {
            console.error("Fetched data is not an array:", data);
        }
    } catch (error) {
        console.error('Error fetching notifications:', error);
        // Optionally, set an error state here to display an error message in the UI
    } finally {
        isLoading.value = false; // Mark loading as complete
        console.log("Loading complete:", isLoading.value);
    }
};

// Fetch notifications when the component is mounted
onMounted(() => {
    console.log("Component mounted. Fetching notifications...");
    fetchNotifications();
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

.badge {
    font-size: 0.7rem;
    padding: 0.35em 0.5em;
}

.notification-title {
    font-weight: 600;
    font-size: 1rem;
}

.notification-title {
    font-weight: 600;
    font-size: 1rem;
    color: #333;
}

/* Notification Item */
.notification-item {
    padding: 0.75rem 0;
    border-bottom: 1px solid #f0f0f0;
}

/* Small Badge */
.notification-item .badge {
    font-size: 0.75rem;
    padding: 0.25rem 0.5rem;
    border-radius: 1rem;
}

/* Adjusting Text and Spacing */
.dropdown-item {
    font-size: 0.875rem;
    padding: 0.5rem 1rem;
}

/* Message Text */
.text-muted {
    font-size: 0.85rem;
    color: #6c757d;
}

/* View All link */
.dropdown-item.text-center.text-primary {
    font-weight: 600;
    color: #007bff;
    text-decoration: none;
}

.dropdown-item.text-center.text-primary:hover {
    text-decoration: underline;
}

/* Custom divider style */
.dropdown-divider {
    margin: 0.5rem 0;
}
</style>