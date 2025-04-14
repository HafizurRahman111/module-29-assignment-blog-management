<template>
    <DashboardLayout>
        <section class="edit-tag-section">
            <div class="form-wrapper">
                <!-- Title -->
                <h2 class="form-title">Edit Tag</h2>

                <!-- Flash Messages & Errors -->
                <FlashMessages :flash="flash" />
                <FormErrors :errors="form.errors" />

                <!-- Form -->
                <form @submit.prevent="submit" class="tag-form">
                    <!-- Name -->
                    <TextInput v-model="form.name" id="name" label="Tag Name" :required="true" :error="form.errors.name"
                        placeholder="Enter tag name" class="mb-6" />

                    <!-- Actions -->
                    <div class="actions">
                        <LinkComponent :href="'/tags'" linkText="← Back to Tags List"
                            class="btn btn-outline-secondary w-100 w-sm-auto" />
                        <SubmitButton :label="'Update Tag'" :disabled="form.processing" class="w-100 w-sm-auto" />
                    </div>
                </form>
            </div>
        </section>
    </DashboardLayout>
</template>

<script setup>
import { ref, watch } from 'vue'
import { useForm, usePage } from '@inertiajs/vue3'

import DashboardLayout from '@/Layouts/DashboardLayout.vue'
import FlashMessages from '@/Components/ui/alerts/FlashMessages.vue'
import FormErrors from '@/Components/ui/forms/inputs/FormErrors.vue'
import TextInput from '@/Components/ui/forms/inputs/TextInput.vue'
import SubmitButton from '@/Components/ui/buttons/action/SubmitButton.vue'
import LinkComponent from '@/Components/ui/forms/inputs/LinkComponent.vue'

// Props & reactive data
const page = usePage()
const flash = ref(page.props.flash || {})

const form = useForm({
    id: page.props.tag?.id || '',
    name: page.props.tag?.name || '',
})

// Watch flash changes
watch(() => page.props.flash, (newFlash) => {
    flash.value = newFlash || {}
})

// Submit form
const submit = () => {
    if (!form.name.trim()) {
        flash.value.error = 'Tag name is required.'
        return
    }

    const updatedName = form.name

    form.put(`/tags/${page.props.tag.id}`, {
        preserveScroll: true,
        onSuccess: () => {
            flash.value.success = `Tag "${updatedName}" updated successfully.`
        },
        onError: (errors) => {
            flash.value.error =
                errors.name?.[0] ||
                errors.description?.[0] ||
                'Something went wrong. Please try again.'
        },
    })
}
</script>

<style scoped>
.edit-tag-section {
    display: flex;
    justify-content: center;
    padding: 3rem 1rem;
    background-color: #f8fafc;
    align-items: center;
}

.form-wrapper {
    width: 100%;
    max-width: 600px;
    background: #ffffff;
    padding: 2.5rem 2rem;
    border-radius: 1rem;
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.05);
}

.form-title {
    font-size: 1.75rem;
    font-weight: 700;
    color: #333;
    margin-bottom: 1.5rem;
    text-align: center;
}

.actions {
    display: flex;
    flex-direction: column;
    gap: 1rem;
    justify-content: flex-end;
    margin-top: 2rem;
}

@media (min-width: 640px) {
    .actions {
        flex-direction: row;
        justify-content: flex-end;
    }
}

/* Mobile optimization */
@media (max-width: 640px) {
    .form-wrapper {
        padding: 2rem 1.5rem;
    }

    .form-title {
        font-size: 1.5rem;
    }

    .actions {
        flex-direction: column;
    }
}
</style>
