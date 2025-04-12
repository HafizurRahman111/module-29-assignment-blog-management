<template>
    <div v-if="Object.keys(errors).length" class="form-errors">
        <div v-for="(error, field) in errors" :key="field" class="form-error">
            {{ error }}
        </div>
    </div>
</template>

<script setup>
defineProps({
    errors: Object,
});
</script>

<style scoped>
.form-errors {
    margin-top: 1rem;
    padding: 0.75rem 1rem;
    border-left: 4px solid #e53e3e;
    background-color: #fff5f5;
    border-radius: 6px;
}

.form-error {
    color: #e53e3e;
    margin-bottom: 0.25rem;
    font-size: 0.95rem;
}
</style>