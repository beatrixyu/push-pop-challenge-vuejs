
<template>
    <issue class="backlog" :error="error" :changeState="changeState" state="backlog"/>
</template>

<script>
import issue from './issue.vue'
export default {
    components: { issue },
    props:{
        error:Object,
        changeState:Function
    }
}
</script>

<style scoped>
.backlog {
    color: white;
    background: orange;
}
</style>