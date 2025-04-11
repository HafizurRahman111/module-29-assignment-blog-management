<template>
    <AppLayout>
        <main class="home-page">
            <!-- Hero Section -->
            <section class="hero-section">
                <div class="container">
                    <div class="hero-content">
                        <h1 class="hero-title">
                            <span class="gradient-text">Blog Management</span> System
                        </h1>
                        <p class="hero-subtitle">
                            Manage, create, and publish your content with ease using our intuitive blog system
                        </p>
                    </div>
                </div>
            </section>

            <!-- Featured Posts Section -->
            <section class="featured-posts-section">
                <div class="container">
                    <h2 class="section-title">Featured Posts</h2>
                    <p class="section-subtitle">Curated content to inspire and inform</p>

                    <div class="posts-grid">
                        <div class="post-card" v-for="post in featuredPosts" :key="post.id">
                            <img :src="post.image" alt="Post Image" class="post-image" />
                            <div class="post-content">
                                <h3>{{ post.title }}</h3>
                                <p>{{ post.excerpt }}</p>
                                <Link :href="`/posts/${post.id}`" class="read-more">Read More</Link>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Categories Section -->
            <section class="categories-section">
                <div class="container">
                    <h2 class="section-title">Blog Categories</h2>
                    <p class="section-subtitle">Explore content by category</p>

                    <div class="categories-grid">
                        <div class="category-card" v-for="category in categories" :key="category.id">
                            <h3>{{ category.name }}</h3>
                            <Link :href="`/category/${category.slug}`">Explore</Link>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Testimonials Section -->
            <section class="testimonial-section">
                <div class="container">
                    <div class="testimonial-card">
                        <div class="testimonial-content">
                            <i class="bi bi-quote"></i>
                            <blockquote>
                                This blog management system has revolutionized the way we manage our content. It’s so
                                easy to use!
                            </blockquote>
                            <div class="testimonial-author">
                                <img src="/images/testimonial-avatar.jpg" alt="John Doe" class="author-avatar">
                                <div>
                                    <p class="author-name">John Doe</p>
                                    <p class="author-title">Editor, Blog Central</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>
    </AppLayout>
</template>

<script setup>
import AppLayout from '@/Layouts/AppLayout.vue';
import { Link } from '@inertiajs/vue3';

const featuredPosts = [
    { id: 1, title: "The Future of Blogging", excerpt: "Discover the trends shaping the future of blogging...", image: "/images/post1.jpg" },
    { id: 2, title: "How to Write Engaging Content", excerpt: "Learn the key elements that make your blog posts engaging...", image: "/images/post2.jpg" },
    { id: 3, title: "SEO Tips for Bloggers", excerpt: "Boost your blog’s visibility with these simple SEO tips...", image: "/images/post3.jpg" }
];

const categories = [
    { id: 1, name: "Technology", slug: "technology" },
    { id: 2, name: "Lifestyle", slug: "lifestyle" },
    { id: 3, name: "Business", slug: "business" },
];
</script>

<style scoped>
/* Base Styles */
.home-page {
    overflow-x: hidden;
}

.container {
    width: 100%;
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 1rem;
}

/* Color Variables */
:root {
    --color-primary: #4f46e5;
    --color-primary-dark: #4338ca;
    --color-accent: #7c3aed;
    --color-dark: #1e293b;
    --color-gray-600: #475569;
    --color-gray-700: #334155;
    --color-gray-300: #cbd5e1;
    --color-gray-50: #f8fafc;
    --color-light: #f1f5f9;
}

/* Hero Section */
.hero-section {
    padding: 2rem 0;
    background: linear-gradient(to bottom, #f8fafc, #ffffff);
}

.hero-content {
    text-align: center;
    max-width: 800px;
    margin: 0 auto 1rem;
}

.hero-title {
    font-size: 3rem;
    font-weight: 800;
    line-height: 1.2;
    margin-bottom: 1.5rem;
    color: var(--color-dark);
}

.gradient-text {
    background: linear-gradient(90deg, var(--color-primary), var(--color-accent));
    -webkit-background-clip: text;
    background-clip: text;
    color: transparent;
}

.hero-subtitle {
    font-size: 1.25rem;
    color: var(--color-gray-600);
    max-width: 600px;
    margin: 0 auto 2rem;
}

/* Featured Posts Section */
.featured-posts-section {
    padding: 2rem 0;
    background-color: white;
}

.posts-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 2rem;
    margin-top: 3rem;
}

.post-card {
    padding: 2rem;
    border-radius: 1rem;
    background-color: var(--color-light);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    text-align: center;
}

.post-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
}

.post-image {
    width: 100%;
    height: 200px;
    object-fit: cover;
    border-radius: 1rem;
    margin-bottom: 1.5rem;
}

.post-content h3 {
    font-size: 1.5rem;
    font-weight: 600;
    margin-bottom: 1rem;
}

.post-content p {
    color: var(--color-gray-600);
    line-height: 1.6;
}

.read-more {
    color: var(--color-primary);
    text-decoration: none;
    font-weight: 600;
}

/* Categories Section */
.categories-section {
    padding: 2rem 0;
    background-color: var(--color-light);
}

.categories-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 1.5rem;
    margin-top: 2rem;
}

.category-card {
    padding: 2rem;
    background-color: white;
    border-radius: 1rem;
    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
    text-align: center;
    transition: transform 0.3s ease;
}

.category-card:hover {
    transform: translateY(-5px);
}

.category-card h3 {
    font-size: 1.25rem;
    font-weight: 600;
    margin-bottom: 1rem;
}

.category-card a {
    color: var(--color-primary);
    text-decoration: none;
    font-weight: 600;
}

/* Testimonial Section */
.testimonial-section {
    padding: 5rem 0;
    background-color: var(--color-light);
}

.testimonial-card {
    max-width: 800px;
    margin: 0 auto;
    padding: 3rem;
    background-color: white;
    border-radius: 1rem;
    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
}

.testimonial-content {
    text-align: center;
}

.testimonial-content i {
    font-size: 2.5rem;
    color: var(--color-primary);
    opacity: 0.2;
    margin-bottom: 1.5rem;
}

.testimonial-content blockquote {
    font-size: 1.25rem;
    font-style: italic;
    color: var(--color-gray-700);
    line-height: 1.6;
    margin-bottom: 2rem;
}

.testimonial-author {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 1rem;
}

.author-avatar {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    object-fit: cover;
}

.author-name {
    font-weight: 600;
    color: var(--color-dark);
}

.author-title {
    color: var(--color-gray-600);
    font-size: 0.875rem;
}

/* Responsive Design */
@media (max-width: 768px) {
    .hero-title {
        font-size: 2.25rem;
    }

    .hero-subtitle {
        font-size: 1.125rem;
    }

    .posts-grid,
    .categories-grid {
        grid-template-columns: 1fr;
    }

    .testimonial-card {
        padding: 2rem 1.5rem;
    }
}

@media (max-width: 480px) {
    .hero-section {
        padding: 3rem 0;
    }

    .hero-title {
        font-size: 1.75rem;
    }

    .section-title {
        font-size: 1.75rem;
    }
}
</style>
