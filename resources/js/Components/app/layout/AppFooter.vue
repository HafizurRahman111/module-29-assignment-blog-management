<template>
  <footer class="footer text-white text-center py-4">
    <div class="container">
      <p class="mb-2 mb-md-0">&copy; {{ new Date().getFullYear() }} <strong>Blog</strong>. All rights reserved.</p>

      <div class="social-links mt-2 d-flex justify-content-center gap-3">
        <a href="#" class="social-icon" aria-label="Facebook">
          <i class="bi bi-facebook"></i>
        </a>
        <a href="#" class="social-icon" aria-label="Twitter">
          <i class="bi bi-twitter"></i>
        </a>
        <a href="#" class="social-icon" aria-label="Instagram">
          <i class="bi bi-instagram"></i>
        </a>
      </div>
    </div>
  </footer>
</template>

<script setup>
// No logic needed
</script>

<style scoped>
.footer {
  background: linear-gradient(to right, #1f2937, #111827);
  /* dark gradient */
  font-size: 0.95rem;
}

.social-icon {
  color: #cbd5e1;
  font-size: 1.4rem;
  transition: transform 0.3s ease, color 0.3s ease;
}

.social-icon:hover {
  color: #6366f1;
  /* Soft indigo */
  transform: scale(1.2);
}
</style>
