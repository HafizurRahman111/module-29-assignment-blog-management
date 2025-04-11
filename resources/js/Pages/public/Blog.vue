<template>
    <Layout>
        <div class="container py-4">
            <!-- Hero Header -->
            <div class="text-center mb-6">
                <h1 class="display-6 fw-bold mb-3 text-gradient">Explore Our Blog</h1>
                <p class="lead text-muted">Discover the latest articles and insights</p>
            </div>

            <!-- Posts Grid -->
            <transition-group name="staggered-fade" tag="div" class="row g-4" appear>
                <div v-for="(post, index) in displayedPosts" :key="post.id" class="col-lg-4 col-md-6"
                    :style="`--stagger-delay: ${index * 0.1}s`">
                    <div class="card h-100 shadow-lg blog-card" @click="viewPost(post.id)">
                        <!-- Featured Image with Hover Effect -->
                        <div class="card-img-container">
                            <img :src="post.image" :alt="post.title" class="card-img-top img-fluid rounded-top-3"
                                loading="lazy">
                            <div class="card-img-overlay d-flex align-items-end">
                                <div class="badge bg-primary bg-opacity-75 mb-2">
                                    {{ post.visibility === 'public' ? 'Public' : 'Private' }}
                                </div>
                            </div>
                        </div>

                        <div class="card-body d-flex flex-column">
                            <!-- Title with Read More Indicator -->
                            <h3 class="card-title fw-bold mb-3 text-dark">
                                {{ post.title }}
                                <i class="bi bi-arrow-right-circle-fill ms-2 text-primary"></i>
                            </h3>

                            <!-- Excerpt with Gradient Fade -->
                            <div class="excerpt-container mb-3">
                                <p class="card-text text-muted mb-0">{{ post.excerpt }}</p>
                            </div>

                            <!-- Tags -->
                            <div class="tag-cloud mb-3">
                                <span v-for="tag in post.tags" :key="tag.id"
                                    class="badge bg-light text-dark me-1 mb-1 border">
                                    #{{ tag.name }}
                                </span>
                            </div>

                            <!-- Footer with Actions -->
                            <div class="mt-auto d-flex justify-content-between align-items-center">
                                <!-- Date -->
                                <small class="text-muted">
                                    <i class="bi bi-calendar me-1"></i>
                                    {{ formatDate(post.created_at) }}
                                </small>

                                <!-- Action Buttons -->
                                <div class="action-buttons">
                                    <button v-if="isUser" @click.stop="toggleLike(post.id)"
                                        class="btn btn-sm btn-link text-decoration-none"
                                        :class="post.liked ? 'text-danger' : 'text-muted'" aria-label="Like">
                                        <i class="bi" :class="post.liked ? 'bi-heart-fill' : 'bi-heart'"></i>
                                        <span class="ms-1">{{ post.likes_count }}</span>
                                    </button>

                                    <button @click.stop="toggleBookmark(post.id)"
                                        class="btn btn-sm btn-link text-decoration-none ms-2"
                                        :class="post.bookmarked ? 'text-warning' : 'text-muted'" aria-label="Bookmark">
                                        <i class="bi" :class="post.bookmarked ? 'bi-bookmark-fill' : 'bi-bookmark'"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </transition-group>

            <!-- Load More Button -->
            <div class="text-center mt-5">
                <button v-if="displayedPosts.length < posts.length" @click="loadMorePosts"
                    class="btn btn-primary px-4 py-2 rounded-pill shadow-sm">
                    <i class="bi bi-plus-circle me-2"></i>
                    Load More Posts
                </button>
                <p v-else class="text-muted">You've reached the end!</p>
            </div>

            <!-- Scroll to Top -->
            <button v-show="showScrollTop" @click="scrollToTop" class="btn btn-primary scroll-top shadow"
                aria-label="Scroll to top">
                <i class="bi bi-arrow-up"></i>
            </button>
        </div>
    </Layout>
</template>

<script setup>
import { ref, onMounted, onUnmounted, computed } from 'vue'
import Layout from '../../Layouts/AppLayout.vue'

const isUser = true // Simulate user logged in

const posts = ref([
    {
        id: 1,
        user_id: 10,
        title: 'Vue 3 + Laravel: A Powerful Duo for Modern Web Apps',
        content: 'This post explains how Vue 3 and Laravel can work together to create powerful, reactive web applications with a robust backend. We explore the best practices for integrating these technologies.',
        image: 'https://source.unsplash.com/random/600x400/?web-development',
        visibility: 'public',
        created_at: '2025-04-11',
        updated_at: '2025-04-11',
        tags: [
            { id: 1, name: 'Vue' },
            { id: 2, name: 'Laravel' },
            { id: 3, name: 'Frontend' }
        ],
        liked: false,
        bookmarked: false,
        likes_count: 5
    },
    {
        id: 2,
        user_id: 11,
        title: 'Database Design Best Practices for Scalable Applications',
        content: 'Learn how to structure your relational databases for optimal performance and scalability. We cover normalization techniques, indexing strategies, and common pitfalls to avoid.',
        image: 'https://source.unsplash.com/random/600x400/?database',
        visibility: 'private',
        created_at: '2025-04-10',
        updated_at: '2025-04-10',
        tags: [
            { id: 4, name: 'Database' },
            { id: 5, name: 'MySQL' },
            { id: 6, name: 'Backend' }
        ],
        liked: true,
        bookmarked: true,
        likes_count: 8
    },
    // Add more sample posts as needed
])

// Computed excerpt for each post
posts.value = posts.value.map(post => ({
    ...post,
    excerpt: post.content.slice(0, 120) + (post.content.length > 120 ? '...' : '')
}))

const INITIAL_COUNT = 6
const LOAD_MORE_COUNT = 3

const displayedPosts = ref([])
const showScrollTop = ref(false)

const loadMorePosts = () => {
    const nextPosts = posts.value.slice(
        displayedPosts.value.length,
        displayedPosts.value.length + LOAD_MORE_COUNT
    )
    displayedPosts.value.push(...nextPosts)
}

const handleScroll = () => {
    showScrollTop.value = window.scrollY > 200
    // Auto-load more when near bottom (optional)
    if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight - 500) {
        loadMorePosts()
    }
}

const scrollToTop = () => {
    window.scrollTo({ top: 0, behavior: 'smooth' })
}

const toggleLike = (postId) => {
    const post = posts.value.find(p => p.id === postId)
    if (post) {
        post.liked = !post.liked
        post.likes_count += post.liked ? 1 : -1
    }
}

const toggleBookmark = (postId) => {
    const post = posts.value.find(p => p.id === postId)
    if (post) {
        post.bookmarked = !post.bookmarked
    }
}

const viewPost = (postId) => {
    console.log('Navigate to post detail:', postId)
    // router.push(`/posts/${postId}`) // If using Vue Router
}

const formatDate = (dateString) => {
    const options = { year: 'numeric', month: 'short', day: 'numeric' }
    return new Date(dateString).toLocaleDateString(undefined, options)
}

onMounted(() => {
    displayedPosts.value = posts.value.slice(0, INITIAL_COUNT)
    window.addEventListener('scroll', handleScroll)
})

onUnmounted(() => {
    window.removeEventListener('scroll', handleScroll)
})
</script>

<style scoped>
/* Gradient Text */
.text-gradient {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

/* Card Styles */
.blog-card {
    transition: all 0.3s ease;
    border: none;
    border-radius: 12px;
    overflow: hidden;
    background-color: #ffffff;
    cursor: pointer;
}

.blog-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
}

.card-img-container {
    position: relative;
    overflow: hidden;
    height: 200px;
}

.card-img-top {
    height: 100%;
    width: 100%;
    object-fit: cover;
    transition: transform 0.5s ease;
}

.blog-card:hover .card-img-top {
    transform: scale(1.05);
}

.card-img-overlay {
    background: linear-gradient(to top, rgba(0, 0, 0, 0.7) 0%, transparent 100%);
    padding: 1rem;
}

/* Excerpt with fade effect */
.excerpt-container {
    position: relative;
    max-height: 3.6em;
    overflow: hidden;
}

.excerpt-container::after {
    content: "";
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    height: 1.2em;
    background: linear-gradient(to bottom, transparent, white);
}

/* Tag Cloud */
.tag-cloud {
    display: flex;
    flex-wrap: wrap;
}

/* Scroll to Top Button */
.scroll-top {
    position: fixed;
    bottom: 30px;
    right: 30px;
    width: 50px;
    height: 50px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    opacity: 0.9;
    transition: all 0.3s ease;
    z-index: 1000;
}

.scroll-top:hover {
    opacity: 1;
    transform: translateY(-3px);
}

/* Staggered Animation */
.staggered-fade-move,
.staggered-fade-enter-active,
.staggered-fade-leave-active {
    transition: all 0.5s ease;
}

.staggered-fade-enter-from,
.staggered-fade-leave-to {
    opacity: 0;
    transform: translateY(20px);
}

.staggered-fade-leave-active {
    position: absolute;
}
</style>