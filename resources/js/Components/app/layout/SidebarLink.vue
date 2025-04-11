<template>
    <Link :href="href" class="sidebar-link nav-link d-flex align-items-center" :class="{ active: isActive }">
    <i :class="`bi bi-${icon} me-2 icon`"></i>
    <span v-if="!collapsed">{{ label }}</span>
    </Link>
</template>

<script setup>
import { computed } from 'vue';
import { Link, usePage } from '@inertiajs/vue3';

const props = defineProps({
    href: String,
    icon: String,
    label: String,
    collapsed: Boolean
});

const page = usePage();

const isActive = computed(() => page.url.startsWith(props.href));
</script>

<style scoped>
.sidebar-link {
    color: #4b5563;
    padding: 0.65rem 1rem;
    border-radius: 0.5rem;
    font-weight: 500;
    transition: all 0.3s ease;
    text-decoration: none;
    margin-bottom: 0.25rem;
    white-space: nowrap;
}

.sidebar-link:hover {
    background-color: #e5e7eb;
    color: #111827;
}

.sidebar-link.active {
    background-color: #6366f1;
    color: #ffffff;
    font-weight: 600;
}

.sidebar-link.active .icon {
    color: #ffffff !important;
}

.icon {
    font-size: 1.1rem;
    color: #6b7280;
    transition: color 0.3s ease;
}
</style>