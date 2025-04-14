<template>
    <DashboardLayout>
        <main class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-6 col-md-8 col-12">
                    <div class="card shadow border-0">
                        <div class="card-body p-4">
                            <!-- Title -->
                            <h2 class="h4 text-primary text-center mb-4 fw-semibold">Create New Tag</h2>

                            <!-- Flash & Errors -->
                            <FlashMessages :flash="flash" />
                            <FormErrors :errors="form.errors" />

                            <!-- Form -->
                            <form @submit.prevent="submit">
                                <!-- Tag Name -->
                                <div class="mb-3">
                                    <label for="name" class="form-label fw-medium">Tag Name <span
                                            class="text-danger">*</span></label>
                                    <input v-model="form.name" type="text" class="form-control"
                                        :class="{ 'is-invalid': form.errors.name }" id="name"
                                        placeholder="Enter tag name" required />
                                    <div v-if="form.errors.name" class="invalid-feedback">
                                        {{ form.errors.name }}
                                    </div>
                                </div>

                                <!-- Actions -->
                                <div
                                    class="d-flex flex-column flex-sm-row justify-content-between align-items-center gap-3 mt-4">
                                    <LinkComponent :href="'/tags'" linkText="← Back to Tags List"
                                        class="btn btn-outline-secondary w-100 w-sm-auto" />
                                    <SubmitButton :label="'Save Tag'" :disabled="form.processing"
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

const form = useForm({
    name: '',
})

const page = usePage()
const flash = ref(page.props.flash || {})

watch(() => page.props.flash, (newFlash) => {
    flash.value = newFlash || {}
})

const submit = () => {
    if (!form.name.trim()) {
        flash.value.error = 'Please enter a tag name.'
        return
    }

    const submittingTag = form.name

    form.post('/tags', {
        preserveScroll: true,
        onSuccess: () => {
            flash.value.success = `Tag "${submittingTag}" created successfully.`
            form.reset()
        },
        onError: (errors) => {
            if (errors.name && Array.isArray(errors.name)) {
                flash.value.error = errors.name[0]
            } else {
                flash.value.error = 'Failed to create tag. Please check the form.'
            }
        },
    })
}
</script>

<style scoped>
.card:hover {
    box-shadow: 0 0.75rem 1.5rem rgba(0, 0, 0, 0.08);
    transition: box-shadow 0.3s ease-in-out;
}

@media (max-width: 576px) {
    .form-control {
        margin-bottom: 1rem;
    }
}
</style>
