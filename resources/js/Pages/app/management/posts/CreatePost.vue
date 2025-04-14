<template>
    <DashboardLayout>
        <main class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-8 col-md-10 col-12">
                    <div class="card shadow border-0">
                        <div class="card-body p-4">
                            <!-- Title -->
                            <h2 class="h4 text-primary text-center mb-4 fw-semibold">Create New Post</h2>

                            <!-- Flash & Errors -->
                            <FlashMessages :flash="flash" />
                            <FormErrors :errors="form.errors" />

                            <!-- Form -->
                            <form @submit.prevent="submit" enctype="multipart/form-data">
                                <!-- Title -->
                                <div class="mb-3">
                                    <label for="title" class="form-label fw-medium">Title <span
                                            class="text-danger">*</span></label>
                                    <input v-model="form.title" type="text" id="title" class="form-control"
                                        :class="{ 'is-invalid': form.errors.title }" placeholder="Enter post title" />
                                    <div v-if="form.errors.title" class="invalid-feedback">
                                        {{ form.errors.title }}
                                    </div>
                                </div>

                                <!-- Content -->
                                <div class="mb-3">
                                    <label for="content" class="form-label fw-medium">Content <span
                                            class="text-danger">*</span></label>
                                    <textarea v-model="form.content" id="content" class="form-control" rows="5"
                                        :class="{ 'is-invalid': form.errors.content }"
                                        placeholder="Write your post..."></textarea>
                                    <div v-if="form.errors.content" class="invalid-feedback">
                                        {{ form.errors.content }}
                                    </div>
                                </div>

                                <!-- Image -->
                                <div class="mb-3">
                                    <label for="image" class="form-label fw-medium">Image</label>
                                    <input @change="handleImageUpload" type="file" id="image" class="form-control"
                                        :class="{ 'is-invalid': form.errors.image }" accept="image/*" />
                                    <div v-if="form.errors.image" class="invalid-feedback">
                                        {{ form.errors.image }}
                                    </div>
                                </div>

                                <!-- Visibility -->
                                <div class="mb-3">
                                    <label for="visibility" class="form-label fw-medium">Visibility <span
                                            class="text-danger">*</span></label>
                                    <select v-model="form.visibility" id="visibility" class="form-select"
                                        :class="{ 'is-invalid': form.errors.visibility }">
                                        <option value="public">Public</option>
                                        <option value="private">Private</option>
                                    </select>
                                    <div v-if="form.errors.visibility" class="invalid-feedback">
                                        {{ form.errors.visibility }}
                                    </div>
                                </div>

                                <!-- Actions -->
                                <div
                                    class="d-flex flex-column flex-sm-row justify-content-between align-items-center gap-3 mt-4">
                                    <LinkComponent href="/posts" linkText="← Back to Posts"
                                        class="btn btn-outline-secondary w-100 w-sm-auto" />
                                    <SubmitButton :label="'Create Post'" :disabled="form.processing"
                                        class="btn btn-primary w-100 w-sm-auto" />
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </DashboardLayout>
</template>

<script setup>
import { ref, watch } from 'vue'
import { useForm, usePage } from '@inertiajs/vue3'

import DashboardLayout from '@/Layouts/DashboardLayout.vue'
import FlashMessages from '@/Components/ui/alerts/FlashMessages.vue'
import FormErrors from '@/Components/ui/forms/inputs/FormErrors.vue'
import SubmitButton from '@/Components/ui/buttons/action/SubmitButton.vue'
import LinkComponent from '@/Components/ui/forms/inputs/LinkComponent.vue'

const page = usePage()
const flash = ref(page.props.flash || {})

watch(() => page.props.flash, (newFlash) => {
    flash.value = newFlash || {}
})

const form = useForm({
    title: '',
    content: '',
    image: null,
    visibility: 'public',
})

const handleImageUpload = (e) => {
    form.image = e.target.files[0]
}

const submit = () => {
    if (!form.title.trim() || !form.content.trim()) {
        flash.value.error = 'Title and content are required.'
        return
    }

    form.post('/posts', {
        forceFormData: true,
        preserveScroll: true,
        onSuccess: () => {
            flash.value.success = 'Post created successfully.'
            form.reset()
        },
        onError: (errors) => {
            flash.value.error = 'Failed to create post. Please check the form.'
        },
    })
}
</script>

<style scoped>
.card:hover {
    box-shadow: 0 0.75rem 1.5rem rgba(0, 0, 0, 0.08);
    transition: box-shadow 0.3s ease-in-out;
}
</style>