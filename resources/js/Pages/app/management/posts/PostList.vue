<template>
    <DashboardLayout title="Post Management">
        <div class="post-management-container">
            <DataTable title="Post List" icon="fas fa-newspaper" :items="posts" :headers="headers" :searchable="true"
                :loading="loading" :delete-action="askDelete" search-placeholder="Search ..."
                :search-fields="['title', 'content']" @search="handleSearch">
                <!-- Profile Picture Slot -->
                <template #item-profile_pic="{ profile_pic }">
                    <div class="profile-picture-container">
                        <img v-if="profile_pic" :src="profile_pic" alt="Post image" class="profile-picture"
                            loading="lazy" />
                        <div v-else class="profile-picture-placeholder">
                            <i class="fas fa-image"></i>
                        </div>
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
            <ConfirmDeleteModal :visible="showDeleteModal" :username="selectedPost?.title || 'Unknown'"
                :userId="selectedPost?.id || 'N/A'" @confirm="confirmDelete" @cancel="showDeleteModal = false" />
        </div>
    </DashboardLayout>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { usePage } from '@inertiajs/vue3';
import axios from 'axios';
import { createToaster } from '@meforma/vue-toaster';

// Components
import DashboardLayout from '@/Layouts/DashboardLayout.vue';
import DataTable from '@/Components/ui/data/DataTable/DataTable.vue';
import ConfirmDeleteModal from '@/Components/ui/modals/ConfirmDeleteModal.vue';

// Toaster config
const toaster = createToaster({
    position: 'top-right',
    duration: 3000,
    maxToasts: 3
});

// Initial props from server
const { props: pageProps } = usePage();
const posts = ref(pageProps.posts || []);
const searchQuery = ref('');
const loading = ref(false);
const error = ref(null);

// Modal + selected post
const showDeleteModal = ref(false);
const selectedPost = ref(null);

// Permissions
const canCreatePosts = computed(() => true);

// Table headers
const headers = [
    { text: 'Title', value: 'title', sortable: true, searchable: true },
    { text: 'Content', value: 'content', sortable: true, searchable: true },
    { text: 'Image', value: 'image', sortable: false, searchable: false, align: 'center', width: '100px' },
    { text: 'Visibility', value: 'visibility', sortable: true, searchable: true },
    { text: 'Actions', value: 'actions', sortable: false, align: 'center', width: '200px' }
];

// Handle search input
const handleSearch = (query) => {
    searchQuery.value = query;
};

// Trigger delete modal
const askDelete = (post) => {
    console.log('Deleting post:', post);
    selectedPost.value = post;
    showDeleteModal.value = true;
};

// Delete confirmed
const confirmDelete = async () => {
    if (!selectedPost.value) return;

    showDeleteModal.value = false;
    loading.value = true;

    try {
        // Make sure you have the correct API endpoint for posts
        await axios.delete(`/posts/${selectedPost.value.id}`);
        // Filter out the deleted post from the local posts array
        posts.value = posts.value.filter(p => p.id !== selectedPost.value.id);
        toaster.success('Post deleted successfully');
    } catch (err) {
        console.error('Delete error:', err);
        error.value = err;
        toaster.error(err.response?.data?.message || 'Failed to delete post');
    } finally {
        loading.value = false;
        selectedPost.value = null;
    }
};

// Optional: refetch if page initially empty
const fetchPosts = async () => {
    if (posts.value.length > 0) return;

    try {
        loading.value = true;
        const response = await axios.get('/posts');
        posts.value = response.data;
    } catch (err) {
        console.error('Fetch error:', err);
        error.value = err;
        toaster.error('Failed to load posts');
    } finally {
        loading.value = false;
    }
};

onMounted(fetchPosts);
</script>


<style scoped>
.profile-picture-container {
    display: flex;
    justify-content: center;
    align-items: center;
}

.profile-picture {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    object-fit: cover;
}

.profile-picture-placeholder {
    width: 36px;
    height: 36px;
    font-size: 1.8rem;
    color: #ccc;
    display: flex;
    align-items: center;
    justify-content: center;
}

.empty-state-content {
    text-align: center;
    padding: 2rem;
}

.empty-state-icon {
    font-size: 3rem;
    color: #aaa;
}

.empty-state-title {
    margin-top: 1rem;
    font-weight: bold;
}

.empty-state-hint {
    color: #666;
}

.empty-state-button {
    margin-top: 1.5rem;
}

.badge {
    padding: 5px 10px;
    font-size: 14px;
    border-radius: 20px;
    text-transform: capitalize;
}

.badge-success {
    background-color: #28a745;
    /* Green */
    color: white;
}

.badge-danger {
    background-color: #dc3545;
    /* Red */
    color: white;
}
</style>