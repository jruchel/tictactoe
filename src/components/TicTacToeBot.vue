<template>
  <TicTacToe v-on:tile-click="handleClick"></TicTacToe>
</template>

<script>
import TicTacToe from "@/components/TicTacToe";

export default {
  name: "TicTacToeBot",
  components: {TicTacToe},
  methods: {
    handleClick(args) {
      if (args.player === 1) {
        this.respondToPlayerMove(args.tile)
      }
    },
    isOver() {
      return this.$children[0].over
    },
    isTileAvailable(tile) {
      return this.$children[0].isTileAvailable(tile)
    },
    clickTile(tile) {
      this.$children[0].clickTile(tile)
    },
    randomNumber(min, max) {
      return Math.floor(Math.random() * (max - min) + min);
    },
    selectRandomTile() {
      let result = this.randomNumber(0, 9)
      if (this.isTileAvailable(result) === false) return this.selectRandomTile()
      return result
    },
    selectOppositeTile(tile) {
      return 8 - tile
    },
    selectTile(tile) {
      if (this.isTileAvailable(4) === true) return 4
      if (tile === 4) return this.selectRandomTile()
      if (this.isTileAvailable(this.selectOppositeTile(tile))) return this.selectOppositeTile(tile)
      return this.selectRandomTile()
    },
    respondToPlayerMove(tile) {
      if (this.isOver() === false) this.clickTile(this.selectTile(tile))
    },
  }

}
</script>

<style scoped>

</style>