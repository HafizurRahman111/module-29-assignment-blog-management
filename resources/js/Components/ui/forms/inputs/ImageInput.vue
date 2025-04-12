<template>
    <div class="form-group">
        <label :for="id" class="form-label">{{ label }} <span v-if="required" class="required">*</span></label>
        <input :id="id" type="file" accept="image/png, image/jpeg, image/jpg" @change="handleFileChange"
            class="form-control" />
        <div v-if="previewUrl" class="preview-container">
            <img :src="previewUrl" alt="Preview" class="image-preview" />
        </div>
        <small v-if="hint" class="hint">{{ hint }}</small>
        <div v-if="error" class="error-message">{{ error }}</div>
    </div>
</template>

<script setup>
import { ref, watch } from 'vue';

const props = defineProps({
    id: String,
    label: String,
    required: Boolean,
    error: String,
    hint: String,
    modelValue: File || null
});

const emit = defineEmits(['update:modelValue']);

const previewUrl = ref(null);

function handleFileChange(event) {
    const file = event.target.files[0];
    if (!file) return;

    const validTypes = ['image/jpeg', 'image/png', 'image/jpg'];
    const maxSize = 2 * 1024 * 1024; // 2MB

    if (!validTypes.includes(file.type)) {
        alert('Only JPG, JPEG, PNG images are allowed.');
        return;
    }

    if (file.size > maxSize) {
        alert('Image size must be less than 2MB.');
        return;
    }

    previewUrl.value = URL.createObjectURL(file);
    emit('update:modelValue', file);
}
</script>

<style scoped>
.form-group {
    display: flex;
    flex-direction: column;
    margin-bottom: 1rem;
}

.form-label {
    font-weight: 600;
    margin-bottom: 0.5rem;
}

.required {
    color: red;
}

.image-preview {
    width: 100px;
    height: 100px;
    object-fit: cover;
    border-radius: 0.5rem;
    margin-top: 0.5rem;
    border: 1px solid #ccc;
}

.error-message {
    color: red;
    font-size: 0.875rem;
    margin-top: 0.25rem;
}

.hint {
    font-size: 0.8rem;
    color: #666;
}
</style>
