<template>
    <Teleport to="body">
        <div v-if="visible" class="modal-backdrop">
            <div class="modal-box">
                <i class="fas fa-exclamation-triangle text-warning text-3xl mb-3"></i>
                <h3 class="text-lg font-semibold">Are you sure?</h3>
                <p class="text-sm text-gray-600 mt-2">
                    Are you sure you want to delete the user '{{ username }}' ({{ userId }})? This action cannot be
                    undone.
                </p>
                <div class="flex justify-end gap-3 mt-5">
                    <button class="btn btn-sm btn-secondary" @click="$emit('cancel')">Cancel</button>
                    <button class="btn btn-sm btn-danger" @click="$emit('confirm')">Yes, Delete</button>
                </div>
            </div>
        </div>
    </Teleport>
</template>

<script setup>
defineProps({
    visible: Boolean,
    username: { type: String, default: '' },
    userId: { type: [String, Number], default: null }
});

defineEmits(['confirm', 'cancel']);
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
</style>
