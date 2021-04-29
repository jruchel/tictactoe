<template>
  <v-card class="justify-center" height="100" @click="tileClicked">
    <v-card-title class="justify-center">{{ getPlayerRepresentation(player) }}</v-card-title>
  </v-card>
</template>

<script>

export default {
  name: "Tile",
  inject: ['players'],
  props: ['id'],
  data() {
    return {
      player: this.players.none,
    }
  },
  methods: {
    getPlayerRepresentation(player) {
      if (player === this.players.first) return "O";
      if (player === this.players.second) return "X";
      return "";
    },
    changePlayer(player) {
      console.log("before " + this.player)
      this.player = player
      console.log("after " + this.player)
    },
    tileClicked() {
      this.$emit('tile-clicked', [this.player, this.changePlayer])
    }
  }
}
</script>

<style scoped>


</style>