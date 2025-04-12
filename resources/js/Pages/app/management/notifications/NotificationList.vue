<template>
    <DashboardLayout title="Notifications">
        <div class="notification-container">
            <div class="notification-header">
                <h3>
                    <i class="fas fa-bell me-2"></i> Notifications
                </h3>
                <button class="btn btn-sm btn-outline-secondary" @click="markAllAsRead"
                    :disabled="loading || unreadCount === 0">
                    Mark all as read
                </button>
            </div>

            <div class="notification-list">
                <div v-if="loading" class="text-center py-4">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>

                <div v-else-if="notifications.length === 0" class="empty-state">
                    <i class="fas fa-bell-slash"></i>
                    <p>No notifications yet</p>
                </div>

                <div v-else>
                    <div v-for="notification in paginatedNotifications" :key="notification.id" class="notification-item"
                        :class="{ 'unread': !notification.read_at }">
                        <div class="notification-icon">
                            <i v-if="notification.type === 'like'" class="fas fa-heart text-danger"></i>
                            <i v-else-if="notification.type === 'comment'" class="fas fa-comment text-primary"></i>
                            <i v-else class="fas fa-info-circle text-info"></i>
                        </div>
                        <div class="notification-content" @click="toggleReadStatus(notification)">
                            <p class="notification-message">
                                <strong class="text-capitalize">[{{ notification.type }}]</strong>
                                {{ notification.message }}
                            </p>
                            <p class="notification-username">
                                From: <strong>{{ notification.user.username || 'System' }}</strong>
                            </p>
                            <small class="notification-time">
                                {{ formatTime(notification.created_at) }}
                                <template v-if="notification.read_at">
                                    | Read: {{ formatTime(notification.read_at) }}
                                </template>
                            </small>
                        </div>
                        <div class="notification-actions">
                            <button class="btn btn-sm"
                                :class="notification.read_at ? 'btn-outline-warning' : 'btn-outline-success'"
                                @click.stop="toggleReadStatus(notification)" :disabled="loading">
                                {{ notification.read_at ? 'Mark as Unread' : 'Mark as Read' }}
                            </button>
                        </div>
                    </div>

                    <div class="pagination-container" v-if="totalPages > 1">
                        <button class="btn btn-sm btn-light" :disabled="currentPage === 1" @click="currentPage--">
                            Previous
                        </button>
                        <span class="mx-2">Page {{ currentPage }} of {{ totalPages }}</span>
                        <button class="btn btn-sm btn-light" :disabled="currentPage === totalPages"
                            @click="currentPage++">
                            Next
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </DashboardLayout>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { createToaster } from '@meforma/vue-toaster';
import DashboardLayout from '@/Layouts/DashboardLayout.vue';
import axios from 'axios';

const props = defineProps({
    notifications: {
        type: Array,
        default: () => [],
    },
});

const notifications = ref([...props.notifications]);
const loading = ref(false);
const toaster = createToaster({ position: 'top-right', duration: 3000 });

const unreadCount = computed(() =>
    notifications.value.filter((n) => !n.read_at).length
);

const currentPage = ref(1);
const notificationsPerPage = 5;

const totalPages = computed(() =>
    Math.ceil(notifications.value.length / notificationsPerPage)
);

const paginatedNotifications = computed(() => {
    const start = (currentPage.value - 1) * notificationsPerPage;
    const end = start + notificationsPerPage;
    return notifications.value.slice(start, end);
});

const fetchNotifications = async () => {
    try {
        loading.value = true;
        const { data } = await axios.get('/notifications');
        notifications.value = data;
    } catch (error) {
        handleError('Failed to load notifications', error);
    } finally {
        loading.value = false;
    }
};

const toggleReadStatus = async (notification) => {
    if (loading.value) return;

    const isRead = !!notification.read_at;
    const endpoint = isRead
        ? `/notifications/${notification.id}/mark-as-unread`
        : `/notifications/${notification.id}/mark-as-read`;

    try {
        loading.value = true;
        await axios.post(endpoint);
        notification.read_at = isRead ? null : new Date().toISOString();
        toaster.success(`Notification ${isRead ? 'marked as unread' : 'marked as read'}`);
    } catch (error) {
        handleError(`Failed to mark notification as ${isRead ? 'unread' : 'read'}`, error);
    } finally {
        loading.value = false;
    }
};

const markAllAsRead = async () => {
    if (loading.value || unreadCount.value === 0) return;

    try {
        loading.value = true;
        await axios.post('/notifications/mark-all-as-read');
        notifications.value = notifications.value.map((n) => ({
            ...n,
            read_at: n.read_at || new Date().toISOString(),
        }));
        toaster.success('All notifications marked as read');
    } catch (error) {
        handleError('Failed to mark all notifications as read', error);
    } finally {
        loading.value = false;
    }
};

const formatTime = (dateString) => {
    const date = new Date(dateString);
    return date.toLocaleString();
};

const handleError = (message, error) => {
    console.error(message, error);
    toaster.error(message);
};

onMounted(() => {
    if (notifications.value.length === 0) {
        fetchNotifications();
    }
});
</script>

<style scoped>
.notification-container {
    max-width: 850px;
    margin: 0 auto;
    padding: 1.5rem;
}

.notification-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1.5rem;
    padding-bottom: 0.5rem;
    border-bottom: 1px solid #e0e0e0;
}

.notification-list {
    background: #fff;
    border-radius: 0.5rem;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
    overflow: hidden;
}

.notification-item {
    display: flex;
    align-items: flex-start;
    padding: 1rem;
    border-bottom: 1px solid #f0f0f0;
    transition: background 0.2s ease;
}

.notification-item.unread {
    background-color: #f9f9f9;
}

.notification-icon {
    width: 42px;
    height: 42px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-right: 1rem;
    font-size: 1.3rem;
    flex-shrink: 0;
}

.notification-content {
    flex: 1;
    cursor: pointer;
}

.notification-message {
    margin-bottom: 0.25rem;
    font-weight: 500;
    color: #212529;
}

.notification-username {
    margin-bottom: 0.25rem;
    font-size: 0.85rem;
    color: #6c757d;
}

.notification-time {
    font-size: 0.8rem;
    color: #adb5bd;
}

.notification-actions {
    display: flex;
    align-items: center;
    margin-left: 1rem;
}

.empty-state {
    text-align: center;
    padding: 3rem 1rem;
    color: #6c757d;
}

.empty-state i {
    font-size: 3rem;
    margin-bottom: 1rem;
    opacity: 0.6;
}

.pagination-container {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 1rem;
}

.visually-hidden {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip: rect(0, 0, 0, 0);
    white-space: nowrap;
    border: 0;
}
</style>
