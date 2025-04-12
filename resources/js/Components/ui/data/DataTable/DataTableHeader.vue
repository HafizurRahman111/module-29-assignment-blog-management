<template>
    <header class="data-table-header card-header bg-white border-0 py-3">
        <div class="header-content">
            <!-- Left Section -->
            <div class="header-left">
                <h1 class="header-title">
                    <i v-if="icon" :class="icon" class="header-icon"></i>
                    {{ title }}
                </h1>
                <slot name="header-left"></slot>
            </div>

            <!-- Right Section -->
            <div class="header-right">
                <DataTableSearch v-if="searchable" :placeholder="searchPlaceholder" @search="handleSearch"
                    class="header-search" />

                <AddButton v-if="showAddButton" :to="addRoute" size="sm" :text="addButtonText" />

                <slot name="header-right"></slot>
            </div>
        </div>
    </header>
</template>

<script setup>
import { computed } from 'vue';
import DataTableSearch from './DataTableSearch.vue';
import AddButton from './actions/AddButton.vue';

const props = defineProps({
    title: {
        type: String,
        required: true
    },
    icon: {
        type: String,
        default: ''
    },
    searchable: {
        type: Boolean,
        default: true
    },
    searchPlaceholder: {
        type: String,
        default: 'Search...'
    },
    addRoute: {
        type: [String, Boolean],
        default: false
    },
    addButtonText: {
        type: String,
        default: 'Add New'
    }
});

const emit = defineEmits(['search']);

const showAddButton = computed(() => {
    return props.addRoute && typeof props.addRoute === 'string';
});

const handleSearch = (query) => {
    emit('search', query);
};
</script>

<style scoped>
.data-table-header {
    position: relative;
    z-index: 10;
}

.header-content {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    align-items: center;
    gap: 1rem;
}

.header-left,
.header-right {
    display: flex;
    align-items: center;
    gap: 1rem;
}

.header-title {
    margin: 0;
    font-size: 1.25rem;
    font-weight: 600;
    display: flex;
    align-items: center;
}

.header-icon {
    margin-right: 0.5rem;
    color: var(--text-muted);
    font-size: 1.1em;
}

.header-search {
    min-width: 200px;
    margin-right: 0.5rem;
}

@media (max-width: 768px) {
    .header-content {
        flex-direction: column;
        align-items: flex-start;
    }

    .header-right {
        width: 100%;
        flex-wrap: wrap;
    }

    .header-search {
        flex-grow: 1;
        min-width: unset;
    }
}
</style>