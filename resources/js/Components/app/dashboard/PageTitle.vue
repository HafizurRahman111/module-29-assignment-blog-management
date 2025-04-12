<template>
    <div class="page-title-container d-flex justify-content-between align-items-center">
        <!-- Title on the Left -->
        <h1 class="mb-0 fw-bold text-primary">
            {{ title }}
        </h1>

        <!-- Optional Breadcrumb on the Right -->
        <nav v-if="breadcrumb && breadcrumb.length > 0" class="ml-auto">
            <ol class="breadcrumb mb-0">
                <!-- Dashboard breadcrumb always included as the first item -->
                <li class="breadcrumb-item">
                    <a href="/dashboard" class="breadcrumb-link">Dashboard</a>
                </li>
                <!-- Loop through the breadcrumb array and render the rest -->
                <li v-for="(crumb, index) in breadcrumb" :key="index" class="breadcrumb-item"
                    :class="{ active: index === breadcrumb.length - 1 }">
                    <a v-if="!crumb.active" :href="crumb.link" class="breadcrumb-link">{{ crumb.label }}</a>
                    <span v-else>{{ crumb.label }}</span>
                </li>
            </ol>
        </nav>
    </div>
</template>

<script setup>
defineProps({
    title: {
        type: String,
        required: true,
    },
    breadcrumb: {
        type: Array,
        default: () => [],
    },
});
</script>

<style scoped>
.page-title-container {
    margin-bottom: 1.5rem;
    padding: 10px;
    background: #f7f9fc;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.page-title-container h1 {
    font-size: 1.2rem;
    font-weight: bold;
    color: #4f46e5;
    margin: 0;
}

.breadcrumb {
    background-color: transparent;
    padding: 0;
    font-size: 1rem;
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    margin: 0;
}

.breadcrumb-item {
    display: inline-block;
}

.breadcrumb-item+.breadcrumb-item::before {
    content: ">";
    margin: 0 0.5rem;
    color: #6c757d;
}

.breadcrumb-item a {
    text-decoration: none;
    color: #007bff;
    transition: color 0.3s ease;
}

.breadcrumb-item a:hover {
    color: #0056b3;
}

.breadcrumb-item.active {
    color: #6c757d;
    font-weight: bold;
}

.breadcrumb-link {
    font-size: 1rem;
    font-weight: normal;
    color: #007bff;
    transition: color 0.3s ease;
}

.breadcrumb-link:hover {
    color: #0056b3;
}

@media (max-width: 768px) {
    .page-title-container {
        flex-direction: column;
        text-align: center;
    }

    .page-title-container h1 {
        font-size: 1.8rem;
    }

    .breadcrumb {
        font-size: 0.9rem;
        justify-content: center;
    }
}
</style>
