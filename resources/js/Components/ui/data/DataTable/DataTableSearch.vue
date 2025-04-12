<template>
    <div class="position-relative" style="min-width: 240px;">
        <input v-model="searchValue" type="text" :placeholder="placeholder" class="form-control form-control-sm ps-5"
            @input="handleInput">
        <i class="fas fa-search position-absolute top-50 start-0 translate-middle-y ms-3 text-muted"></i>
    </div>
</template>

<script setup>
import { ref } from 'vue';

const props = defineProps({
    placeholder: { type: String, default: 'Search...' }
});

const emit = defineEmits(['search']);

const searchValue = ref('');

const handleInput = () => {
    emit('search', searchValue.value);
};
</script>