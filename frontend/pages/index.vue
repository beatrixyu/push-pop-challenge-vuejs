<template>
  <div>
    <button @click="select='all'">all</button>
    <button @click="select='resolved'">resolved</button>
    <button @click="select='unresolved'">unresolved</button>
    <button @click="select='backlog'">backlog</button>
    <button @click="undoAction">undo</button>
    <!--input v-model="search" @input="filterIssues"/-->
    <Resolved   v-if="select === 'all' || select === 'resolved'"   v-for="error in resolved"   :key="error.index" :error="error" :changeState="changeState"/>
    <Unresolved v-if="select === 'all' || select === 'unresolved'" v-for="error in unresolved" :key="error.index" :error="error" :changeState="changeState"/>
    <Backlog    v-if="select === 'all' || select === 'backlog'"    v-for="error in backlog"    :key="error.index" :error="error" :changeState="changeState"/>
  </div>
</template>

<script>
import Backlog from '../component/backlog.vue';
import Resolved from '../component/resolved.vue';
import Unresolved from "../component/unresolved.vue";

export default {
  components: { Unresolved, Resolved, Backlog },
  async asyncData({ $axios }) {
    try {
      const { resolved, unresolved, backlog } = await $axios.$get(
        "http://localhost:8000/get_lists"
      );
      return {
        resolved,
        unresolved,
        backlog,
        /*unfiltered: {
          resolved,
          unresolved,
          backlog
        },
        filtered: {
          resolved,
          unresolved,
          backlog
        }*/
      };
    } catch (error) {
      console.log(
        `Couldn't get error lists:\n${error}\nDid you start the API?`
      );
      console.log(
        "HINT: You can comment out the full `asyncData` method and work with mocked data for UI/UX development, if you want to."
      );
    }
  },
  data() {
    return {
      select:'all',
      resolved: [],
      unresolved: [],
      backlog: [],
      undo: []
      //search: '',
      /*filtered: {
        resolved: [],
        unresolved: [],
        backlog: []
      }*/
    };
  },
  methods: {
    /*filterIssues($event){
      const filter = $event.target.value;
      this.search = filter;
      this.filtered = {
        resolved   : this.unfiltered.resolved.filter( error => error.code == filter ),
        unresolved : this.unfiltered.unresolved.filter( error => error.code == filter ),
        backlog    : this.unfiltered.backlog.filter( error => error.code == filter )
      }
    },*/
    changeState(error,state){
      switch(state){
        case "unresolved":
          this.unresolved = this.unresolved.filter( e => e.index !== error.index );
          this.resolved   = [ ...this.resolved, error ];
          this.undo       = [ ...this.undo, [error.index,'unresolved','resolved'] ];          
          break;
        case "resolved":
          this.resolved   = this.resolved.filter( e => e.index !== error.index );
          this.unresolved = [ ...this.unresolved, error ];
          this.undo       = [ ...this.undo, [error.index,'resolved','unresolved'] ];          
          break;
        case "backlog":
          this.backlog    = this.backlog.filter( e => e.index !== error.index );
          this.unresolved = [ ...this.unresolved, error ];
          this.undo       = [ ...this.undo, [error.index,'backlog','unresolved'] ];          
          break;
      }
      /*
      const from = {
        unresolved: "resolved",
        resolved:   "unresolved",
        backlog:    "unresolved"
      };
      const to = from[state];
      this[from] = this[from].filter( e => e.index !== error.index );
      this[to]   = [ ...this[to], error ];
      this.undo  = [ ...this.undo, [index,from,to] ];
      */
    },
    undoAction(){
      const lastAction = this.undo.pop();
      if ( ! lastAction ) return;
      const [ index, from, to ] = lastAction;
      const error = this[to].find(   e => e.index === index ); // error = this.to[this[to].length - 1]; 
      this[to]    = this[to].filter( e => e.index !== index );
      this[from]  = [ error, ...this[from] ];
      this.undo   = [ ...this.undo ]; /* keep the state updated */
    }
  },
};
</script>
