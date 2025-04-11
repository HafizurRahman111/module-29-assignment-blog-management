<template>
    <button class="btn btn-sm btn-outline-danger d-flex align-items-center gap-1" @click="$emit('click')">
        <i class="fas fa-trash fs-12"></i>
        <span>Delete</span>
    </button>
</template>

<script setup>
defineProps({
    size: { type: String, default: 'sm' }
});

defineEmits(['click']);
</script>