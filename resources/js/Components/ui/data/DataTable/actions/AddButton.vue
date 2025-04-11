<template>
    <Link :href="to" class="btn btn-sm btn-success d-flex align-items-center gap-1">
    <i class="fas fa-plus fs-12"></i>
    <span>Add New</span>
    </Link>
</template>

<script setup>
import { Link } from '@inertiajs/vue3';

defineProps({
    to: { type: String, required: true },
    size: { type: String, default: 'sm' }
});
</script>