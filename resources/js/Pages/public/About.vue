<template>
    <AppLayout>
        <main class="about-page">
            <!-- Introduction Section -->
            <section class="intro-section">
                <div class="container">
                    <div class="intro-content">
                        <h1 class="section-title">
                            About Our Blog Management System
                        </h1>
                        <p class="section-description">
                            Discover how our Blog Management System helps businesses streamline content creation,
                            publishing, and management.
                            Learn how we empower users to easily manage blog posts, authors, comments, and more with an
                            intuitive interface.
                        </p>
                    </div>
                </div>
            </section>

            <!-- Features Section -->
            <section class="features-section">
                <div class="container">
                    <h2 class="section-title">Why Choose Our Blog System?</h2>
                    <p class="section-subtitle">Simplified, efficient, and perfect for modern content management.</p>

                    <div class="features-grid">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="bi bi-pencil-square"></i>
                            </div>
                            <h3>Easy Content Creation</h3>
                            <p>Write, format, and publish articles with an intuitive, user-friendly editor.</p>
                        </div>

                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="bi bi-shield-lock"></i>
                            </div>
                            <h3>Advanced Security</h3>
                            <p>Ensure your blog content and user data are safe with top-tier security protocols.</p>
                        </div>

                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="bi bi-people"></i>
                            </div>
                            <h3>Collaborative Editing</h3>
                            <p>Invite team members, assign roles, and collaborate efficiently on blog posts.</p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Team Section -->
            <section class="team-section">
                <div class="container">
                    <h2 class="section-title">Meet Our Team</h2>
                    <div class="team-grid">
                        <div class="team-member">
                            <img src="/images/team-member-1.jpg" alt="John Doe" class="team-member-avatar">
                            <h3 class="team-member-name">John Doe</h3>
                            <p class="team-member-title">Founder & CEO</p>
                            <p class="team-member-bio">John is passionate about improving content management and has
                                been working in this field for over a decade, focusing on delivering robust blogging
                                solutions for businesses.</p>
                        </div>

                        <div class="team-member">
                            <img src="/images/team-member-2.jpg" alt="Jane Smith" class="team-member-avatar">
                            <h3 class="team-member-name">Jane Smith</h3>
                            <p class="team-member-title">Lead Developer</p>
                            <p class="team-member-bio">Jane oversees the technical aspects of our platform, ensuring
                                that it's scalable, secure, and continually evolving to meet the needs of users.</p>
                        </div>

                        <div class="team-member">
                            <img src="/images/team-member-3.jpg" alt="Mike Johnson" class="team-member-avatar">
                            <h3 class="team-member-name">Mike Johnson</h3>
                            <p class="team-member-title">Customer Support Manager</p>
                            <p class="team-member-bio">Mike and his team provide around-the-clock support, helping users
                                resolve any issues they face with the system, ensuring seamless content management
                                experiences.</p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Contact Form Section -->
            <section class="contact-form-section">
                <div class="container">
                    <h2 class="section-title">Get in Touch</h2>
                    <p class="section-subtitle">Have any questions about our blog management system? We're here to help!
                    </p>

                    <form action="#" method="POST" class="contact-form">
                        <div class="form-group">
                            <label for="name">Your Name</label>
                            <input type="text" id="name" name="name" placeholder="Enter your name" required>
                        </div>

                        <div class="form-group">
                            <label for="email">Your Email</label>
                            <input type="email" id="email" name="email" placeholder="Enter your email" required>
                        </div>

                        <div class="form-group">
                            <label for="message">Your Message</label>
                            <textarea id="message" name="message" placeholder="Write your message here"
                                required></textarea>
                        </div>

                        <button type="submit" class="cta-button primary">Send Message</button>
                    </form>
                </div>
            </section>
        </main>
    </AppLayout>
</template>

<script setup>
import AppLayout from '@/Layouts/AppLayout.vue';
</script>

<style scoped>
/* Base Styles */
.about-page {
    overflow-x: hidden;
}

/* Container */
.container {
    width: 100%;
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 1.5rem;
}

/* Section Titles */
.section-title {
    font-size: 2.25rem;
    font-weight: 700;
    color: var(--color-dark);
    text-align: center;
    margin-bottom: 1rem;
}

.section-description,
.section-subtitle {
    text-align: center;
    font-size: 1.125rem;
    color: var(--color-gray-600);
    margin-bottom: 2rem;
}

/* Intro Section */
.intro-section {
    padding: 3rem 0;
    background-color: var(--color-light);
}

.intro-content h1 {
    font-size: 3rem;
    font-weight: 800;
    color: var(--color-dark);
}

.intro-content p {
    font-size: 1.25rem;
    color: var(--color-gray-600);
    max-width: 800px;
    margin: 0 auto;
}

/* Features Section */
.features-section {
    padding: 3rem 0;
    background-color: white;
}

.features-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 2rem;
}

.feature-card {
    padding: 2rem;
    border-radius: 1rem;
    background-color: var(--color-light);
    text-align: center;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.feature-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
}

.feature-icon {
    width: 60px;
    height: 60px;
    margin: 0 auto 1.5rem;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(135deg, var(--color-primary), var(--color-accent));
    border-radius: 50%;
    color: white;
    font-size: 1.5rem;
}

/* Team Section */
.team-section {
    padding: 3rem 0;
    background-color: var(--color-light);
}

.team-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 2rem;
    margin-top: 3rem;
}

.team-member {
    text-align: center;
    padding: 1.5rem;
    background-color: white;
    border-radius: 1rem;
    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
}

.team-member-avatar {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    object-fit: cover;
    margin-bottom: 1rem;
}

.team-member-name {
    font-size: 1.25rem;
    font-weight: 600;
}

.team-member-title {
    color: var(--color-gray-600);
}

.team-member-bio {
    color: var(--color-gray-500);
    font-size: 1rem;
}

/* Contact Form Section */
.contact-form-section {
    padding: 3rem 0;
    background-color: var(--color-light);
}

.contact-form {
    display: flex;
    flex-direction: column;
    gap: 1rem;
    max-width: 600px;
    margin: 0 auto;
}

.contact-form .form-group {
    display: flex;
    flex-direction: column;
}

.contact-form label {
    font-weight: 600;
    color: var(--color-dark);
    margin-bottom: 0.5rem;
}

.contact-form input,
.contact-form textarea {
    padding: 0.75rem;
    border-radius: 0.5rem;
    border: 1px solid var(--color-gray-300);
    font-size: 1rem;
}

.contact-form textarea {
    resize: vertical;
    height: 150px;
}

.contact-form button {
    padding: 0.875rem 1.75rem;
    background-color: var(--color-primary);
    color: white;
    font-weight: 600;
    border-radius: 0.5rem;
    transition: background-color 0.2s ease;
}

.contact-form button:hover {
    background-color: var(--color-primary-dark);
}

/* Responsive Design */
@media (max-width: 768px) {

    .features-grid,
    .team-grid {
        grid-template-columns: 1fr;
    }

    .team-member-avatar {
        width: 80px;
        height: 80px;
    }
}
</style>
