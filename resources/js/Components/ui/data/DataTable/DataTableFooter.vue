<template>
  <div class="data-table-footer">
    <!-- Items per page selector -->
    <div class="footer-left">
      <div class="items-per-page">
        <span class="label">Items per page:</span>
        <select v-model="localRowsPerPage" class="form-select form-select-sm" @change="handleRowsPerPageChange">
          <option v-for="option in pageSizeOptions" :value="option" :key="option">
            {{ option }}
          </option>
        </select>
      </div>

      <div class="item-count">
        Showing {{ startItem }} to {{ endItem }} of {{ totalItems }} entries
      </div>
    </div>

    <!-- Pagination controls -->
    <div class="footer-right">
      <button class="btn btn-sm btn-outline-secondary view-button" @click="$emit('view-all')" v-if="showViewButton">
        <i class="fas fa-eye me-1"></i> View All
      </button>

      <nav aria-label="Table navigation">
        <ul class="pagination pagination-sm">
          <li class="page-item" :class="{ disabled: currentPage === 1 }">
            <button class="page-link" @click="changePage(currentPage - 1)" :disabled="currentPage === 1">
              &laquo;
            </button>
          </li>

          <li v-for="page in visiblePages" :key="page" class="page-item" :class="{ active: page === currentPage }">
            <button class="page-link" @click="changePage(page)">
              {{ page }}
            </button>
          </li>

          <li class="page-item" :class="{ disabled: currentPage === totalPages }">
            <button class="page-link" @click="changePage(currentPage + 1)" :disabled="currentPage === totalPages">
              &raquo;
            </button>
          </li>
        </ul>
      </nav>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue';

const props = defineProps({
  totalItems: { type: Number, required: true },
  rowsPerPage: { type: Number, default: 10 },
  currentPage: { type: Number, default: 1 },
  showViewButton: { type: Boolean, default: true },
  maxVisiblePages: { type: Number, default: 5 }
});

const emit = defineEmits(['page-change', 'rows-per-page-change', 'view-all']);

const localRowsPerPage = ref(props.rowsPerPage);
const localCurrentPage = ref(props.currentPage);

const pageSizeOptions = [10, 20, 25, 50, 100, 500];

// Computed properties
const totalPages = computed(() => Math.ceil(props.totalItems / localRowsPerPage.value));
const startItem = computed(() => (localCurrentPage.value - 1) * localRowsPerPage.value + 1);
const endItem = computed(() => Math.min(localCurrentPage.value * localRowsPerPage.value, props.totalItems));

const visiblePages = computed(() => {
  const pages = [];
  let startPage = Math.max(1, localCurrentPage.value - Math.floor(props.maxVisiblePages / 2));
  let endPage = Math.min(totalPages.value, startPage + props.maxVisiblePages - 1);

  // Adjust if we're at the start or end
  if (endPage - startPage + 1 < props.maxVisiblePages) {
    startPage = Math.max(1, endPage - props.maxVisiblePages + 1);
  }

  for (let i = startPage; i <= endPage; i++) {
    pages.push(i);
  }

  return pages;
});

// Watchers
watch(() => props.currentPage, (newVal) => {
  localCurrentPage.value = newVal;
});

watch(() => props.rowsPerPage, (newVal) => {
  localRowsPerPage.value = newVal;
});

// Methods
const changePage = (page) => {
  if (page < 1 || page > totalPages.value || page === localCurrentPage.value) return;

  localCurrentPage.value = page;
  emit('page-change', page);
};

const handleRowsPerPageChange = () => {
  localCurrentPage.value = 1;
  emit('rows-per-page-change', localRowsPerPage.value);
  emit('page-change', 1);
};
</script>

<style scoped>
.data-table-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  background-color: #f8fafc;
  border-top: 1px solid #e2e8f0;
  flex-wrap: wrap;
  gap: 1rem;
}

.footer-left {
  display: flex;
  align-items: center;
  gap: 1.5rem;
}

.footer-right {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.items-per-page {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.label {
  font-size: 0.8125rem;
  color: #64748b;
}

.item-count {
  font-size: 0.8125rem;
  color: #64748b;
}

.form-select {
  width: auto;
  display: inline-block;
}

.view-button {
  border-radius: 4px;
  padding: 0.25rem 0.75rem;
  transition: all 0.2s ease;
  border-color: #cbd5e1;
}

.view-button:hover {
  background-color: #f1f5f9;
  border-color: #94a3b8;
}

.pagination {
  margin-bottom: 0;
}

.page-link {
  min-width: 32px;
  text-align: center;
  color: #475569;
  border-color: #e2e8f0;
}

.page-item.active .page-link {
  background-color: #4f46e5;
  border-color: #4f46e5;
}

.page-item.disabled .page-link {
  color: #94a3b8;
  background-color: #f8fafc;
}

@media (max-width: 768px) {
  .data-table-footer {
    flex-direction: column;
    align-items: stretch;
  }

  .footer-left,
  .footer-right {
    width: 100%;
    justify-content: space-between;
  }

  .items-per-page {
    flex: 1;
  }

  .item-count {
    display: none;
  }
}
</style>