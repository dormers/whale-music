import { createMemoryHistory, createRouter } from 'vue-router';

import MainRecommendation from '../components/main/MainRecommendation.vue';
import MainSearch from '../components/main/MainSearch.vue';

const routes = [
    { path: '/whale/streaming/recommend', component: MainRecommendation },
    { path: '/whale/streaming/search/:query', component: MainSearch },
];

const router = createRouter({
    history: createMemoryHistory(),
    routes,
});

export default router;