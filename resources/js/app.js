import './bootstrap';
import '../css/app.css';
import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap-icons/font/bootstrap-icons.css';
import NProgress from "nprogress";
import "nprogress/nprogress.css";
import "vue3-easy-data-table/dist/style.css";
import 'bootstrap/dist/js/bootstrap.bundle.min.js';

import { createApp, h } from 'vue';
import { createInertiaApp, router } from '@inertiajs/vue3';
import Vue3EasyDataTable from "vue3-easy-data-table";
import { resolvePageComponent } from 'laravel-vite-plugin/inertia-helpers';

createInertiaApp({
    resolve: name => resolvePageComponent(
        `./Pages/${name}.vue`,
        import.meta.glob('./Pages/**/*.vue')
    ),
    setup({ el, App, props, plugin }) {
        const app = createApp({ render: () => h(App, props) });

        app.use(plugin);
        app.component("EasyDataTable", Vue3EasyDataTable);

        app.mount(el);
    },
});

router.on("start", () => NProgress.start());
router.on("finish", () => NProgress.done());
