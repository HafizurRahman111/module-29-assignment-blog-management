<template>
    <PublicLayout>
        <main class="auth-page">
            <div class="auth-container">
                <h2 class="auth-title">Login to Your Account</h2>

                <!-- Flash Messages -->
                <div v-if="flash.success || flash.error" class="flash-messages">
                    <div v-if="flash.success" class="flash-success">
                        {{ flash.success }}
                    </div>
                    <div v-if="flash.error" class="flash-error">
                        {{ flash.error }}
                    </div>
                </div>

                <!-- Validation Errors -->
                <div v-if="Object.keys(form.errors).length" class="form-errors">
                    <div v-for="(error, field) in form.errors" :key="field" class="form-error">
                        {{ error }}
                    </div>
                </div>

                <form @submit.prevent="login" class="auth-form">
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input v-model="form.email" type="email" id="email" required />
                    </div>

                    <div class="form-group">
                        <label for="password">Password</label>
                        <div class="password-input">
                            <input v-model="form.password" :type="passwordVisible ? 'text' : 'password'" id="password"
                                required />
                            <button type="button" @click="togglePasswordVisibility" class="toggle-password">
                                <span v-if="passwordVisible">👁️</span>
                                <span v-else>👁️‍🗨️</span>
                            </button>
                        </div>
                    </div>

                    <button type="submit" class="auth-button" :disabled="form.processing">
                        <span v-if="form.processing">Logging in...</span>
                        <span v-else>Login</span>
                    </button>

                    <p class="auth-switch">
                        Don't have an account?
                        <Link href="/register">Register</Link>
                    </p>
                </form>
            </div>
        </main>
    </PublicLayout>
</template>

<script setup>
import PublicLayout from '@/Layouts/PublicLayout.vue';
import { ref, watch } from 'vue';
import { Link, useForm, usePage } from '@inertiajs/vue3';

const form = useForm({
    email: '',
    password: '',
});

const passwordVisible = ref(false);
const page = usePage();

// Flash messages from Laravel session
const flash = ref(page.props.flash || {});

// Watch for changes in page props (inertia navigation)
watch(() => page.props.flash, (newFlash) => {
    flash.value = newFlash || {};
});

// Toggle password visibility
function togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
}

// Login form submit
function login() {
    form.post('/login', {
        preserveScroll: true,
        onSuccess: (response) => {
            // Set success message from response flash or use default
            flash.value.success = props.flash?.success || 'Login successful.';
            flash.value.error = '';

            window.location.href = '/dashboard';
        },
        onError: (errors) => {
            flash.value.success = '';
            flash.value.error = props.flash?.error || 'Login failed. Please check your credentials.';
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

.auth-form .form-group {
    margin-bottom: 1.25rem;
}

.auth-form label {
    display: block;
    font-weight: 600;
    margin-bottom: 0.5rem;
    color: var(--color-dark);
}

.auth-form input {
    width: 100%;
    padding: 0.75rem;
    border: 1px solid var(--color-gray-300);
    border-radius: 0.5rem;
    font-size: 1rem;
}

.password-input {
    position: relative;
}

.toggle-password {
    position: absolute;
    right: 10px;
    top: 50%;
    transform: translateY(-50%);
    background: none;
    border: none;
    cursor: pointer;
    font-size: 1rem;
}

.auth-button {
    width: 100%;
    padding: 0.75rem;
    background-color: var(--color-primary);
    color: white;
    border: none;
    border-radius: 0.5rem;
    font-size: 1rem;
    cursor: pointer;
}

.auth-button:disabled {
    background-color: var(--color-gray-400);
}

.error-message {
    color: red;
    margin-bottom: 1rem;
    font-size: 0.875rem;
}

.flash-messages {
    margin-bottom: 1rem;
}

.flash-success,
.flash-error {
    padding: 0.75rem 1rem;
    border-radius: 6px;
    font-weight: 500;
    margin-bottom: 0.5rem;
    color: #fff;
}

.flash-success {
    background-color: #38a169;
    /* Green */
}

.flash-error {
    background-color: #e53e3e;
    /* Red */
}

.form-errors {
    margin-top: 1rem;
    padding: 0.75rem 1rem;
    border-left: 4px solid #e53e3e;
    background-color: #fff5f5;
    border-radius: 6px;
}

.form-error {
    color: #e53e3e;
    margin-bottom: 0.25rem;
    font-size: 0.95rem;
}
</style>