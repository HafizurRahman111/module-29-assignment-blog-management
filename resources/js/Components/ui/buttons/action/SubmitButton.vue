<template>
    <button type="submit" class="auth-button" :disabled="disabled">{{ label }}</button>
</template>

<script setup>
defineProps({
    label: String,
    disabled: Boolean,
});
</script>

<style scoped>
.auth-button {
    width: 100%;
    padding: 0.75rem;
    background-color: var(--color-primary);
    color: white;
    border: none;
    border-radius: 0.5rem;
    font-size: 1rem;
    cursor: pointer;
}

.auth-button:disabled {
    background-color: var(--color-gray-400);
}
</style>