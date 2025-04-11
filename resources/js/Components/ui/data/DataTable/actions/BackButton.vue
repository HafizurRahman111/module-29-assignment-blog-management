<template>
    <Link :href="to" class="btn btn-sm btn-outline-secondary d-flex align-items-center gap-1">
    <i class="fas fa-arrow-left fs-12"></i>
    <span>Back</span>
    </Link>
</template>

<script setup>
import { Link } from '@inertiajs/vue3';

defineProps({
    to: { type: String, default: '/' },
    size: { type: String, default: 'sm' }
});
</script>