<template>
    <AppLayout>
        <main class="auth-page">
            <div class="auth-container">
                <h2 class="auth-title">Create Your Account</h2>

                <!-- Flash messages & error summaries -->
                <FlashMessages :flash="flash" />
                <FormErrors :errors="form.errors" />

                <!-- Registration Form -->
                <form @submit.prevent="submit" class="auth-form form-grid">
                    <!-- Column 1 -->
                    <div>
                        <TextInput v-model="form.username" id="username" label="Username" type="text" :required="true"
                            :error="form.errors.username" autofocus />
                        <PasswordInput v-model="form.password" id="password" label="Password" :required="true"
                            :error="form.errors.password" />
                        <ImageInput v-model="form.profile_pic" id="profile_pic" label="Profile Picture" :required="true"
                            :error="form.errors.profile_pic" hint="Supported: JPG, JPEG, PNG (max 2MB)" />
                    </div>

                    <!-- Column 2 -->
                    <div>
                        <TextInput v-model="form.email" id="email" label="Email Address" type="email" :required="true"
                            :error="form.errors.email" />
                        <PasswordInput v-model="form.password_confirmation" id="password_confirmation"
                            label="Confirm Password" :required="true" :error="form.errors.password_confirmation" />
                    </div>

                    <!-- Actions (Full width) -->
                    <div class="form-actions">
                        <SubmitButton :label="'Create Account'" :disabled="form.processing" />
                        <LinkComponent href="/login" linkText="Already have an account? Login" />
                    </div>
                </form>
            </div>
        </main>
    </AppLayout>
</template>

<script setup>
import AppLayout from '@/Layouts/AppLayout.vue';
import { ref, watch } from 'vue';
import { useForm, usePage, router } from '@inertiajs/vue3';
import FlashMessages from '@/Components/ui/alerts/FlashMessages.vue';
import FormErrors from '@/Components/ui/forms/inputs/FormErrors.vue';
import TextInput from '@/Components/ui/forms/inputs/TextInput.vue';
import ImageInput from '@/Components/ui/forms/inputs/ImageInput.vue';
import PasswordInput from '@/Components/ui/forms/inputs/PasswordInput.vue';
import SubmitButton from '@/Components/ui/buttons/action/SubmitButton.vue';
import LinkComponent from '@/Components/ui/forms/inputs/LinkComponent.vue';

const form = useForm({
    username: '',
    email: '',
    profile_pic: '',
    password: '',
    password_confirmation: '',
});

const page = usePage();
const flash = ref(page.props.flash || {});

watch(() => page.props.flash, (newFlash) => {
    flash.value = newFlash || {};
});

function submit() {
    form.post('/register', {
        preserveScroll: true,
        onSuccess: (response) => {
            flash.value.success = response.message || 'Account created successfully!';

        },
        onError: (errors) => {
            flash.value.error = 'Please correct the errors below';
        },
    });
}
</script>

<style scoped>
.auth-page {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 90vh;
}

.auth-container {
    background: white;
    padding: 2.5rem;
    border-radius: 1rem;
    max-width: 700px;
    width: 100%;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
}

.auth-title {
    text-align: center;
    font-size: 1.75rem;
    font-weight: 700;
    color: var(--color-gray-800);
    margin-bottom: 2rem;
}

.form-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 1.5rem;
}

.form-actions {
    grid-column: span 2;
    display: flex;
    flex-direction: column;
    gap: 1rem;
    margin-top: 1rem;
    align-items: flex-start;
}

/* Mobile responsive */
@media (max-width: 640px) {
    .form-grid {
        grid-template-columns: 1fr;
    }

    .form-actions {
        grid-column: span 1;
        width: 100%;
        align-items: stretch;
    }
}
</style>
