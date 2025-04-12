<template>
    <DashboardLayout title="My Bookmarked Posts">
        <div class="container py-4">
            <div class="row align-items-center mb-4">
                <div class="col-md-8">
                    <h1 class="h4 fw-bold">
                        <i class="fas fa-bookmark me-2 text-warning"></i>
                        Bookmarked Posts
                    </h1>
                </div>
            </div>

            <div v-if="!loading && paginatedPosts.length" class="row g-4">
                <div v-for="post in paginatedPosts" :key="post.id" class="col-sm-6 col-md-4">
                    <DashboardPostCard :post="post" @view="() => $router.push(`/posts/${post.id}`)" />
                </div>
            </div>

            <div v-if="!loading && !paginatedPosts.length" class="text-center py-5">
                <div class="empty-state-content">
                    <i class="fas fa-bookmark-slash fa-4x text-muted mb-4"></i>
                    <h5>No bookmarks found</h5>
                    <p class="text-muted">You haven't bookmarked any posts yet.</p>
                </div>
            </div>

            <div v-if="loading" class="text-center py-5">
                <div class="spinner-border text-primary" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
            </div>

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
        </div>
    </DashboardLayout>
</template>

<script setup>
import { ref, computed } from 'vue'
import { usePage } from '@inertiajs/vue3'
import DashboardLayout from '@/Layouts/DashboardLayout.vue'
import DashboardPostCard from '@/Components/app/dashboard/DashboardPostCard.vue'

const { props } = usePage()
const posts = ref(props.posts || [])
const searchQuery = ref('')
const loading = ref(false)

const currentPage = ref(1)
const perPage = 6

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
</script>

<style scoped>
.empty-state-content {
    max-width: 500px;
    margin: 0 auto;
}
</style>
