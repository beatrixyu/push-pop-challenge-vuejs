
<template>
    <div>
        {{ error.index }}
        <h1>{{ error.text }}</h1>
        <p>{{ error.code }}</p>
        <button @click="changeState(error,state)" class="errorBtn">send error</button>
    </div>
</template>

<script>
export default {
    props:{
        state:String,
        error:Object,
        changeState:Function
    }
}
</script>

<style scoped>
/* css here - only valid */
div {
    margin: 1rem 2ch;
    padding: 0.5rem 1ch;
    border-radius: 0.5rem;
    box-shadow: rgba(0, 0, 0, 0.192) 2px 2px 3px 0;
}

.errorBtn{
    background: purple;
    padding: 0 1%;
    box-shadow: 2px 2px white;
    border-radius: 4px;
}
</style>