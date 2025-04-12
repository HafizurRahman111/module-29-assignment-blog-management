<template>
    <DashboardLayout title="Post Management">
        <div class="container py-4">
            <!-- Header Section -->
            <div class="row align-items-center mb-4">
                <div class="col-md-5">
                    <h1 class="h4 fw-bold mb-0">
                        <i class="fas fa-newspaper me-2 text-primary"></i>
                        Post Management
                    </h1>
                </div>

                <div class="col-md-4 mt-3 mt-md-0">
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0">
                            <i class="fas fa-search"></i>
                        </span>
                        <input type="text" class="form-control border-start-0" placeholder="Search posts..."
                            v-model="searchQuery" @input="handleSearch" />
                    </div>
                </div>

                <div class="col-md-3 text-md-end mt-3 mt-md-0">
                    <router-link v-if="canCreatePosts" to="/posts/create" class="btn btn-primary w-100 w-md-auto">
                        <i class="fas fa-plus me-2"></i>Create New Post
                    </router-link>
                </div>
            </div>

            <!-- Posts Grid (3 per row) -->
            <div v-if="!loading && paginatedPosts.length > 0" class="row g-4">
                <div v-for="post in paginatedPosts" :key="post.id" class="col-sm-6 col-md-4">
                    <DashboardPostCard :post="post" @view="() => $router.push(viewPostRoute(post.id))"
                        @edit="() => $router.push(editPostRoute(post.id))" @delete="askDelete(post)" />
                </div>
            </div>

            <!-- Pagination -->
            <div v-if="filteredPosts.length > perPage" class="d-flex justify-content-center mt-4">
                <nav>
                    <ul class="pagination">
                        <li v-for="page in totalPages" :key="page" class="page-item"
                            :class="{ active: page === currentPage }">
                            <button class="page-link" @click="changePage(page)">
                                {{ page }}
                            </button>
                        </li>
                    </ul>
                </nav>
            </div>

            <!-- Empty State -->
            <div v-if="!loading && filteredPosts.length === 0" class="text-center py-5">
                <div class="empty-state-content">
                    <i class="fas fa-newspaper-slash fa-4x text-muted mb-4"></i>
                    <h5 class="empty-state-title">No posts found</h5>
                    <p v-if="searchQuery" class="text-muted">Try adjusting your search query</p>
                    <router-link v-if="canCreatePosts" to="/posts/create" class="btn btn-primary mt-3">
                        <i class="fas fa-plus me-2"></i>Create New Post
                    </router-link>
                </div>
            </div>

            <!-- Loading Spinner -->
            <div v-if="loading" class="text-center py-5">
                <div class="spinner-border text-primary" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
            </div>

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
import DashboardPostCard from '@/Components/app/dashboard/DashboardPostCard.vue'
import ConfirmDeleteModal from '@/Components/ui/modals/ConfirmDeleteModal.vue'

const toaster = createToaster({ position: 'top-right', duration: 3000 })
const { props: pageProps } = usePage()

const posts = ref(pageProps.posts || [])
const searchQuery = ref('')
const loading = ref(false)
const showDeleteModal = ref(false)
const selectedPost = ref(null)

const currentPage = ref(1)
const perPage = 6

const canCreatePosts = computed(() => true)

const filteredPosts = computed(() => {
    const query = searchQuery.value.toLowerCase().trim()
    if (!query) return posts.value

    return posts.value.filter(post =>
        post.title.toLowerCase().includes(query) ||
        post.content.toLowerCase().includes(query) ||
        post.tags?.some(tag => tag.name.toLowerCase().includes(query))
    )
})

const paginatedPosts = computed(() => {
    const start = (currentPage.value - 1) * perPage
    return filteredPosts.value.slice(start, start + perPage)
})

const totalPages = computed(() => Math.ceil(filteredPosts.value.length / perPage))

const changePage = (page) => {
    currentPage.value = page
    window.scrollTo({ top: 0, behavior: 'smooth' })
}

const handleSearch = () => {
    currentPage.value = 1
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
        toaster.error(err.response?.data?.message || 'Failed to delete post')
    } finally {
        loading.value = false
        closeDeleteModal()
    }
}

const fetchPosts = async () => {
    if (posts.value.length) return
    try {
        loading.value = true
        const { data } = await axios.get('/posts')
        posts.value = data
    } catch {
        toaster.error('Failed to load posts')
    } finally {
        loading.value = false
    }
}

const viewPostRoute = (id) => `/posts/${id}`
const editPostRoute = (id) => `/posts/${id}/edit`

onMounted(fetchPosts)
</script>

<style scoped>
.empty-state-content {
    max-width: 500px;
    margin: 0 auto;
}
</style>
