<template>
    <DashboardLayout>
        <div class="dashboard-index">
            <PageTitle title="Welcome to Dashboard" :breadcrumb="[
                { label: '', link: '' }
            ]" />

            <div class="row">
                <DashboardCard v-for="(stat, index) in stats" :key="index" :icon="stat.icon" :title="stat.title"
                    :count="stat.count" :color="stat.color" class="animated-card dashboard-card" />
            </div>
        </div>
    </DashboardLayout>
</template>

<script setup>
import DashboardCard from '../../../Components/app/dashboard/DashboardCard.vue';
import PageTitle from '../../../Components/app/dashboard/PageTitle.vue';
import DashboardLayout from '@/Layouts/DashboardLayout.vue';

const stats = [
    { icon: 'people', title: 'Users', count: 128, color: 'primary' },
    { icon: 'file-earmark-text', title: 'Posts', count: 342, color: 'success' },
    { icon: 'tags', title: 'Tags', count: 58, color: 'info' },
    { icon: 'chat-dots', title: 'Comments', count: 956, color: 'warning' },
    { icon: 'bookmark-star', title: 'Bookmarks', count: 42, color: 'danger' },
];
</script>

<style scoped>
.dashboard-index {
    padding: .5rem;
    background-color: #f4f6f9;
    transition: all 0.3s ease-in-out;
}

h1 {
    font-size: 2rem;
    font-weight: bold;
    color: #4f46e5;
    margin-bottom: 2rem;
    transition: font-size 0.3s ease;
}

.animated-card {
    animation: fadeIn 0.5s ease-out;
}

@keyframes fadeIn {
    0% {
        opacity: 0;
        transform: translateY(10px);
    }

    100% {
        opacity: 1;
        transform: translateY(0);
    }
}

.row {
    display: flex;
    flex-wrap: wrap;
    gap: 1.5rem 0;
    justify-content: flex-start;
}

.dashboard-card {
    flex: 1 0 calc(25% - .5rem);
    max-width: calc(25% - .5rem);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    box-sizing: border-box;
}

.dashboard-card:hover {
    transform: translateY(-10px);
    /* box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1); */
}

/* Mobile responsiveness */
@media (max-width: 768px) {
    .dashboard-card {
        max-width: calc(50% - 1rem);

    }
}

@media (max-width: 576px) {
    .dashboard-card {
        max-width: 100%;
    }
}
</style>
