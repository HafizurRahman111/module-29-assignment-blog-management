<template>
    <div class="dashboard-layout d-flex">
        <SidebarNav :collapsed="collapsed" @toggle="handleToggle" />
        <div class="content" :class="{ 'collapsed-content': collapsed }">
            <TopBar />
            <main class="main-content p-2">
                <slot />
            </main>
        </div>
    </div>
</template>

<script setup>
import { ref } from 'vue';
import SidebarNav from '../Components/app/layout/SidebarNav.vue';
import TopBar from '../Components/app/layout/TopBar.vue';

const collapsed = ref(false);

const handleToggle = (value) => {
    collapsed.value = value;
};
</script>

<style scoped>
.dashboard-layout {
    display: flex;
    height: 100vh;
    overflow: hidden;
}

.content {
    transition: margin-left 0.3s ease;
    margin-left: 260px;
    flex-grow: 1;
    display: flex;
    flex-direction: column;
}

.content.collapsed-content {
    margin-left: 80px;
}

.main-content {
    background-color: #f8f9fa;
    overflow-y: auto;
    height: 100%;
}
</style>