<template>
    <div v-if="show" class="modal-backdrop" @click.self="closeModal">
        <div class="modal-wrapper">
            <div class="modal-header">
                <h2 class="modal-title">{{ title }}</h2>
                <button class="modal-close" @click="closeModal">&times;</button>
            </div>

            <div class="modal-body">
                <slot />
            </div>

            <div class="modal-footer">
                <button class="btn btn-secondary" @click="closeModal">Cancel</button>
                <button class="btn btn-primary" :disabled="isSubmitting" @click="submitForm">
                    <span v-if="isSubmitting">Submitting...</span>
                    <span v-else>{{ submitText }}</span>
                </button>
            </div>
        </div>
    </div>
</template>

<script setup>
import { defineProps, defineEmits } from 'vue'

const props = defineProps({
    show: { type: Boolean, required: true },
    title: { type: String, required: true },
    submitText: { type: String, default: 'Submit' },
    isSubmitting: { type: Boolean, default: false }
})

const emit = defineEmits(['close', 'submit'])

const closeModal = () => emit('close')
const submitForm = () => emit('submit')
</script>

<style scoped>
.modal-backdrop {
    position: fixed;
    inset: 0;
    background: rgba(0, 0, 0, 0.4);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1050;
    backdrop-filter: blur(2px);
    animation: fadeIn 0.2s ease-in;
}

.modal-wrapper {
    background-color: #fff;
    width: 100%;
    max-width: 500px;
    border-radius: 12px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
    overflow: hidden;
    animation: scaleIn 0.2s ease-out;
}

.modal-header {
    padding: 1rem 1.5rem;
    background-color: #f8f9fa;
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-bottom: 1px solid #dee2e6;
}

.modal-title {
    font-size: 1.25rem;
    font-weight: 600;
    margin: 0;
}

.modal-close {
    background: none;
    border: none;
    font-size: 1.5rem;
    line-height: 1;
    color: #333;
    cursor: pointer;
}

.modal-body {
    padding: 1.5rem;
    font-size: 1rem;
    color: #333;
}

.modal-footer {
    padding: 1rem 1.5rem;
    background-color: #f8f9fa;
    border-top: 1px solid #dee2e6;
    display: flex;
    justify-content: flex-end;
    gap: 10px;
}

.btn {
    padding: 0.5rem 1.2rem;
    font-size: 1rem;
    font-weight: 500;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: background 0.2s ease;
}

.btn-primary {
    background-color: #007bff;
    color: white;
}

.btn-primary:disabled {
    background-color: #6cb2eb;
    cursor: not-allowed;
}

.btn-secondary {
    background-color: #6c757d;
    color: white;
}

@keyframes fadeIn {
    from {
        opacity: 0;
    }

    to {
        opacity: 1;
    }
}

@keyframes scaleIn {
    from {
        transform: scale(0.95);
        opacity: 0;
    }

    to {
        transform: scale(1);
        opacity: 1;
    }
}
</style>