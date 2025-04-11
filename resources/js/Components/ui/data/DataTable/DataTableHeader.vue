<template>
    <div class="data-table-header card-header bg-white border-0 py-3">
        <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
            <div class="d-flex align-items-center gap-3">
                <h5 class="mb-0 fw-semibold">
                    <i v-if="icon" :class="icon" class="me-2 text-muted"></i>
                    {{ title }}
                </h5>
                <slot name="header-left"></slot>
            </div>

            <div class="d-flex align-items-center gap-3">
                <DataTableSearch v-if="searchable" :placeholder="searchPlaceholder" @search="$emit('search', $event)"
                    class="me-2" />

                <AddButton v-if="addRoute" :to="addRoute" size="sm" />

                <slot name="header-right"></slot>
            </div>
        </div>
    </div>
</template>

<script setup>
import DataTableSearch from './DataTableSearch.vue';
import AddButton from './actions/AddButton.vue';

defineProps({
    title: { type: String, required: true },
    icon: { type: String, default: '' },
    searchable: { type: Boolean, default: true },
    searchPlaceholder: { type: String, default: 'Search...' },
    addRoute: { type: String, default: '' }
});

defineEmits(['search']);
</script>