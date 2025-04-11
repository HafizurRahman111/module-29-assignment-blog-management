<template>
    <aside :class="['sidebar-nav', { collapsed }]">
        <div class="sidebar-content">
            <div class="sidebar-header">
                <div v-if="!collapsed" class="sidebar-title">
                    <i class="bi bi-speedometer2 fs-4 text-primary me-2"></i>
                    <span class="fw-bold fs-5 text-light">Dashboard</span>
                </div>
                <button @click="toggleSidebar" class="toggle-btn" :title="collapsed ? 'Expand' : 'Collapse'">
                    <i :class="collapsed ? 'bi bi-chevron-right' : 'bi bi-chevron-left'"></i>
                </button>
            </div>

            <nav class="nav flex-column">
                <SidebarLink href="/dashboard" icon="house-door" label="Dashboard" :collapsed="collapsed" />
                <SidebarLink href="/users" icon="people" label="Users" :collapsed="collapsed" />
                <SidebarLink href="/posts" icon="file-earmark-text" label="Posts" :collapsed="collapsed" />
                <SidebarLink href="/dashboard/tags" icon="tags" label="Tags" :collapsed="collapsed" />
                <SidebarLink href="/dashboard/comments" icon="chat-dots" label="Comments" :collapsed="collapsed" />
                <SidebarLink href="/dashboard/bookmarks" icon="bookmark-star" label="Bookmarks"
                    :collapsed="collapsed" />
            </nav>
        </div>

        <form @submit.prevent="logout" class="logout-form">
            <button type="submit" class="logout-button" :title="collapsed ? 'Logout' : ''">
                <i class="bi bi-box-arrow-right me-2"></i>
                <span v-if="!collapsed">Logout</span>
            </button>
        </form>
    </aside>
</template>

<script setup>
import { computed, watch, onMounted } from 'vue';
import SidebarLink from './SidebarLink.vue';
import { router } from '@inertiajs/vue3';

const props = defineProps({
    collapsed: Boolean
});
const emit = defineEmits(['toggle']);

const collapsed = computed({
    get: () => props.collapsed,
    set: (val) => {
        emit('toggle', val);
        localStorage.setItem('sidebar-collapsed', val);
    }
});

const toggleSidebar = () => {
    collapsed.value = !collapsed.value;
};

onMounted(() => {
    emit('toggle', localStorage.getItem('sidebar-collapsed') === 'true');
});

const logout = () => {
    router.post('/logout');
};
</script>

<style scoped>
.sidebar-nav {
    width: 260px;
    min-height: 100vh;
    background-color: #2f3542;
    border-right: 1px solid #404756;
    padding: 1.5rem 1rem;
    box-shadow: 2px 0 10px rgba(0, 0, 0, 0.08);
    display: flex;
    flex-direction: column;
    position: fixed;
    top: 0;
    left: 0;
    transition: all 0.3s ease;
}

.sidebar-nav.collapsed {
    width: 80px;
    padding: 1.5rem 0.5rem;
}

.sidebar-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 2rem;
}

.toggle-btn {
    background: transparent;
    border: none;
    color: #dfe4ea;
    font-size: 1.2rem;
    cursor: pointer;
    padding: 4px 8px;
    border-radius: 6px;
    transition: background-color 0.2s ease;
}

.toggle-btn:hover {
    background-color: #3b4252;
}

.nav .nav-link {
    color: #dfe4ea;
}

.nav .nav-link:hover {
    background-color: #3b4252;
    color: #ffffff;
}

.logout-form {
    margin-top: auto;
    padding-top: 1rem;
}

.logout-button {
    background-color: #e74c3c;
    color: #fff;
    padding: 0.7rem 1rem;
    border: none;
    border-radius: 0.375rem;
    width: 100%;
    font-weight: 500;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background-color 0.3s ease;
}

.logout-button:hover {
    background-color: #c0392b;
}

.text-light {
    color: #f1f2f6 !important;
}
</style>