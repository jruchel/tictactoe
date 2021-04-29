<template>
  <div>
    <v-container>
      <v-row dense v-for="i in size" :key="i">
        <v-col v-for="n in size" :key="n">
          <Tile :id="((i - 1) * size) + n - 1" v-on:tile-clicked="handleTileClick"></Tile>
        </v-col>
      </v-row>
    </v-container>
    <v-container>
      <v-row class="justify-center">
        <v-btn color="cyan" @click="reset">Reset</v-btn>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import Tile from "@/components/Tile";

export default {
  name: "BoardView",
  components: {Tile},
  props: ['size'],
  beforeCreate() {
    this.players = Object.freeze({'none': 0, 'first': 1, 'second': 2})
  },
  data() {
    return {
      currentPlayer: this.players.first
    }
  },
  provide() {
    return {
      players: Object.freeze({'none': 0, 'first': 1, 'second': 2})
    }
  },
  methods: {
    handleTileClick(args) {
      let tilePlayer = args[0]
      if (tilePlayer !== this.players.none) {
        args[1](tilePlayer)
      } else {
        args[1](this.currentPlayer)
        this.currentPlayer = this.getOpponent(this.currentPlayer)
      }
    },
    getOpponent(player) {
      if (player === this.players.first) return this.players.second
      return this.players.first
    },
    reset() {
      for (let i = 0; i < this.$children.length; i++) {
        let child = this.$children[i]
        child.player = 0
      }
    }
  },


}
</script>

<style scoped>

</style>