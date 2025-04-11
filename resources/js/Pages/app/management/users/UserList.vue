<template>
  <DashboardLayout title="User Management">
    <div class="user-management-container">
      <DataTable title="User List" icon="fas fa-users" :items="users" :headers="headers" :searchable="true"
        :loading="loading" :delete-action="askDelete" search-placeholder="Search ..."
        :search-fields="['username', 'email']" @search="handleSearch">
        <!-- Profile Picture Slot -->
        <template #item-profile_pic="{ profile_pic }">
          <div class="profile-picture-container">
            <img v-if="profile_pic" :src="profile_pic" alt="User profile" class="profile-picture" loading="lazy" />
            <div v-else class="profile-picture-placeholder">
              <i class="fas fa-user-circle"></i>
            </div>
          </div>
        </template>

        <!-- Custom Empty State -->
        <template #empty-state>
          <div class="empty-state-content">
            <i class="fas fa-users-slash empty-state-icon"></i>
            <h5 class="empty-state-title">No users found</h5>
            <p v-if="searchQuery" class="empty-state-hint">Try a different search term</p>
            <router-link v-if="canCreateUsers" to="/users/create" class="btn btn-primary empty-state-button">
              <i class="fas fa-plus me-2"></i>Create New User
            </router-link>
          </div>
        </template>
      </DataTable>

      <!-- Delete Confirmation Modal -->
      <ConfirmDeleteModal :visible="showDeleteModal" :username="selectedUser?.username || 'Unknown'"
        :userId="selectedUser?.id || 'N/A'" @confirm="confirmDelete" @cancel="showDeleteModal = false" />

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
const users = ref(pageProps.users || []);
const searchQuery = ref('');
const loading = ref(false);
const error = ref(null);

// Modal + selected user
const showDeleteModal = ref(false);
const selectedUser = ref(null);

// Permissions
const canCreateUsers = computed(() => true);

// Table headers
const headers = [
  { text: 'Username', value: 'username', sortable: true, searchable: true },
  { text: 'Email', value: 'email', sortable: true, searchable: true },
  {
    text: 'Profile',
    value: 'profile_pic',
    sortable: false,
    align: 'center',
    width: '100px'
  },
  {
    text: 'Actions',
    value: 'actions',
    sortable: false,
    align: 'center',
    width: '200px'
  }
];

// Handle search input
const handleSearch = (query) => {
  searchQuery.value = query;
};

// Trigger delete modal
const askDelete = (user) => {
  console.log('Deleting user:', user);
  selectedUser.value = user;
  showDeleteModal.value = true;
};

// Delete confirmed
const confirmDelete = async () => {
  if (!selectedUser.value) return;

  showDeleteModal.value = false;
  loading.value = true;

  try {
    await axios.delete(`/api/users/${selectedUser.value.id}`);
    users.value = users.value.filter(u => u.id !== selectedUser.value.id);
    toaster.success('User deleted successfully');
  } catch (err) {
    console.error('Delete error:', err);
    error.value = err;
    toaster.error(err.response?.data?.message || 'Failed to delete user');
  } finally {
    loading.value = false;
    selectedUser.value = null;
  }
};

// Optional: refetch if page initially empty
const fetchUsers = async () => {
  if (users.value.length > 0) return;

  try {
    loading.value = true;
    const response = await axios.get('/users');
    users.value = response.data;
  } catch (err) {
    console.error('Fetch error:', err);
    error.value = err;
    toaster.error('Failed to load users');
  } finally {
    loading.value = false;
  }
};

onMounted(fetchUsers);
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
</style>
