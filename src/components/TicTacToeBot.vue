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
      return this.getGame().over
    },
    getGame() {
      return this.$children[0]
    },
    getTiles() {
      return this.getGame().getTiles()
    },
    isTileAvailable(tile) {
      return this.getGame().isTileAvailable(tile)
    },
    clickTile(tile) {
      this.getGame().clickTile(tile)
    },
    getAvailableTiles() {
      return this.getTiles().filter(tile => tile.player === 0)
    },
    randomNumber(min, max) {
      return Math.floor(Math.random() * (max - min) + min);
    },
    getRandomListElement(list) {
      return list[this.randomNumber(0, list.length)].id
    },
    selectRandomTile() {
      return this.getRandomListElement(this.getAvailableTiles())
    },
    getBoardSquares() {
      let tiles = this.getTiles()
      let topLeft = []
      topLeft.push(tiles[0], tiles[1], tiles[3], tiles[4])
      let topRight = []
      topRight.push(tiles[1], tiles[2], tiles[4], tiles[5])
      let bottomLeft = []
      bottomLeft.push(tiles[3], tiles[4], tiles[6], tiles[7])
      let bottomRight = []
      bottomRight.push(tiles[4], tiles[5], tiles[7], tiles[8])

      return [topLeft, topRight, bottomLeft, bottomRight]
    },
    hasThreeInSquare(square) {
      return (square.filter(tile => tile.player === 1).length === 3) && (square.filter(tile => tile.player === 0).length > 0)
    },
    blockSquareLayout(square) {
      return square.filter(tile => tile.player === 0)[0]
    },
    selectOppositeTile(tile) {
      return 8 - tile
    },
    selectTile(tile) {
      //If center is available place there
      if (this.isTileAvailable(4) === true) return 4
      //If player is attempting to fill a square place inside the square
      let squares = this.getBoardSquares()
      for (let i = 0; i < squares.length; i++) {
        let square = squares[i]
        if (this.hasThreeInSquare(square)) {
          return this.blockSquareLayout(square).id
        }
      }
      //If center tile was selected place anywhere
      if (tile === 4) return this.selectRandomTile()
      //If any other tile was selected place opposite
      if (this.isTileAvailable(this.selectOppositeTile(tile))) return this.selectOppositeTile(tile)
      //If none of the upper conditions are met, place anywhere
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