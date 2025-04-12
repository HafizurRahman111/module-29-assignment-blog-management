<template>
    <DashboardLayout title="Post Management">
        <div class="post-management-container">
            <DataTable title="Post List" icon="fas fa-newspaper" :items="filteredPosts" :headers="headers"
                :searchable="true" :loading="loading" :add-route="'/posts/create'" :view-route="viewPostRoute"
                :edit-route="editPostRoute" :delete-action="askDelete" search-placeholder="Search posts..."
                :search-fields="['title', 'content', 'tags.name']" @search="handleSearch">

                <!-- Picture Slot -->
                <template #item-image="{ image }">
                    <div class="image-container">
                        <img v-if="image" :src="image" alt="Post image" class="image-picture" loading="lazy" />
                        <div v-else class="picture-placeholder">
                            <i class="fas fa-image"></i>
                        </div>
                    </div>
                </template>

                <!-- Truncated Content Slot -->
                <template #item-content="{ content }">
                    {{ truncateContent(content) }}
                </template>

                <!-- Tags Slot -->
                <template #item-tags="{ tags }">
                    <div class="tags-container">
                        <span v-for="tag in tags" :key="tag.id" class="tag">
                            {{ tag.name }}
                        </span>
                    </div>
                </template>

                <!-- Visibility Badge Slot -->
                <template #item-visibility="{ visibility }">
                    <span :class="`badge ${visibility === 'public' ? 'badge-success' : 'badge-danger'}`">
                        {{ visibility === 'public' ? 'Public' : 'Private' }}
                    </span>
                </template>

                <!-- Custom Empty State -->
                <template #empty-state>
                    <div class="empty-state-content">
                        <i class="fas fa-newspaper-slash empty-state-icon"></i>
                        <h5 class="empty-state-title">No posts found</h5>
                        <p v-if="searchQuery" class="empty-state-hint">Try a different search term</p>
                        <router-link v-if="canCreatePosts" to="/posts/create"
                            class="btn btn-primary empty-state-button">
                            <i class="fas fa-plus me-2"></i>Create New Post
                        </router-link>
                    </div>
                </template>
            </DataTable>

            <!-- Delete Confirmation Modal -->
            <ConfirmDeleteModal :show="showDeleteModal" :item-name="selectedPost?.title || 'this post'"
                @confirm="confirmDelete" @close="closeDeleteModal" />
        </div>
    </DashboardLayout>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { usePage } from '@inertiajs/vue3'
import axios from 'axios'
import { createToaster } from '@meforma/vue-toaster'
import DashboardLayout from '@/Layouts/DashboardLayout.vue'
import DataTable from '@/Components/ui/data/DataTable/DataTable.vue'
import ConfirmDeleteModal from '@/Components/ui/modals/ConfirmDeleteModal.vue'

// Toast configuration
const toaster = createToaster({
    position: 'top-right',
    duration: 3000,
    maxToasts: 3
})

// Initial props from server
const { props: pageProps } = usePage()
const posts = ref(pageProps.posts || [])
const searchQuery = ref('')
const loading = ref(false)
const showDeleteModal = ref(false)
const selectedPost = ref(null)

// Route generators
const viewPostRoute = (id) => `/posts/view/${id}`
const editPostRoute = (id) => `/posts/edit/${id}`

// Permissions
const canCreatePosts = computed(() => true)

// Table headers
const headers = [
    { text: 'Title', value: 'title', sortable: true, searchable: true },
    { text: 'Content', value: 'content', sortable: true, searchable: true },
    { text: 'Tags', value: 'tags', sortable: false, searchable: true },
    { text: 'Image', value: 'image', sortable: false, searchable: false, align: 'center', width: '200px' },
    { text: 'Visibility', value: 'visibility', sortable: true, searchable: true },
    { text: 'Actions', value: 'actions', sortable: false, align: 'center', width: '200px' }
]

// Computed properties
const filteredPosts = computed(() => {
    if (!searchQuery.value) return posts.value

    const query = searchQuery.value.toLowerCase()
    return posts.value.filter(post =>
        headers.some(header => {
            if (header.searchable && post[header.value]) {
                // Include tags in search
                if (header.value === 'tags') {
                    return post.tags.some(tag => tag.name.toLowerCase().includes(query))
                }
                return String(post[header.value]).toLowerCase().includes(query)
            }
            return false
        })
    )
})

// Methods
const handleSearch = (query) => {
    searchQuery.value = query
}

const truncateContent = (content) => {
    if (typeof content !== 'string') return ''
    return content.length > 50 ? `${content.substring(0, 50)}...` : content
}

const askDelete = (post) => {
    selectedPost.value = post
    showDeleteModal.value = true
}

const closeDeleteModal = () => {
    showDeleteModal.value = false
    selectedPost.value = null
}

const confirmDelete = async () => {
    if (!selectedPost.value) return

    try {
        loading.value = true
        await axios.delete(`/posts/${selectedPost.value.id}`)
        posts.value = posts.value.filter(p => p.id !== selectedPost.value.id)
        toaster.success('Post deleted successfully')
    } catch (err) {
        console.error('Delete error:', err)
        toaster.error(err.response?.data?.message || 'Failed to delete post')
    } finally {
        loading.value = false
        closeDeleteModal()
    }
}

const fetchPosts = async () => {
    if (posts.value.length > 0) return

    try {
        loading.value = true
        const { data } = await axios.get('/posts')
        posts.value = data
    } catch (err) {
        console.error('Fetch error:', err)
        toaster.error('Failed to load posts')
    } finally {
        loading.value = false
    }
}

// Lifecycle hooks
onMounted(fetchPosts)
</script>

<style scoped>
.post-management-container {
    padding: .5rem;
}

.image-container {
    display: flex;
    justify-content: center;
    align-items: center;
}

.image-picture {
    width: 100px;
    height: 100px;
    border-radius: 8px;
    object-fit: cover;
}

.picture-placeholder {
    width: 100px;
    height: 100px;
    font-size: 1.8rem;
    color: #ccc;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #f5f5f5;
    border-radius: 8px;
}

.empty-state-content {
    text-align: center;
    padding: 2rem;
}

.empty-state-icon {
    font-size: 3rem;
    color: #aaa;
    margin-bottom: 1rem;
}

.empty-state-title {
    font-weight: 600;
    margin-bottom: 0.5rem;
}

.empty-state-hint {
    color: #666;
    margin-bottom: 1.5rem;
}

.empty-state-button {
    margin-top: 1rem;
}

.badge {
    display: inline-block;
    padding: 0.35em 0.65em;
    font-size: 0.75em;
    font-weight: 700;
    line-height: 1;
    text-align: center;
    white-space: nowrap;
    vertical-align: baseline;
    border-radius: 0.25rem;
}

.badge-success {
    background-color: #28a745;
    color: white;
}

.badge-danger {
    background-color: #dc3545;
    color: white;
}

.btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
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

.tags-container {
    display: flex;
    flex-wrap: wrap;
    gap: 5px;
}

.tag {
    background-color: #f0f0f0;
    padding: 0.3rem 0.6rem;
    border-radius: 5px;
    font-size: 0.85rem;
    color: #333;
}
</style>
