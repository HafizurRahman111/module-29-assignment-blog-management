<template>
    <DashboardLayout>
      <div class="container-fluid mt-1">
        <div class="row justify-content-center">
          <div>
            <DataTable
              title="User List"
              icon="fa fa-users"
              :items="users"
              :headers="headers"
              add-route="/UserSavePage?id=0"
              :delete-action="handleDelete"
              search-placeholder="Search user..."
            />
          </div>
        </div>
      </div>
    </DashboardLayout>
  </template>
  
  <script setup>
  import { ref } from 'vue';
  import { usePage, router } from '@inertiajs/vue3';
  import axios from 'axios';
  import { createToaster } from '@meforma/vue-toaster';
  
  import DashboardLayout from '@/Layouts/DashboardLayout.vue';
  import DataTable from '@/Components/ui/data/DataTable/DataTable.vue';
  
  // Setup
  const page = usePage();
  const users = ref(page.props.users);
  const toaster = createToaster({ position: 'top-right' });
  
  // Search placeholder (if used internally in DataTable)
  const searchValue = ref('');
  
  // Table headers
  const headers = [
    { text: 'Username', value: 'username', sortable: true },
    { text: 'Email', value: 'email', sortable: true },
    { text: 'Profile Picture', value: 'profile_pic', sortable: false },
    { text: 'Actions', value: 'actions', sortable: false }
  ];
  
  // Delete action
  const handleDelete = async (id) => {
    const confirmed = confirm('Do you want to delete this user?');
    if (!confirmed) return;
  
    try {
      await axios.delete(`/users/delete/${id}`);
      toaster.success('User deleted successfully');
      router.reload({ only: ['users'] }); // Reload only the users prop
    } catch (error) {
      toaster.error('Failed to delete user');
      console.error('Delete error:', error);
    }
  };
  </script>
  