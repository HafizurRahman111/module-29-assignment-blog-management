<!-- components/LinkComponent.vue -->
<template>
    <Link :href="href" class="link-text">
      {{ linkText }}
    </Link>
  </template>
  
  <script setup>
  import { Link } from '@inertiajs/vue3';
  
  defineProps({
    href: String,
    linkText: String
  });
  </script>
  
  <style scoped>
  .link-text {
    color: #007bff;
    text-decoration: none;
    cursor: pointer;
    transition: color 0.3s ease;
  }
  .link-text:hover {
    color: #0056b3;
    text-decoration: underline;
  }
  </style>
  