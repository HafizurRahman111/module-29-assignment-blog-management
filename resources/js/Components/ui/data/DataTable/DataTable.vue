<template>
    <div class="data-table-container">
        <!-- Header with flexible creation options -->
        <DataTableHeader :title="title" :icon="icon" :searchable="searchable" :search-placeholder="searchPlaceholder"
            @search="handleSearch">
            <template #header-left>
                <slot name="header-left" />
            </template>

            <template #header-right>
                <!-- Conditional Add Button -->
                <template v-if="hasCreationOption">
                    <Link v-if="addRoute" :href="addRoute" class="btn btn-primary" preserve-scroll preserve-state>
                    <i class="fas fa-plus me-2"></i>
                    {{ addButtonText }}
                    </Link>

                    <button v-else-if="showAddModal" class="btn btn-success" @click="openAddModal">
                        <i class="fas fa-plus me-2"></i>
                        {{ addButtonText }}
                    </button>
                </template>

                <slot name="header-right" />
            </template>
        </DataTableHeader>

        <!-- Add Modal Slot -->
        <slot name="add-modal" v-if="showAddModal && isAddModalOpen">
            <Modal :show="isAddModalOpen" @close="closeAddModal">
                <slot name="modal-content"></slot>
            </Modal>
        </slot>

        <!-- Table Content -->
        <div class="table-wrapper">
            <!-- Loading State -->
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

                    <!-- Empty State Action -->
                    <template v-if="hasCreationOption">
                        <button v-if="addRoute" class="btn btn-primary mt-3" @click="navigateToAdd">
                            <i class="fas fa-plus me-2"></i>
                            {{ addButtonText }}
                        </button>

                        <button v-else-if="showAddModal" class="btn btn-primary mt-3" @click="openAddModal">
                            <i class="fas fa-plus me-2"></i>
                            {{ addButtonText }}
                        </button>
                    </template>

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
import { Link } from '@inertiajs/vue3'
import { useRouter } from 'vue-router';
import { debounce } from 'lodash-es';
import DataTableHeader from './DataTableHeader.vue';
import ViewButton from './actions/ViewButton.vue';
import EditButton from './actions/EditButton.vue';
import DeleteButton from './actions/DeleteButton.vue';
import Modal from '@/Components/ui/modals/Modal.vue';

const props = defineProps({
    title: String,
    icon: { type: String, default: 'fas fa-table' },
    items: { type: Array, required: true },
    headers: { type: Array, required: true },
    searchable: { type: Boolean, default: true },
    searchFields: { type: Array, default: () => ['name'] },
    searchPlaceholder: { type: String, default: 'Search...' },
    addRoute: { type: [String, Boolean], default: false },
    addButtonText: { type: String, default: 'Add New' },
    showAddModal: { type: Boolean, default: false },
    viewRoute: Function,
    editRoute: Function,
    deleteAction: Function,
    rowsPerPage: { type: Number, default: 10 },
    showIndex: { type: Boolean, default: true },
    loading: { type: Boolean, default: false },
    debounceDelay: { type: Number, default: 300 }
});

const emit = defineEmits([
    'delete',
    'search',
    'add-modal-open',
    'add-modal-close'
]);

const router = useRouter();
const searchQuery = ref('');
const sortKey = ref('');
const sortOrder = ref('asc');
const isAddModalOpen = ref(false);

// Computed properties
const hasCreationOption = computed(() => props.addRoute || props.showAddModal);

const processedHeaders = computed(() =>
    props.headers.map(header => ({
        ...header,
        sortable: header.sortable ?? false,
        sort: header.sortable ? () => handleSort(header.value) : undefined
    }))
);

const filteredItems = computed(() => {
    let result = [...props.items];

    // Apply search filter
    if (searchQuery.value) {
        const query = searchQuery.value.toLowerCase();
        result = result.filter(item =>
            props.searchFields.some(field =>
                String(item[field] ?? '').toLowerCase().includes(query)
            )
        );
    }

    // Apply sorting
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


// Methods
const debouncedSearch = debounce((query) => {
    emit('search', query);
}, props.debounceDelay);

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

const navigateToAdd = () => {
    if (props.addRoute) {
        router.visit(props.addRoute, {
            preserveState: true,
            preserveScroll: true,
            onError: (errors) => {
                console.error('Navigation error:', errors);
            }
        });
    } else {
        console.warn('No addRoute provided.');
    }
};


const openAddModal = () => {
    isAddModalOpen.value = true;
    emit('add-modal-open');
};

const closeAddModal = () => {
    isAddModalOpen.value = false;
    emit('add-modal-close');
};

// Watchers
watch(searchQuery, () => debouncedSearch(searchQuery.value));
</script>

<style scoped>
.data-table-container {
    position: relative;
    background: white;
    border-radius: 0.5rem;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    padding: 1rem;
}

.table-wrapper {
    position: relative;
    min-height: 200px;
}

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
}

.empty-state {
    padding: 3rem;
    text-align: center;
    color: #6b7280;
}

.empty-icon {
    font-size: 3rem;
    margin-bottom: 1rem;
    opacity: 0.5;
}

.action-buttons {
    display: flex;
    gap: 0.5rem;
    justify-content: center;
}

.action-btn {
    padding: 0.25rem 0.5rem;
}

.fade-enter-active,
.fade-leave-active {
    transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
    opacity: 0;
}

.modern-data-table {
    --easy-table-header-font-size: 0.875rem;
    --easy-table-header-background-color: #f9fafb;
    --easy-table-row-border: 1px solid #f3f4f6;
}

.btn {
    display: inline-flex;
    align-items: center;
    padding: 0.3rem 1rem;
    border-radius: 0.375rem;
    font-weight: 500;
    transition: all 0.2s;
}

.btn-primary {
    background-color: #3b82f6;
    color: white;
    border: none;
}

.btn-primary:hover {
    background-color: #2563eb;
}
</style>