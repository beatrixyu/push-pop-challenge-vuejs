
<template>
    <issue class="resolved" :error="error" :changeState="changeState" state="resolved"/>
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
.resolved {
    color: white;
    background: green;
}
</style>