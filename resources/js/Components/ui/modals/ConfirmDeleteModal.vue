<template>
    <Teleport to="body">
        <div v-if="show" class="modal-backdrop" @click.self="handleClose">
            <div class="modal-box">
                <i class="fas fa-exclamation-triangle text-warning text-3xl mb-3"></i>
                <h3 class="text-lg font-semibold">Are you sure?</h3>
                <p class="text-sm text-gray-600 mt-2">
                    Are you sure you want to delete the tag '{{ itemName }}'? This action cannot be undone.
                </p>
                <div class="flex justify-end gap-3 mt-5">
                    <button class="btn btn-sm btn-secondary" @click="handleClose">Cancel</button>
                    <button class="btn btn-sm btn-danger" @click="handleConfirm">Yes, Delete</button>
                </div>
            </div>
        </div>
    </Teleport>
</template>

<script setup>
defineProps({
    show: Boolean,
    itemName: { type: String, default: '' },
})

const emit = defineEmits(['confirm', 'close'])

const handleConfirm = () => {
    emit('confirm')
}

const handleClose = () => {
    emit('close')
}
</script>

<style scoped>
.modal-backdrop {
    position: fixed;
    inset: 0;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 9999;
}

.modal-box {
    background-color: #fff;
    padding: 1.5rem;
    border-radius: 8px;
    min-width: 300px;
    text-align: center;
}

.btn {
    padding: 0.5rem 1rem;
    border-radius: 0.375rem;
    font-weight: 500;
    transition: all 0.15s ease;
}

.btn-sm {
    font-size: 0.875rem;
}

.btn-secondary {
    background-color: #e5e7eb;
    color: #374151;
}

.btn-danger {
    background-color: #ef4444;
    color: white;
}

.btn-secondary:hover {
    background-color: #d1d5db;
}

.btn-danger:hover {
    background-color: #dc2626;
}
</style>
