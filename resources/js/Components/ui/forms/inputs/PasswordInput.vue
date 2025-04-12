<template>
    <div class="form-group">
        <label :for="id" class="form-label">{{ label }}</label>

        <div class="password-input">
            <input :id="id" :value="modelValue" :type="passwordVisible ? 'text' : 'password'" :required="required"
                :class="['input-field', { 'input-error': error }]" @input="updateModelValue" :placeholder="label" />

            <button type="button" class="toggle-password" @click="togglePasswordVisibility">
                <i :class="passwordVisible ? 'fa fa-eye-slash' : 'fa fa-eye'"></i>
            </button>
        </div>

        <p v-if="error" class="error-message">{{ error }}</p>
    </div>
</template>

<script setup>
import { ref } from 'vue';

const props = defineProps({
    label: {
        type: String,
        required: true,
    },
    id: {
        type: String,
        required: true,
    },
    modelValue: {
        type: String,
        required: true,
    },
    required: {
        type: Boolean,
        default: false,
    },
    error: {
        type: String,
        default: '',
    },
});

// Password visibility toggle state
const passwordVisible = ref(false);

// Toggle password visibility
function togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
}

// Emit the model value update on input change
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
    display: block;
    transition: all 0.3s ease;
}

.password-input {
    position: relative;
    display: flex;
    align-items: center;
}

/* Input field styling */
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

/* Focus state for the input field */
.input-field:focus {
    border-color: var(--color-primary);
    outline: none;
    box-shadow: 0 0 5px rgba(0, 123, 255, 0.25);
}

/* Error styling for the input field */
.input-error {
    border-color: var(--color-red-500);
    box-shadow: 0 0 5px rgba(220, 53, 69, 0.5);
}

/* Styling for the password visibility toggle button */
.toggle-password {
    position: absolute;
    right: 10px;
    top: 50%;
    transform: translateY(-50%);
    background: none;
    border: none;
    cursor: pointer;
    font-size: 1.25rem;
    color: var(--color-gray-600);
    transition: color 0.3s ease;
}

/* Toggle button color on hover */
.toggle-password:hover {
    color: var(--color-primary);
}

/* Error message styling */
.error-message {
    color: var(--color-red-500);
    font-size: 0.875rem;
    margin-top: 0.5rem;
    position: absolute;
    bottom: -1.5rem;
    left: 0;
}

/* Placeholder text color */
.input-field::placeholder {
    color: var(--color-gray-500);
}
</style>