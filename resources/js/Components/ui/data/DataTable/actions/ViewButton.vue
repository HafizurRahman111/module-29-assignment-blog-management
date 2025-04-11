<template>
    <Link :href="to"
        :class="['btn', `btn-${size}`, outline ? `btn-outline-${color}` : `btn-${color}`, 'd-flex', 'align-items-center', 'gap-1']">
    <i class="fas fa-eye fs-12"></i>
    <span>View</span>
    </Link>
</template>

<script setup>
import { Link } from '@inertiajs/vue3';

defineProps({
    to: { type: String, required: true },
    size: { type: String, default: 'sm' },
    color: { type: String, default: 'secondary' },
    outline: { type: Boolean, default: true }
});
</script>