<template>
    <div>
        <div v-if="post">
            <!-- Post Title and User Info -->
            <h1>{{ post.title }}</h1>
            <p>By: {{ post.user.username }}</p>

            <!-- Post Content -->
            <div v-html="post.content"></div>

            <!-- Post Tags -->
            <div class="tags">
                <span v-for="tag in post.tags" :key="tag.id" class="badge bg-secondary me-1">
                    {{ tag.name }}
                </span>
            </div>

            <!-- Comments Section -->
            <div class="comments mt-4">
                <h3>Comments</h3>
                <div v-for="comment in post.comments" :key="comment.id" class="comment">
                    <p><strong>{{ comment.user.username }}:</strong> {{ comment.content }}</p>

                    <!-- Display Replies -->
                    <div v-if="comment.replies.length">
                        <div v-for="reply in comment.replies" :key="reply.id" class="reply">
                            <p><strong>{{ reply.user.username }}:</strong> {{ reply.content }}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div v-else>
            <p>Loading post...</p>
        </div>
    </div>
</template>

<script setup>
defineProps({
    post: Object
})
</script>

<style scoped>
/* Add custom styles for your component */
.comment {
    margin-bottom: 15px;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
}

.reply {
    margin-left: 20px;
    padding: 8px;
    border: 1px solid #eee;
    border-radius: 5px;
}

.tags .badge {
    margin-bottom: 5px;
}
</style>