<template>
    <Link :href="to" class="btn btn-sm btn-outline-primary d-flex align-items-center gap-1">
    <i class="fas fa-edit fs-12"></i>
    <span>Edit</span>
    </Link>
</template>

<script setup>
import { Link } from '@inertiajs/vue3';

defineProps({
    to: { type: String, required: true },
    size: { type: String, default: 'sm' }
});
</script>