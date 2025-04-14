<template>
    <Transition name="modal">
        <div v-if="show" class="modal-backdrop" @click.self="handleBackdropClick">
            <div class="modal-wrapper" role="dialog" aria-modal="true">
                <!-- Header -->
                <div class="modal-header">
                    <h2 class="modal-title">{{ title }}</h2>
                    <button class="modal-close" @click="close" aria-label="Close modal">
                        &times;
                    </button>
                </div>

                <!-- Body -->
                <div class="modal-body">
                    <slot />
                </div>

                <!-- Footer -->
                <div class="modal-footer" v-if="$slots.footer || showDefaultFooter">
                    <slot name="footer">
                        <!-- Default footer if slot not provided -->
                        <button class="btn btn-secondary" @click="close" :disabled="isSubmitting">
                            Cancel
                        </button>
                        <button class="btn btn-primary" @click="$emit('submit')" :disabled="isSubmitting">
                            <span v-if="isSubmitting">Submitting...</span>
                            <span v-else>{{ submitText }}</span>
                        </button>
                    </slot>
                </div>
            </div>
        </div>
    </Transition>
</template>

<script>
export default {
    props: {
        show: Boolean,
        title: String,
        showDefaultFooter: {
            type: Boolean,
            default: true,
        },
        submitText: {
            type: String,
            default: 'Submit',
        },
        isSubmitting: {
            type: Boolean,
            default: false,
        }
    },
    emits: ['close', 'submit'],
    methods: {
        close() {
            this.$emit('close');
        },
        handleBackdropClick() {
            this.close();
        }
    }
};
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
}

.modal-wrapper {
    background-color: #fff;
    width: 95%;
    max-width: 500px;
    border-radius: 12px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
    overflow: hidden;
    margin: 1rem;
}

.modal-header {
    padding: 1.25rem;
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-bottom: 1px solid #e5e7eb;
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
    color: #4b5563;
    cursor: pointer;
    transition: color 0.2s ease;
}

.modal-close:hover {
    color: #1f2937;
}

.modal-body {
    padding: 1.5rem;
}

.modal-footer {
    padding: 1.25rem;
    display: flex;
    justify-content: flex-end;
    gap: 0.75rem;
    border-top: 1px solid #e5e7eb;
}

.btn {
    padding: 0.625rem 1.25rem;
    font-size: 0.875rem;
    font-weight: 500;
    border-radius: 0.5rem;
    transition: all 0.2s ease;
}

.btn-primary {
    background-color: #3b82f6;
    color: white;
    border: none;
}

.btn-primary:disabled {
    background-color: #93c5fd;
    cursor: not-allowed;
}

.btn-primary:hover:not(:disabled) {
    background-color: #2563eb;
}

.btn-secondary {
    background-color: #e5e7eb;
    color: #374151;
    border: none;
}

.btn-secondary:hover:not(:disabled) {
    background-color: #d1d5db;
}

.modal-enter-active,
.modal-leave-active {
    transition: opacity 0.2s ease;
}

.modal-enter-from,
.modal-leave-to {
    opacity: 0;
}

.modal-enter-active .modal-wrapper,
.modal-leave-active .modal-wrapper {
    transition: transform 0.2s ease, opacity 0.2s ease;
}

.modal-enter-from .modal-wrapper,
.modal-leave-to .modal-wrapper {
    transform: scale(0.95);
    opacity: 0;
}
</style>