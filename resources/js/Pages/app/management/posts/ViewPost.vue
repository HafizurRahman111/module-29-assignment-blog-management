<template>
    <DashboardLayout>
        <div class="post-detail-container bg-light">
            <!-- Hero Section -->
            <div class="post-hero bg-dark text-white py-5">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-10 text-center">
                            <h1 class="display-5 fw-bold mb-3">{{ post.title }}</h1>
                            <div class="d-flex justify-content-center align-items-center">
                                <div class="avatar-sm me-3">
                                    <img :src="post.user.avatar" class="rounded-circle" width="40" height="40"
                                        alt="Author">
                                </div>
                                <div class="text-start">
                                    <p class="mb-0">By <strong>{{ post.user.username }}</strong></p>
                                    <small class="text-white-50">{{ formatDate(post.created_at) }}</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="container-fluid px-0">
                <div class="row g-0">
                    <!-- Featured Image (Full Width) -->
                    <div v-if="post.image" class="col-12 mb-4">
                        <img :src="post.image" class="img-fluid w-100" alt="Featured Image"
                            style="max-height: 500px; object-fit: cover;">
                    </div>

                    <!-- Content Section -->
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-10">
                                <!-- Post Content -->
                                <article class="post-content mb-5">
                                    <div class="content-html" v-html="post.content"></div>
                                </article>

                                <!-- Tags -->
                                <div v-if="post.tags.length" class="tags mb-5">
                                    <span v-for="tag in post.tags" :key="tag.id" class="badge bg-primary me-2 mb-2">
                                        #{{ tag.name }}
                                    </span>
                                </div>

                                <!-- Stats Bar -->
                                <div
                                    class="stats-bar d-flex justify-content-between align-items-center border-top border-bottom py-3 mb-5">
                                    <div class="stat-item">
                                        <i class="fas fa-eye me-2"></i>
                                        <span>{{ post.views }} Views</span>
                                    </div>
                                    <div class="stat-item">
                                        <i class="fas fa-comments me-2"></i>
                                        <span>{{ post.comments.length }} Comments</span>
                                    </div>
                                    <div class="stat-item">
                                        <i class="fas fa-bookmark me-2"></i>
                                        <span>{{ post.bookmarks_count }} Bookmarks</span>
                                    </div>
                                    <div class="stat-item">
                                        <button class="btn btn-sm btn-outline-secondary">
                                            <i class="fas fa-share"></i> Share
                                        </button>
                                    </div>
                                </div>

                                <!-- Comments Section -->
                                <div class="comments-section mb-5">
                                    <h3 class="fw-bold mb-4 pb-2 border-bottom">
                                        <i class="fas fa-comments me-2"></i>Discussion ({{ post.comments.length }})
                                    </h3>

                                    <!-- Comment List -->
                                    <div v-if="post.comments.length" class="comment-list">
                                        <div v-for="comment in post.comments" :key="comment.id"
                                            class="comment-card mb-4">
                                            <div class="d-flex">
                                                <div class="flex-shrink-0 me-3">
                                                    <img :src="comment.user.avatar" class="rounded-circle" width="50"
                                                        height="50" alt="Commenter">
                                                </div>
                                                <div class="flex-grow-1">
                                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                                        <h5 class="mb-0">{{ comment.user.username }}</h5>
                                                        <small class="text-muted">{{ formatDate(comment.created_at)
                                                        }}</small>
                                                    </div>
                                                    <p class="mb-3">{{ comment.content }}</p>

                                                    <!-- Replies -->
                                                    <div v-if="comment.replies.length"
                                                        class="replies ms-4 ps-3 border-start">
                                                        <div v-for="reply in comment.replies" :key="reply.id"
                                                            class="reply-card py-3">
                                                            <div class="d-flex">
                                                                <div class="flex-shrink-0 me-3">
                                                                    <img :src="reply.user.avatar" class="rounded-circle"
                                                                        width="40" height="40" alt="Replier">
                                                                </div>
                                                                <div class="flex-grow-1">
                                                                    <div
                                                                        class="d-flex justify-content-between align-items-center mb-2">
                                                                        <h6 class="mb-0">{{ reply.user.username }}</h6>
                                                                        <small class="text-muted">{{
                                                                            formatDate(reply.created_at) }}</small>
                                                                    </div>
                                                                    <p class="mb-0">{{ reply.content }}</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Reply Button -->
                                                    <button v-if="userLoggedIn" @click="toggleReply(comment.id)"
                                                        class="btn btn-sm btn-link ps-0">
                                                        <i class="fas fa-reply me-1"></i> Reply
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- No Comments -->
                                    <div v-else class="no-comments text-center py-5 bg-light rounded">
                                        <i class="fas fa-comment-slash fa-2x text-muted mb-3"></i>
                                        <h5>No comments yet</h5>
                                        <p>Be the first to share what you think!</p>
                                    </div>
                                </div>

                                <!-- Add Comment (Logged In Users) -->
                                <div v-if="userLoggedIn" class="add-comment-card card border-0 shadow-sm mb-5">
                                    <div class="card-body p-4">
                                        <h4 class="mb-4">Leave a comment</h4>
                                        <textarea v-model="newComment" class="form-control mb-3" rows="4"
                                            placeholder="Write your thoughts..."></textarea>
                                        <div class="d-flex justify-content-end">
                                            <button @click="submitComment" class="btn btn-primary px-4">
                                                <i class="fas fa-paper-plane me-2"></i> Post Comment
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <!-- Back Button -->
                                <div class="text-center mb-5">
                                    <LinkComponent href="/posts" linkText="Back to All Posts"
                                        class="btn btn-outline-primary px-4" icon="fas fa-arrow-left" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </DashboardLayout>
</template>

<script setup>
import { ref, watch } from 'vue'
import { usePage } from '@inertiajs/vue3'
import DashboardLayout from '@/Layouts/DashboardLayout.vue'
import LinkComponent from '@/Components/ui/forms/inputs/LinkComponent.vue'

const page = usePage()
const post = ref(page.props.post)
const userLoggedIn = ref(page.props.auth.user)
const newComment = ref('')

const formatDate = (dateString) => {
    const options = { year: 'numeric', month: 'short', day: 'numeric' }
    return new Date(dateString).toLocaleDateString(undefined, options)
}

const toggleReply = (commentId) => {
    // Implement reply functionality
}

const submitComment = () => {
    if (newComment.value.trim()) {
        console.log('New comment submitted:', newComment.value)
        newComment.value = ''
    }
}

watch(() => page.props.post, (newPost) => {
    post.value = newPost
})
</script>

<style scoped>
.post-detail-container {
    min-height: 100vh;
}

.post-hero {
    padding: 4rem 0;
    margin-bottom: 3rem;
    background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)),
        var(--post-hero-bg, #000);
    background-size: cover;
    background-position: center;
}

.content-html {
    line-height: 1.8;
    font-size: 1.1rem;
}

.content-html :deep(img) {
    max-width: 100%;
    height: auto;
    border-radius: 0.5rem;
    margin: 1.5rem 0;
}

.content-html :deep(h2) {
    margin-top: 2.5rem;
    margin-bottom: 1.5rem;
    font-weight: 600;
}

.content-html :deep(a) {
    color: var(--bs-primary);
    text-decoration: none;
}

.stats-bar {
    background-color: rgba(0, 0, 0, 0.02);
}

.stat-item {
    display: flex;
    align-items: center;
    font-size: 0.9rem;
}

.comment-card,
.reply-card {
    padding: 1.5rem;
    background-color: #fff;
    border-radius: 0.5rem;
    box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
}

.replies {
    border-color: rgba(0, 0, 0, 0.1) !important;
}

.add-comment-card {
    border-radius: 0.5rem;
}

@media (max-width: 768px) {
    .post-hero {
        padding: 3rem 0;
    }

    .stats-bar {
        flex-wrap: wrap;
        gap: 1rem;
    }

    .stat-item {
        flex: 1 0 45%;
    }
}
</style>