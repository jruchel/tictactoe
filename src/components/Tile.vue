<template>
  <v-card :color="color" class="justify-center" height="100" @click="tileClicked">
    <v-card-title class="justify-center" style="height: 100%">{{ getPlayerRepresentation(player) }}</v-card-title>
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
      color: 'white'
    }
  },
  methods: {
    getPlayerRepresentation(player) {
      if (player === this.players.first) return "O";
      if (player === this.players.second) return "X";
      return "";
    },
    changePlayer(player) {
      this.player = player
    },
    clickTile() {
      this.tileClicked()
    },
    tileClicked() {
      this.$emit('tile-clicked', {player: this.player, tile: this, onChange: this.changePlayer})
    }
  }
}
</script>

<style scoped>


</style>