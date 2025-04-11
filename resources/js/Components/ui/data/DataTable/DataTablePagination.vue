<template>
    <div class="d-flex justify-content-between align-items-center bg-light px-3 py-2">
        <div class="text-muted small">
            Showing <strong>{{ Math.min(rowsPerPage, totalItems) }}</strong> of <strong>{{ totalItems }}</strong> items
        </div>
        <div class="d-flex gap-1">
            <button class="btn btn-sm btn-outline-secondary" disabled>
                <i class="fas fa-chevron-left"></i>
            </button>
            <button class="btn btn-sm btn-outline-secondary" disabled>
                <i class="fas fa-chevron-right"></i>
            </button>
        </div>
    </div>
</template>

<script setup>
defineProps({
    totalItems: { type: Number, required: true },
    rowsPerPage: { type: Number, required: true }
});
</script>