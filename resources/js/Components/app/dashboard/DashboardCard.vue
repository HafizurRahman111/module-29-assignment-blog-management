<template>
    <div class="col-md-6 col-lg-3">
        <div :class="['card border-0 shadow-lg text-white', 'bg-' + color]" @mouseover="onHover" @mouseleave="onLeave">
            <div class="card-body d-flex align-items-center">
                <i :class="['bi', 'bi-' + icon, 'fs-2', 'me-3']"></i>
                <div>
                    <div class="fs-4 fw-semibold">{{ count }}</div>
                    <div class="small">{{ title }}</div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
defineProps({
    icon: String,
    title: String,
    count: Number,
    color: String
});

const onHover = (event) => {
    const card = event.target.closest('.card');
    card.style.transform = 'translateY(-5px)';
    card.style.boxShadow = '0 15px 25px rgba(0, 0, 0, 0.1)';
};

const onLeave = (event) => {
    const card = event.target.closest('.card');
    card.style.transform = 'translateY(0)';
    card.style.boxShadow = '0 8px 15px rgba(0, 0, 0, 0.1)';
};
</script>

<style scoped>
.card {
    border-radius: 1rem;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    cursor: pointer;
}


.card-body {
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.card:hover {
    transform: translateY(-5px);
    box-shadow: 0 15px 25px rgba(0, 0, 0, 0.1);
}

.card-body i {
    transition: transform 0.3s ease;
}

/* Hover effects for the icon */
.card-body:hover i {
    transform: scale(1.1);
}

/* Responsiveness */
@media (max-width: 768px) {
    .card-body {
        padding: 1.25rem;
    }
}
</style>
