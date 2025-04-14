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
                        <div class="card-img-container">
                            <img :src="post.image" :alt="post.title" class="card-img-top img-fluid rounded-top-3"
                                loading="lazy" />
                            <div class="card-img-overlay d-flex align-items-end">
                                <div class="badge bg-primary bg-opacity-75 mb-2">
                                    {{ post.visibility === 'public' ? 'Public' : 'Private' }}
                                </div>
                            </div>
                        </div>

                        <div class="card-body d-flex flex-column">
                            <h3 class="card-title fw-bold mb-3 text-dark">
                                {{ post.title }}
                                <i class="bi bi-arrow-right-circle-fill ms-2 text-primary"></i>
                            </h3>

                            <div class="excerpt-container mb-3">
                                <p class="card-text text-muted mb-0">{{ post.excerpt }}</p>
                            </div>

                            <div class="tag-cloud mb-3">
                                <span v-for="tag in post.tags" :key="tag.id"
                                    class="badge bg-light text-dark me-1 mb-1 border">
                                    #{{ tag.name }}
                                </span>
                            </div>

                            <div class="mt-auto d-flex justify-content-between align-items-center">
                                <small class="text-muted">
                                    <i class="bi bi-calendar me-1"></i>
                                    {{ formatDate(post.created_at) }}
                                </small>

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
import { usePage } from '@inertiajs/vue3'
import { ref, onMounted, onUnmounted } from 'vue'
import Layout from '../../Layouts/AppLayout.vue'

const isUser = true // Simulated user login
const { posts: rawPosts } = usePage().props

// Format and enhance posts with excerpts
const posts = ref(
    rawPosts.map((post) => ({
        ...post,
        excerpt: post.content.length > 120 ? post.content.slice(0, 120) + '...' : post.content,
        liked: post.liked ?? false,
        bookmarked: post.bookmarked ?? false,
    }))
)

const displayedPosts = ref([])
const showScrollTop = ref(false)

const INITIAL_COUNT = 6
const LOAD_MORE_COUNT = 3

// Load more posts on demand or scroll
const loadMorePosts = () => {
    const start = displayedPosts.value.length
    const nextPosts = posts.value.slice(start, start + LOAD_MORE_COUNT)
    displayedPosts.value.push(...nextPosts)
}

const handleScroll = () => {
    showScrollTop.value = window.scrollY > 200
    const nearBottom = window.innerHeight + window.scrollY >= document.body.offsetHeight - 300
    if (nearBottom) loadMorePosts()
}

const scrollToTop = () => {
    window.scrollTo({ top: 0, behavior: 'smooth' })
}

// Like post
const toggleLike = (postId) => {
    const post = posts.value.find((p) => p.id === postId)
    if (post) {
        post.liked = !post.liked
        post.likes_count += post.liked ? 1 : -1
    }
}

// Bookmark post
const toggleBookmark = (postId) => {
    const post = posts.value.find((p) => p.id === postId)
    if (post) post.bookmarked = !post.bookmarked
}

// View post action
const viewPost = (postId) => {
    // Replace with router push if using Vue Router
    console.log('Navigate to post:', postId)
}

// Format date nicely
const formatDate = (dateString) => {
    return new Date(dateString).toLocaleDateString(undefined, {
        year: 'numeric',
        month: 'short',
        day: 'numeric',
    })
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
.text-gradient {
    background: linear-gradient(135deg, #667eea, #764ba2);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.blog-card {
    transition: all 0.3s ease;
    border: none;
    border-radius: 12px;
    overflow: hidden;
    background-color: #fff;
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
    background: linear-gradient(to top, rgba(0, 0, 0, 0.7), transparent);
    padding: 1rem;
}

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

.tag-cloud {
    display: flex;
    flex-wrap: wrap;
}

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

/* Animations */
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