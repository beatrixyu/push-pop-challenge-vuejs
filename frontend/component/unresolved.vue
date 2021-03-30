
<template>
    <issue class="issue" :error="error" :changeState="changeState" state="unresolved"/>
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
.issue {
    color: white;
    background: red;
}
</style>