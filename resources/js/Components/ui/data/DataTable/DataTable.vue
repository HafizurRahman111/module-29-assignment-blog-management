<template>
    <div class="data-table-container">
        <!-- Header -->
        <DataTableHeader :title="title" :icon="icon" :searchable="searchable" :search-placeholder="searchPlaceholder"
            :add-route="addRoute" :add-button-text="addButtonText" @search="handleSearch">
            <template #header-left>
                <slot name="header-left" />
            </template>
            <template #header-right>
                <slot name="header-right" />
            </template>
        </DataTableHeader>

        <!-- Table Wrapper -->
        <div class="table-wrapper">
            <!-- Loading -->
            <Transition name="fade">
                <div v-if="loading" class="loading-overlay">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>
            </Transition>

            <!-- Empty State -->
            <Transition name="fade">
                <div v-if="!loading && filteredItems.length === 0" class="empty-state">
                    <i class="fas fa-database empty-icon"></i>
                    <h5>No data available</h5>
                    <p v-if="searchQuery">Try adjusting your search query</p>
                    <slot name="empty-state" />
                </div>
            </Transition>

            <!-- Data Table -->
            <EasyDataTable v-show="!loading && filteredItems.length > 0" :headers="processedHeaders"
                :items="filteredItems" :show-index="showIndex" :loading="loading" :rows-per-page="rowsPerPage"
                :buttons-pagination="true" table-class-name="modern-data-table">
                <!-- Slot forwarding for dynamic custom columns -->
                <template v-for="(_, slotName) in $slots" #[slotName]="slotProps">
                    <slot :name="slotName" v-bind="slotProps" />
                </template>

                <!-- Action Buttons Column -->
                <template #item-actions="{ id }">
                    <div class="action-buttons">
                        <ViewButton v-if="viewRoute" :to="viewRoute(id)" size="sm" class="action-btn" />
                        <EditButton v-if="editRoute" :to="editRoute(id)" size="sm" class="action-btn" />
                        <DeleteButton v-if="deleteAction" size="sm" class="action-btn" @click="handleDelete(id)" />
                        <slot name="item-actions" :id="id" />
                    </div>
                </template>
            </EasyDataTable>
        </div>
    </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue';
import { debounce } from 'lodash-es';
import DataTableHeader from './DataTableHeader.vue';
import ViewButton from './actions/ViewButton.vue';
import EditButton from './actions/EditButton.vue';
import DeleteButton from './actions/DeleteButton.vue';

const props = defineProps({
    title: String,
    icon: { type: String, default: 'fas fa-table' },
    items: { type: Array, required: true },
    headers: { type: Array, required: true },
    searchable: { type: Boolean, default: true },
    searchFields: { type: Array, default: () => ['name'] },
    searchPlaceholder: { type: String, default: 'Search...' },
    addRoute: { type: String, default: '' },
    addButtonText: { type: String, default: 'Add New' },
    viewRoute: Function,
    editRoute: Function,
    deleteAction: Function,
    rowsPerPage: { type: Number, default: 10 },
    showIndex: { type: Boolean, default: true },
    loading: { type: Boolean, default: false },
    debounceDelay: { type: Number, default: 300 }
});

const emit = defineEmits(['delete', 'search']);

// Reactive State
const searchQuery = ref('');
const sortKey = ref('');
const sortOrder = ref('asc');

// Debounced Search
const debouncedSearch = debounce((query) => emit('search', query), props.debounceDelay);

watch(searchQuery, () => debouncedSearch(searchQuery.value));

// Computed Headers with Sort Handler
const processedHeaders = computed(() =>
    props.headers.map(header => ({
        ...header,
        sortable: header.sortable ?? false,
        sort: header.sortable ? () => handleSort(header.value) : undefined
    }))
);

// Filtered Items (Search + Sort)
const filteredItems = computed(() => {
    let result = [...props.items];

    if (searchQuery.value) {
        const query = searchQuery.value.toLowerCase();
        result = result.filter(item =>
            props.searchFields.some(field =>
                String(item[field] ?? '').toLowerCase().includes(query)
            )
        );
    }

    if (sortKey.value) {
        result.sort((a, b) => {
            const valA = a[sortKey.value];
            const valB = b[sortKey.value];

            if (valA == null) return sortOrder.value === 'asc' ? -1 : 1;
            if (valB == null) return sortOrder.value === 'asc' ? 1 : -1;

            if (typeof valA === 'string' && typeof valB === 'string') {
                return sortOrder.value === 'asc'
                    ? valA.localeCompare(valB)
                    : valB.localeCompare(valA);
            }

            return sortOrder.value === 'asc' ? valA - valB : valB - valA;
        });
    }

    return result;
});

// Event Handlers
const handleSearch = (query) => {
    searchQuery.value = query;
};

const handleSort = (key) => {
    sortKey.value === key
        ? (sortOrder.value = sortOrder.value === 'asc' ? 'desc' : 'asc')
        : (sortKey.value = key, sortOrder.value = 'asc');
};



const handleDelete = (id) => {
    if (typeof props.deleteAction === 'function') {
        props.deleteAction(id);
    }
    emit('delete', id);
};

</script>

<style scoped>
.data-table-container {
    background: #ffffff;
    border-radius: 0.75rem;
    box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
    overflow: hidden;
    padding: .5rem;
}

.table-wrapper {
    position: relative;
    min-height: 200px;
}

/* Animations */
.fade-enter-active,
.fade-leave-active {
    transition: opacity 0.2s ease;
}

.fade-enter-from,
.fade-leave-to {
    opacity: 0;
}

/* Loading State */
.loading-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(255, 255, 255, 0.8);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 10;
    backdrop-filter: blur(2px);
}

/* Empty State */
.empty-state {
    padding: 40px 20px;
    text-align: center;
    color: #64748b;
}

.empty-icon {
    font-size: 48px;
    margin-bottom: 16px;
    color: #e2e8f0;
}

.empty-state h5 {
    margin-bottom: 8px;
    color: #475569;
}

.empty-state p {
    margin-bottom: 0;
}

/* Action Buttons */
.action-buttons {
    display: flex;
    gap: 8px;
    flex-wrap: wrap;
}

.action-btn {
    transition: all 0.2s ease;
}

.action-btn:hover {
    transform: translateY(-1px);
}

/* Modern Data Table Styles */
.modern-data-table {
    --easy-table-border: none;
    --easy-table-header-font-size: 0.8125rem;
    --easy-table-header-background: #f8fafc;
    --easy-table-header-font-color: #64748b;
    --easy-table-header-height: 56px;
    --easy-table-row-border: 1px solid #f1f5f9;
    --easy-table-row-font-size: 0.875rem;
    --easy-table-row-font-color: #334155;
    --easy-table-row-height: 60px;
    --easy-table-row-hover-background: rgba(79, 70, 229, 0.04);
}

.modern-data-table th {
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    border-bottom: 2px solid #e2e8f0 !important;
}

.modern-data-table td {
    vertical-align: middle;
    border-bottom: 1px solid #f1f5f9 !important;
}

.modern-data-table tr:hover td {
    background: var(--easy-table-row-hover-background);
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .data-table-container {
        border-radius: 0.5rem;
    }

    .action-buttons {
        flex-direction: column;
        gap: 4px;
    }
}
</style>