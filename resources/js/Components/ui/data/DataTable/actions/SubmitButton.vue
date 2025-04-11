<template>
    <button type="submit" class="btn btn-sm btn-primary d-flex align-items-center gap-1"
        :class="{ 'btn-lg': size === 'lg' }">
        <i v-if="icon" :class="icon" class="fs-12"></i>
        <span>{{ label }}</span>
    </button>
</template>

<script setup>
defineProps({
    label: { type: String, default: 'Submit' },
    icon: { type: String, default: 'fas fa-check' },
    size: { type: String, default: 'sm' }
});
</script>