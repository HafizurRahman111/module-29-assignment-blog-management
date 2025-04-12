<template>
    <AppLayout>
        <main class="auth-page">
            <div class="auth-container">
                <h2 class="auth-title">Login to Your Account</h2>

                <!-- Flash messages for success/error -->
                <FlashMessages :flash="flash" />
                <FormErrors :errors="form.errors" />

                <!-- Login Form -->
                <form @submit.prevent="login" class="auth-form">
                    <TextInput v-model="form.email" id="email" label="Email Address" type="email" :required="true"
                        :error="form.errors.email" />
                    <PasswordInput v-model="form.password" id="password" label="Password" :required="true"
                        :error="form.errors.password" />
                    <SubmitButton :label="'Login'" :disabled="form.processing" />
                    <LinkComponent href="/register" linkText="Don't have an account? Register" />
                </form>
            </div>
        </main>
    </AppLayout>
</template>

<script setup>
import AppLayout from '@/Layouts/AppLayout.vue';
import { ref, watch } from 'vue';
import { useForm, usePage } from '@inertiajs/vue3';
import FlashMessages from '@/Components/ui/alerts/FlashMessages.vue';
import FormErrors from '@/Components/ui/forms/inputs/FormErrors.vue';
import TextInput from '@/Components/ui/forms/inputs/TextInput.vue';
import PasswordInput from '@/Components/ui/forms/inputs/PasswordInput.vue';
import SubmitButton from '@/Components/ui/buttons/action/SubmitButton.vue';
import LinkComponent from '@/Components/ui/forms/inputs/LinkComponent.vue';

const form = useForm({
    email: '',
    password: '',
});

const page = usePage();
const flash = ref(page.props.flash || {});

watch(() => page.props.flash, (newFlash) => {
    flash.value = newFlash || {};
});

function login() {
    form.post('/login', {
        preserveScroll: true,
        onSuccess: (response) => {
            flash.value.success = 'Login successful.';
            flash.value.error = '';
            // window.location.href = '/dashboard';
        },
        onError: (errors) => {
            flash.value.success = '';
            flash.value.error = 'Login failed. Please check your credentials.';
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
    max-width: 400px;
    width: 100%;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
}

.auth-title {
    text-align: center;
    font-size: 1.75rem;
    font-weight: 700;
    color: var(--color-dark);
    margin-bottom: 2rem;
}
</style>
