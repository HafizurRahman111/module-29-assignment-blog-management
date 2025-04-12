<template>
    <DashboardLayout title="Tag Management">
        <div class="tag-management-container">
            <DataTable title="Tag List" icon="fas fa-tags" :items="filteredTags" :headers="headers" :searchable="true"
                :loading="loading" :show-add-modal="true" add-button-text="Create Tag" :edit-route="editTagRoute"
                :delete-action="askDelete" search-placeholder="Search ..." :search-fields="['name']"
                @search="handleSearch" @add-modal-open="openAddTagModal">
                <template #empty-state>
                    <div class="empty-state">
                        <i class="fas fa-tags empty-state__icon"></i>
                        <h5 class="empty-state__title">No tags found</h5>
                        <p v-if="searchQuery" class="empty-state__hint">Try a different search term</p>
                    </div>
                </template>
            </DataTable>

            <!-- Create Tag Modal -->
            <Modal :show="showAddTagModal" title="Create New Tag" @close="closeAddTagModal">
                <form @submit.prevent="handleSubmit">
                    <div class="form-group">
                        <label for="tag-name">Tag Name</label>
                        <input id="tag-name" v-model.trim="newTag.name" type="text" class="form-control"
                            placeholder="Enter tag name" required :disabled="isSubmitting">
                    </div>

                    <div class="modal-actions">
                        <button type="submit" class="btn btn-primary" :disabled="isSubmitting">
                            <span v-if="isSubmitting">
                                <i class="fas fa-spinner fa-spin me-2"></i>
                                Creating...
                            </span>
                            <span v-else>Create Tag</span>
                        </button>
                        <button type="button" class="btn btn-secondary" @click="closeAddTagModal"
                            :disabled="isSubmitting">
                            Cancel
                        </button>
                    </div>
                </form>
            </Modal>

            <!-- Delete Confirmation Modal -->
            <ConfirmDeleteModal :show="showDeleteModal" :item-name="selectedTag?.name || 'this tag'"
                @confirm="confirmDelete" @close="closeDeleteModal" />
        </div>
    </DashboardLayout>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { usePage } from '@inertiajs/vue3'
import axios from 'axios'
import { createToaster } from '@meforma/vue-toaster'
import Modal from '@/Components/ui/modals/Modal.vue'
import DashboardLayout from '@/Layouts/DashboardLayout.vue'
import DataTable from '@/Components/ui/data/DataTable/DataTable.vue'
import ConfirmDeleteModal from '@/Components/ui/modals/ConfirmDeleteModal.vue'

// Toast configuration
const toaster = createToaster({
    position: 'top-right',
    duration: 3000,
    maxToasts: 3
})

// Reactive state
const { tags: initialTags = [] } = usePage().props
const tags = ref([...initialTags])
const searchQuery = ref('')
const loading = ref(false)
const isSubmitting = ref(false)
const showAddTagModal = ref(false)
const showDeleteModal = ref(false)
const selectedTag = ref(null)
const newTag = ref({ name: '' })

// Computed properties
const filteredTags = computed(() => {
    if (!searchQuery.value) return tags.value
    const query = searchQuery.value.toLowerCase()
    return tags.value.filter(tag =>
        tag.name.toLowerCase().includes(query)
    )
})

const editTagRoute = (id) => `/tags/${id}/edit`

// Methods
const fetchTags = async () => {
    if (tags.value.length > 0) return

    try {
        loading.value = true
        const { data } = await axios.get('/tags')
        tags.value = data
    } catch (err) {
        handleError(err, 'Failed to load tags')
    } finally {
        loading.value = false
    }
}

const handleSearch = (query) => {
    searchQuery.value = query
}

const openAddTagModal = () => {
    showAddTagModal.value = true
}

const closeAddTagModal = () => {
    if (!isSubmitting.value) {
        showAddTagModal.value = false
        newTag.value = { name: '' }
    }
}

const handleSubmit = async () => {
    if (!newTag.value.name) {
        toaster.error('Tag name is required')
        return
    }

    try {
        isSubmitting.value = true
        const { data } = await axios.post('/tags', newTag.value)
        tags.value.unshift(data)
        toaster.success('Tag created successfully')
        closeAddTagModal()
    } catch (err) {
        handleError(err, 'Failed to create tag')
    } finally {
        isSubmitting.value = false
    }
}

const askDelete = (tag) => {
    selectedTag.value = tag
    showDeleteModal.value = true
}

const confirmDelete = async () => {
    if (!selectedTag.value) return

    try {
        loading.value = true
        await axios.delete(`/tags/${selectedTag.value.id}`)
        tags.value = tags.value.filter(t => t.id !== selectedTag.value.id)
        toaster.success('Tag deleted successfully')
    } catch (err) {
        handleError(err, 'Failed to delete tag')
    } finally {
        loading.value = false
        closeDeleteModal()
    }
}

const closeDeleteModal = () => {
    showDeleteModal.value = false
    selectedTag.value = null
}

const handleError = (error, defaultMessage) => {
    console.error(error)
    const message = error.response?.data?.message || defaultMessage
    toaster.error(message)
}

// Lifecycle hooks
onMounted(fetchTags)

// Table configuration
const headers = [
    { text: 'Name', value: 'name', sortable: true },
    {
        text: 'Actions',
        value: 'actions',
        sortable: false,
        align: 'right',
        width: '150px'
    }
]
</script>

<style scoped>
.tag-management-container {
    padding: .5rem;
}

.empty-state {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 2rem;
    text-align: center;
}

.empty-state__icon {
    font-size: 3rem;
    color: var(--color-gray-400);
    margin-bottom: 1rem;
}

.empty-state__title {
    font-size: 1.25rem;
    font-weight: 600;
    margin-bottom: 0.5rem;
}

.empty-state__hint {
    color: var(--color-gray-500);
    margin-bottom: 1.5rem;
}

.form-group {
    margin-bottom: 1.5rem;
}

.form-group label {
    display: block;
    margin-bottom: 0.5rem;
    font-weight: 500;
}

.modal-actions {
    display: flex;
    justify-content: flex-end;
    gap: 0.75rem;
    margin-top: 1.5rem;
}

.btn {
    padding: 0.5rem 1rem;
    border-radius: 0.375rem;
    font-weight: 500;
    transition: all 0.15s ease;
}

.btn-primary {
    background-color: #3b82f6;
    color: white;
    border: none;
}

.btn-primary:hover {
    background-color: #2563eb;
}

.btn-primary:disabled {
    background-color: #93c5fd;
}

.btn-secondary {
    background-color: #e5e7eb;
    color: #374151;
}

.btn-secondary:hover {
    background-color: #d1d5db;
}

.btn-secondary:disabled {
    opacity: 0.7;
}
</style>