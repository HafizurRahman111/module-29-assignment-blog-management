<template>
    <div class="layout-wrapper">
        <Header />
        <div class="container content-container">
            <main class="main-content">
                <slot />
            </main>
        </div>
        <Footer />
    </div>
</template>

<script setup>
import Header from '../Components/app/layout/AppHeader.vue';
import Footer from '../Components/app/layout/AppFooter.vue';
</script>

<style scoped>
.layout-wrapper {
    display: flex;
    flex-direction: column;
    height: 100vh;
}

.content-container {
    flex-grow: 1;
    padding: 0 15px;
    /* Space on left and right */
    display: flex;
    justify-content: center;
}

.main-content {
    width: 100%;
    max-width: 1200px;
    /* Max container width */
    animation: fadeIn 0.5s ease-in-out;
    padding: 20px;
}

@keyframes fadeIn {
    from {
        opacity: 0;
    }

    to {
        opacity: 1;
    }
}
</style>
