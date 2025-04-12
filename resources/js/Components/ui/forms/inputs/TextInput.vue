<template>
    <div class="form-group">
        <label :for="id" class="form-label">{{ label }}</label>

        <input :id="id" :value="modelValue" @input="updateModelValue" :type="type" :required="required"
            class="input-field" :class="{ 'input-error': error }" :placeholder="label" />

        <!-- <p v-if="error" class="error-message">{{ error }}</p> -->
    </div>
</template>

<script setup>
import { defineProps, defineEmits } from 'vue';

const props = defineProps({
    label: String,
    id: String,
    modelValue: String,
    type: String,
    required: Boolean,
    error: String,
});

const emit = defineEmits(['update:modelValue']);

function updateModelValue(event) {
    emit('update:modelValue', event.target.value);
}
</script>

<style scoped>
.form-group {
    margin-bottom: 1.5rem;
    position: relative;
}

.form-label {
    font-weight: 600;
    font-size: 1rem;
    color: var(--color-dark);
    margin-bottom: 0.5rem;
    transition: all 0.2s ease;
    display: block;
}

.input-field {
    width: 100%;
    padding: 0.75rem 1rem;
    border: 1px solid var(--color-gray-300);
    border-radius: 0.5rem;
    font-size: 1rem;
    background-color: var(--color-light);
    color: var(--color-dark);
    transition: all 0.3s ease;
}

.input-field:focus {
    border-color: var(--color-primary);
    outline: none;
    box-shadow: 0 0 5px rgba(0, 123, 255, 0.25);
}

.input-field::placeholder {
    color: var(--color-gray-500);
}

.input-error {
    border-color: var(--color-red-500);
    box-shadow: 0 0 5px rgba(220, 53, 69, 0.5);
}

.error-message {
    color: var(--color-red-500);
    font-size: 0.875rem;
    margin-top: 0.25rem;
    position: absolute;
    bottom: -1.5rem;
    left: 0;
}

.input-field:hover {
    border-color: var(--color-primary-light);
}
</style>