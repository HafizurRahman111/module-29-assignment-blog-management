<template>
    <PublicLayout>
        <div class="auth-container">
            <h1 class="auth-title">Create Your Account</h1>

            <!-- Display general form errors -->
            <div v-if="form.hasErrors" class="form-error-message">
                Please correct the errors below
            </div>

            <form @submit.prevent="submit" class="auth-form two-column">
                <!-- Full Name -->
                <div class="form-group span-full">
                    <label for="name">Full Name</label>
                    <input v-model="form.name" type="text" id="name" required autofocus
                        :class="{ 'input-error': form.errors.name }" />
                    <div v-if="form.errors.name" class="error-message">
                        {{ form.errors.name[0] }} <!-- Display the first error message -->
                    </div>
                </div>

                <!-- Email -->
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input v-model="form.email" type="email" id="email" required
                        :class="{ 'input-error': form.errors.email }" />
                    <div v-if="form.errors.email" class="error-message">
                        {{ form.errors.email[0] }} <!-- Display the first error message -->
                    </div>
                </div>

                <!-- Mobile -->
                <div class="form-group">
                    <label for="mobile">Mobile Number</label>
                    <input v-model="form.mobile" type="text" id="mobile" required placeholder="+1234567890" />
                    <small class="form-text text-muted">
                        Example: +1234567890 (Include country code, 6 to 20 digits)
                    </small>
                    <div v-if="form.errors.mobile" class="error-message">
                        {{ form.errors.mobile[0] }}
                    </div>
                </div>

                <!-- Password -->
                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-wrapper">
                        <input v-model="form.password" :type="showPassword ? 'text' : 'password'" id="password" required
                            minlength="8" :class="{ 'input-error': form.errors.password }" />
                        <span class="toggle-visibility" @click="togglePassword">
                            {{ showPassword ? '🙈' : '👁️' }}
                        </span>
                    </div>
                    <div v-if="form.errors.password" class="error-message">
                        {{ form.errors.password[0] }} <!-- Display the first error message -->
                    </div>
                </div>

                <!-- Confirm Password -->
                <div class="form-group">
                    <label for="password_confirmation">Confirm Password</label>
                    <div class="input-wrapper">
                        <input v-model="form.password_confirmation" :type="showConfirmPassword ? 'text' : 'password'"
                            id="password_confirmation" required />
                        <span class="toggle-visibility" @click="toggleConfirmPassword">
                            {{ showConfirmPassword ? '🙈' : '👁️' }}
                        </span>
                    </div>
                    <div v-if="form.errors.password_confirmation" class="error-message">
                        {{ form.errors.password_confirmation[0] }} <!-- Display the first error message -->
                    </div>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="auth-button span-full" :disabled="form.processing">
                    <span v-if="form.processing">Creating Account...</span>
                    <span v-else>Create Account</span>
                </button>

                <!-- Login Link -->
                <p class="auth-switch span-full">
                    Already have an account?
                    <Link href="/login" class="auth-link">Sign In</Link>
                </p>
            </form>
        </div>
    </PublicLayout>
</template>

<script setup>
import { ref } from 'vue';
import { Link, useForm, usePage, router } from "@inertiajs/vue3";
import { createToaster } from "@meforma/vue-toaster";
import PublicLayout from '@/Layouts/PublicLayout.vue';

const toaster = createToaster();

// Define the form data
const form = useForm({
    name: "",
    email: "",
    mobile: "",
    password: "",
    password_confirmation: "",
});

// Extract page properties (like flash messages)
const page = usePage();
const showPassword = ref(false);
const showConfirmPassword = ref(false);

// Toggle password visibility
const togglePassword = () => {
    showPassword.value = !showPassword.value;
};

// Toggle confirm password visibility
const toggleConfirmPassword = () => {
    showConfirmPassword.value = !showConfirmPassword.value;
};

const submit = () => {
    form.processing = true;  // Disable the button while submitting

    form.post("/register", {
        onSuccess: (response) => {
            toaster.success(response.message);

            if (response.success) {
                // Redirect to the email verification page
                router.get('/email/verify');
            }
        },
        onError: (errors) => {
            form.errors = errors.errors;  // Assign the errors from the server to form.errors

            // Display a general error message in the toaster
            toaster.error('Please correct the errors below');

            form.processing = false;  // Re-enable the button after an error
        }
    });
};
</script>

<style scoped>
.auth-container {
    max-width: 600px;
    width: 100%;
    margin: 0 auto;
    padding: 2rem;
    background: white;
    border-radius: 0.5rem;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.auth-title {
    font-size: 1.75rem;
    font-weight: 700;
    text-align: center;
    margin-bottom: 2rem;
    color: var(--color-gray-800);
}

.auth-form {
    display: grid;
    gap: 1rem;
}

.two-column {
    grid-template-columns: 1fr 1fr;
}

.span-full {
    grid-column: span 2;
}

.form-group {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.auth-form label {
    font-weight: 600;
    color: var(--color-gray-700);
}

.auth-form input {
    width: 100%;
    padding: 0.5rem;
    border: 1px solid var(--color-gray-300);
    border-radius: 0.375rem;
    font-size: 1rem;
}

.input-error {
    border-color: var(--color-danger) !important;
}

.error-message {
    color: var(--color-danger);
    font-size: 0.875rem;
}

.input-wrapper {
    position: relative;
    display: flex;
    align-items: center;
}

.input-wrapper input {
    flex: 1;
}

.toggle-visibility {
    position: absolute;
    right: 10px;
    cursor: pointer;
    font-size: 1rem;
    user-select: none;
    color: #555;
}

.auth-button {
    padding: 0.75rem;
    background-color: var(--color-primary);
    color: white;
    border: none;
    border-radius: 0.375rem;
    font-weight: 600;
    cursor: pointer;
    transition: background-color 0.2s;
}

.auth-button:hover {
    background-color: var(--color-primary-dark);
}

.auth-button:disabled {
    opacity: 0.7;
    cursor: not-allowed;
}

.auth-switch {
    text-align: center;
    color: var(--color-gray-600);
}

.auth-link {
    color: var(--color-primary);
    font-weight: 600;
    text-decoration: none;
}

.auth-link:hover {
    text-decoration: underline;
}

@media (max-width: 640px) {
    .two-column {
        grid-template-columns: 1fr;
    }

    .span-full {
        grid-column: span 1;
    }
}
</style>