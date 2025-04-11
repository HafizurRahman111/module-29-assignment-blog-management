<template>
  <header class="bg-white border-bottom shadow-sm">
    <div class="container">
      <div class="d-flex justify-content-between align-items-center py-3">

        <!-- Left: Brand + Nav -->
        <div class="d-flex align-items-center gap-4">
          <Link href="/" class="navbar-brand fw-bold text-secondary fs-4">
          <i class="bi bi-pencil-fill me-1"></i> Blog
          </Link>

          <!-- Navigation (Desktop only) -->
          <nav class="d-none d-md-flex gap-3">
            <Link href="/" :class="['nav-link', 'px-2', 'text-dark', hoverLinkClass, { 'active-link': isActive('/') }]">
            Home
            </Link>
            <Link href="/blog"
              :class="['nav-link', 'px-2', 'text-dark', hoverLinkClass, { 'active-link': isActive('/blog') }]">
            Blog
            </Link>
            <Link href="/about"
              :class="['nav-link', 'px-2', 'text-dark', hoverLinkClass, { 'active-link': isActive('/about') }]">
            About
            </Link>
          </nav>
        </div>

        <!-- Right: Auth Links -->
        <div class="d-flex gap-3">
          <template v-if="$page.props.auth?.user">
            <Link href="/dashboard" class="nav-link text-dark hover-link">
            Dashboard
            </Link>
            <Link as="button" method="post" href="/logout" class="nav-link text-dark hover-link">
            Logout
            </Link>
          </template>
          <template v-else>
            <Link href="/login" class="btn btn-outline-primary btn-sm">
            Login
            </Link>
            <Link href="/register" class="btn btn-primary btn-sm">
            Register
            </Link>
          </template>
        </div>
      </div>
    </div>
  </header>
</template>

<script setup>
import { Link } from '@inertiajs/vue3';

// Function to check if the current route is active
const isActive = (route) => {
  return window.location.pathname === route;
};

const hoverLinkClass = 'hover-link'; // Class for the hover effect
</script>

<style scoped>
.hover-link {
  transition: all 0.3s ease;
}

.hover-link:hover {
  color: #4f46e5 !important;
  text-decoration: underline;
}

/* Increased specificity for active link */
.nav-link.active-link {
  font-weight: bold;
  color: #4f46e5 !important;
}
</style>
