<template>
    <div class="card h-100 shadow-sm border-0 overflow-hidden">
        <!-- Post Image -->
        <div class="card-img-top position-relative" style="height: 180px; overflow: hidden;">
            <img v-if="post.image" :src="post.image" :alt="post.title" class="img-fluid w-100 h-100 object-fit-cover"
                loading="lazy">
            <div v-else class="d-flex align-items-center justify-content-center bg-light h-100">
                <i class="fas fa-image fa-3x text-muted"></i>
            </div>

            <!-- Visibility, Like, and Bookmark Icons -->
            <div class="position-absolute top-0 end-0 m-2 d-flex flex-column">
                <span :class="`badge ${post.visibility === 'public' ? 'bg-success' : 'bg-danger'}`">
                    {{ post.visibility === 'public' ? 'Public' : 'Private' }}
                </span>
                <div class="d-flex mt-2">
                    <!-- Like Count -->
                    <span class="btn btn-sm btn-outline-success me-1" title="Likes">
                        <i class="far fa-thumbs-up"></i>
                        <span>{{ post.likes_count }}</span>
                    </span>

                    <!-- Bookmark Count -->
                    <span class="btn btn-sm btn-outline-warning" title="Bookmarks">
                        <i class="fas fa-bookmark"></i>
                        <span>{{ post.bookmarks_count }}</span>
                    </span>
                </div>
            </div>
        </div>

        <!-- Card Body -->
        <div class="card-body d-flex flex-column">
            <h5 class="card-title fw-bold mb-2">{{ post.title }}</h5>
            <p class="card-text text-muted small mb-3">{{ truncateContent(post.content) }}</p>

            <!-- Tags -->
            <div class="mb-2">
                <span v-for="tag in post.tags" :key="tag.id" class="badge bg-light text-dark me-1 mb-1 border">
                    #{{ tag.name }}
                </span>
            </div>

            <!-- Author -->
            <div class="mb-3">
                <small class="text-muted">
                    <i class="fas fa-user me-1"></i>
                    {{ post.user?.username || 'Unknown User' }}
                </small>
            </div>

            <!-- Actions -->
            <div class="mt-auto d-flex justify-content-between align-items-center">
                <small class="text-muted">
                    <i class="far fa-calendar-alt me-1"></i>
                    {{ formatDate(post.created_at) }}
                </small>
                <div class="action-buttons d-flex">
                    <!-- Comments Count -->
                    <span class="btn btn-sm btn-outline-info me-1" title="Comments">
                        <i class="far fa-comments"></i>
                        <span>{{ post.comments_count }}</span>
                    </span>

                    <!-- View, Edit, Delete -->
                    <Link :href="`/posts/${post.id}`" class="btn btn-sm btn-outline-primary me-1" title="View">
                    <i class="far fa-eye"></i>
                    </Link>
                    <router-link :to="`/posts/edit/${post.id}`" class="btn btn-sm btn-outline-secondary me-1"
                        title="Edit">
                        <i class="far fa-edit"></i>
                    </router-link>
                    <button @click.stop="$emit('delete', post)" class="btn btn-sm btn-outline-danger" title="Delete">
                        <i class="far fa-trash-alt"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { Link } from '@inertiajs/vue3'

defineProps(['post'])
defineEmits(['delete'])

const truncateContent = (content) => {
    if (typeof content !== 'string') return ''
    return content.length > 100 ? content.substring(0, 100) + '...' : content
}

const formatDate = (date) => {
    return new Date(date).toLocaleDateString(undefined, {
        year: 'numeric',
        month: 'short',
        day: 'numeric'
    })
}
</script>

<style scoped>
.card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
}

.card-img-top {
    border-top-left-radius: 0.5rem;
    border-top-right-radius: 0.5rem;
}

.position-absolute {
    z-index: 1;
}

.action-buttons button {
    transition: transform 0.3s ease;
}

.action-buttons button:hover {
    transform: scale(1.1);
}

.action-buttons .btn-outline-warning {
    transition: background-color 0.3s ease;
}

.action-buttons .btn-outline-warning:hover {
    background-color: #f8d7da;
}
</style>
