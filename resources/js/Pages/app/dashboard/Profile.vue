<template>
    <DashboardLayout>
        <div class="profile-container bg-light">
            <div class="container py-2">
                <!-- Profile Card -->
                <div class="card shadow-sm border-0 overflow-hidden mb-4">
                    <!-- Profile Header with Gradient -->
                    <div class="profile-header bg-primary text-white position-relative">
                        <div class="container py-4">
                            <div class="row align-items-center">
                                <!-- Profile Image -->
                                <div class="col-auto">
                                    <div class="position-relative">
                                        <img :src="user.profile_pic ? `/${user.profile_pic}` : `https://api.dicebear.com/7.x/initials/svg?seed=${user.username}`"
                                            alt="Profile"
                                            class="rounded-circle border border-4 border-white shadow profile-img"
                                            @error="handleImageError">
                                        <span v-if="user.email_verified_at"
                                            class="position-absolute bottom-0 end-0 bg-white rounded-circle p-1 shadow-sm">
                                            <i class="fas fa-check-circle text-primary"></i>
                                        </span>
                                    </div>
                                </div>

                                <!-- Profile Info -->
                                <div class="col text-center text-md-start mt-3 mt-md-0">
                                    <h1 class="h2 mb-1 fw-bold">{{ user.username }}</h1>
                                    <p class="mb-2 opacity-75">{{ user.email }}</p>
                                    <div class="d-flex flex-wrap justify-content-center justify-content-md-start gap-2">
                                        <span class="badge bg-white bg-opacity-10">
                                            <i class="fas fa-calendar-alt me-1"></i>
                                            Joined {{ formatDate(user.created_at) }}
                                        </span>
                                        <span class="badge bg-white bg-opacity-10">
                                            <i class="fas fa-clock me-1"></i>
                                            Last active {{ formatRelativeDate(user.last_login) }}
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Profile Details -->
                    <div class="card-body">
                        <div class="row g-4">
                            <div class="col-md-6">
                                <div class="p-3 bg-light rounded-3 h-100">
                                    <h3 class="h6 text-uppercase text-muted mb-3">Account Details</h3>
                                    <ul class="list-unstyled mb-0">
                                        <li class="mb-2">
                                            <span class="d-block text-muted small">Username</span>
                                            <span class="fw-medium">{{ user.username }}</span>
                                        </li>
                                        <li class="mb-2">
                                            <span class="d-block text-muted small">Email</span>
                                            <span class="fw-medium">{{ user.email }}</span>
                                        </li>
                                        <li>
                                            <span class="d-block text-muted small">Account Status</span>
                                            <span class="badge bg-success bg-opacity-10 text-success">
                                                <span class="dot bg-success me-1"></span>
                                                Active
                                            </span>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="p-3 bg-light rounded-3 h-100">
                                    <h3 class="h6 text-uppercase text-muted mb-3">Activity</h3>
                                    <ul class="list-unstyled mb-0">
                                        <li class="mb-2">
                                            <span class="d-block text-muted small">Member Since</span>
                                            <span class="fw-medium">{{ formatFullDate(user.created_at) }}</span>
                                        </li>
                                        <li class="mb-2">
                                            <span class="d-block text-muted small">Last Login</span>
                                            <span class="fw-medium">{{ user.last_login ? formatDateTime(user.last_login)
                                                : 'Never' }}</span>
                                        </li>
                                        <li>
                                            <span class="d-block text-muted small">User ID</span>
                                            <span class="fw-medium text-muted">#{{ user.id }}</span>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="card-footer bg-white border-top py-3">
                        <div class="d-flex flex-wrap justify-content-end gap-2">
                            <button @click="editProfile" class="btn btn-primary px-4 py-2 d-flex align-items-center">
                                <i class="fas fa-edit me-2"></i>
                                Edit Profile
                            </button>
                            <button v-if="canChangePassword" @click="changePassword"
                                class="btn btn-outline-secondary px-4 py-2 d-flex align-items-center">
                                <i class="fas fa-key me-2"></i>
                                Change Password
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Stats Cards -->
                <div class="row g-4">
                    <div class="col-md-4">
                        <div class="card h-100 border-0 shadow-sm hover-lift">
                            <div class="card-body text-center">
                                <div class="icon-lg bg-primary bg-opacity-10 text-primary rounded-circle mb-3 mx-auto">
                                    <i class="fas fa-tasks"></i>
                                </div>
                                <h3 class="mb-1">24</h3>
                                <p class="text-muted mb-0">Completed Tasks</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="card h-100 border-0 shadow-sm hover-lift">
                            <div class="card-body text-center">
                                <div class="icon-lg bg-success bg-opacity-10 text-success rounded-circle mb-3 mx-auto">
                                    <i class="fas fa-project-diagram"></i>
                                </div>
                                <h3 class="mb-1">5</h3>
                                <p class="text-muted mb-0">Active Projects</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="card h-100 border-0 shadow-sm hover-lift">
                            <div class="card-body text-center">
                                <div class="icon-lg bg-info bg-opacity-10 text-info rounded-circle mb-3 mx-auto">
                                    <i class="fas fa-calendar-check"></i>
                                </div>
                                <h3 class="mb-1">{{ user.created_at ? formatYear(user.created_at) : 'N/A' }}</h3>
                                <p class="text-muted mb-0">Member Since</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </DashboardLayout>
</template>

<script setup>
import DashboardLayout from '@/Layouts/DashboardLayout.vue';
import { computed } from 'vue';
import dayjs from 'dayjs';
import relativeTime from 'dayjs/plugin/relativeTime';
import localizedFormat from 'dayjs/plugin/localizedFormat';

dayjs.extend(relativeTime);
dayjs.extend(localizedFormat);

const props = defineProps({
    user: {
        type: Object,
        required: true,
        default: () => ({
            id: null,
            username: 'Anonymous',
            email: '',
            profile_pic: null,
            is_verified: false,
            created_at: null,
            last_login: null
        })
    },
    auth: {
        type: Object,
        required: true
    }
});

const canChangePassword = computed(() => {
    // More robust check for user IDs
    return props.auth?.user?.id && props.user?.id &&
        props.auth.user.id === props.user.id;
});

function handleImageError(e) {
    const fallbackSeed = props.user?.username || 'Anonymous';
    e.target.src = `https://api.dicebear.com/7.x/initials/svg?seed=${encodeURIComponent(fallbackSeed)}`;
    e.target.onerror = null; // Prevent infinite loop if fallback also fails
}

// Date formatting functions with better error handling
function formatDate(date) {
    try {
        return date && dayjs(date).isValid() ? dayjs(date).format('MMM YYYY') : 'N/A';
    } catch {
        return 'N/A';
    }
}

function formatFullDate(date) {
    try {
        return date && dayjs(date).isValid() ? dayjs(date).format('LL') : 'N/A';
    } catch {
        return 'N/A';
    }
}

function formatRelativeDate(date) {
    try {
        return date && dayjs(date).isValid() ? dayjs(date).fromNow() : 'Never';
    } catch {
        return 'Never';
    }
}

function formatDateTime(date) {
    try {
        return date && dayjs(date).isValid() ? dayjs(date).format('lll') : 'N/A';
    } catch {
        return 'N/A';
    }
}

function formatYear(date) {
    try {
        return date && dayjs(date).isValid() ? dayjs(date).format('YYYY') : 'N/A';
    } catch {
        return 'N/A';
    }
}

// Navigation functions with route safety checks
function editProfile() {
    // Example with safety check:
    // if (canEditProfile.value) {
    //   router.push({ name: 'profile.edit' });
    // }
    console.log('Edit profile clicked');
}

function changePassword() {
    // Example with safety check:
    // if (canChangePassword.value) {
    //   router.push({ name: 'password.change' });
    // }
    console.log('Change password clicked');
}
</script>

<style scoped>
.profile-container {
    min-height: 100vh;
}

.profile-header {
    background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
}

.profile-img {
    width: 150px;
    height: 150px;
    object-fit: cover;
    transition: transform 0.3s ease;
}

.profile-img:hover {
    transform: scale(1.05);
}

.dot {
    display: inline-block;
    width: 8px;
    height: 8px;
    border-radius: 50%;
}

.icon-lg {
    width: 56px;
    height: 56px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.5rem;
}

.hover-lift {
    transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.hover-lift:hover {
    transform: translateY(-5px);
    box-shadow: 0 0.5rem 1.5rem rgba(0, 0, 0, 0.1) !important;
}

/* Responsive adjustments */
@media (max-width: 767.98px) {
    .profile-img {
        width: 80px;
        height: 80px;
    }
}
</style>