<template>
    <div v-if="flash.success || flash.error" class="flash-messages">
        <div v-if="flash.success" class="flash-success">
            {{ flash.success }}
        </div>
        <div v-if="flash.error" class="flash-error">
            {{ flash.error }}
        </div>
    </div>
</template>

<script setup>
defineProps({
    flash: Object,
});
</script>

<style scoped>
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
}

.flash-error {
    background-color: #e53e3e;
}
</style>