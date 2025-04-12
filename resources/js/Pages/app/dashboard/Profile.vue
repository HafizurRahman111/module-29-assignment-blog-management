<template>
    <DashboardLayout>
        <section class="profile-container min-h-screen py-12 px-6 bg-gradient-to-br from-indigo-100 to-white">
            <div
                class="max-w-4xl mx-auto bg-white shadow-xl rounded-3xl overflow-hidden animate-fadeIn ring-1 ring-indigo-100">
                <!-- Profile Header -->
                <div class="flex flex-col sm:flex-row items-center gap-8 p-10 bg-indigo-50 border-b border-indigo-100">
                    <!-- Profile Image -->
                    <div class="relative group">
                        <img :src="user.profile_pic || 'https://via.placeholder.com/150'" alt="Profile Picture"
                            class="w-28 h-28 rounded-full object-cover border-4 border-indigo-500 shadow-lg group-hover:scale-105 transition-transform duration-300" />
                    </div>

                    <!-- Profile Info -->
                    <div class="flex-1 space-y-2 text-center sm:text-left">
                        <div class="flex items-center justify-center sm:justify-start gap-2">
                            <h1 class="text-3xl font-extrabold text-indigo-700 tracking-tight">{{ user.username }}</h1>
                            <span v-if="user.is_verified" class="text-green-500">
                                <i class="fas fa-check-circle text-lg"></i>
                            </span>
                        </div>
                        <p class="text-gray-600 text-sm">{{ user.email }}</p>
                        <span
                            class="inline-block px-3 py-1 mt-2 bg-indigo-100 text-indigo-700 text-xs rounded-full font-medium shadow-sm">
                            Joined: {{ formatDate(user.created_at) }}
                        </span>
                    </div>
                </div>

                <!-- Profile Details -->
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-6 px-10 py-8 text-sm text-gray-800 bg-white">
                    <div>
                        <h3 class="text-gray-500 font-semibold text-xs uppercase mb-1">Username</h3>
                        <p class="font-medium">{{ user.username }}</p>
                    </div>
                    <div>
                        <h3 class="text-gray-500 font-semibold text-xs uppercase mb-1">Email</h3>
                        <p class="font-medium">{{ user.email }}</p>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="px-10 py-6 bg-gray-50 border-t border-gray-200 flex flex-col sm:flex-row justify-end gap-4">
                    <button @click="editProfile"
                        class="px-6 py-2 bg-indigo-600 text-white font-semibold rounded-lg shadow-md hover:bg-indigo-700 hover:shadow-lg transition-all duration-300 focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:ring-offset-2">
                        Edit Profile
                    </button>
                    <button v-if="canChangePassword" @click="changePassword"
                        class="px-6 py-2 bg-white border border-gray-300 text-gray-700 rounded-lg shadow-sm hover:bg-gray-100 transition-all duration-300 focus:outline-none focus:ring-2 focus:ring-gray-300 focus:ring-offset-1">
                        Change Password
                    </button>
                </div>
            </div>
        </section>
    </DashboardLayout>
</template>

<script setup>
import DashboardLayout from '@/Layouts/DashboardLayout.vue';
import { computed } from 'vue';
import dayjs from 'dayjs';
import relativeTime from 'dayjs/plugin/relativeTime';

dayjs.extend(relativeTime);

const props = defineProps({
    user: Object,
    auth: Object
});

const canChangePassword = computed(() => {
    return props.auth?.user?.id === props.user?.id;
});

function formatDate(date) {
    return date ? dayjs(date).format('MMMM D, YYYY') : 'N/A';
}

function editProfile() {
    // Handle edit profile logic
}

function changePassword() {
    // Handle change password logic
}
</script>

<style scoped>
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(20px);
    }

    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.animate-fadeIn {
    animation: fadeIn 0.6s ease-out both;
}

.profile-container {
    font-family: 'Inter', sans-serif;
    background-color: #f0f4ff;
}
</style>