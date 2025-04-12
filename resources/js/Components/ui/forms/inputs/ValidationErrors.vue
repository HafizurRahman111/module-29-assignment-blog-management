<template>
    <div v-if="Object.keys(errors).length" class="form-errors">
        <div v-for="(error, field) in errors" :key="field" class="form-error">
            {{ error }}
        </div>
    </div>
</template>

<script setup>
defineProps({
    errors: {
        type: Object,
        required: true
    }
});
</script>
