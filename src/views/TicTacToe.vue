<template>
  <div>
    <v-container>
      <v-row dense v-for="i in size" :key="i" class="justify-center">
        <v-col v-for="n in size" :key="n" cols="4" sm="3" md="2" lg="1">
          <Tile :id="((i - 1) * size) + n - 1" v-on:tile-clicked="handleTileClick"></Tile>
        </v-col>
      </v-row>
    </v-container>
    <v-container>
      <v-row class="justify-center">
        <v-btn color="cyan lighten-2" class="white--text" @click="reset">Reset</v-btn>
      </v-row>
    </v-container>
    <v-container style="margin-top: 10px">
      <v-row class="justify-center flex-nowrap">
        <v-col cols="12" xs="8" sm="8" md="7" lg="4">
          <v-card min-width="100%">
            <v-card-title class="justify-center">Score:</v-card-title>
            <v-card-title class="justify-center">{{ firstScore }} : {{ secondScore }}</v-card-title>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
    <v-container>
      <v-row class="justify-center">
        <v-btn color="red lighten-2" class="white--text" @click="resetScore">Reset score</v-btn>
      </v-row>
    </v-container>
    <v-container>
      <v-row>
        <v-snackbar
            v-model="snackbar.show"
            color="blue-grey"
            bottom
        >
          {{ snackbar.text }}
        </v-snackbar>
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
      currentPlayer: this.players.first,
      firstScore: 0,
      secondScore: 0,
      over: false,
      snackbar: {show: false, text: 'Game over!'}
    }
  },
  provide() {
    return {
      players: Object.freeze({'none': 0, 'first': 1, 'second': 2})
    }
  },
  methods: {
    handleTileClick(args) {
      if (this.over) return
      let tilePlayer = args[0]
      if (tilePlayer !== this.players.none) {
        args[1](tilePlayer)
      } else {
        args[1](this.currentPlayer)
        this.currentPlayer = this.getOpponent(this.currentPlayer)
      }
      let gameResult = this.isOver()
      if (gameResult !== null) {
        this.over = true
        this.snackbar.show = true
        if (gameResult.winner === 0) {
          this.snackbar.text = "Draw!"
        } else {
          if (gameResult.winner === 1) {
            this.snackbar.text = "Player one wins!"
            this.firstScore++
          } else {
            this.snackbar.text = "Player two wins!"
            this.secondScore++
          }
        }
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
      this.snackbar.show = false
      this.over = false
    },
    resetScore() {
      this.firstScore = 0
      this.secondScore = 0
    },
    emptyTilesFilter(tile) {
      for (let i = 0; i < tile.length; i++) {
        if (tile[i] !== 0) {
          return false
        }
      }
      return true
    },
    isOver() {
      let board = this.getBoardAsArray()
      //Vertical tiles
      let verticalTiles = this.getVerticalTiles(board)
      for (let i = 0; i < verticalTiles.length; i++) {
        let checkResult = this.allTilesSamePlayer(verticalTiles[i])
        if (checkResult[0]) {
          return {winner: checkResult[1], tiles: verticalTiles[i]}
        }
      }
      //Horizontal tiles
      let horizontalTiles = this.getHorizontalTiles(board)
      for (let i = 0; i < horizontalTiles.length; i++) {
        let checkResult = this.allTilesSamePlayer(horizontalTiles[i])
        if (checkResult[0]) {
          return {winner: checkResult[1], tiles: verticalTiles[i]}
        }
      }
      //Diagonal tiles
      let diagonalTiles = this.getDiagonalTiles(board)
      for (let i = 0; i < diagonalTiles.length; i++) {
        let checkResult = this.allTilesSamePlayer(diagonalTiles[i])
        if (checkResult[0]) {
          return {winner: checkResult[1], tiles: verticalTiles[i]}
        }
      }
      if (!this.hasEmptyTiles(board)) {
        return {winner: 0, tiles: null}
      }
      return null
    },
    hasEmptyTiles(board) {
      for (let i = 0; i < board.length; i++) {
        for (let n = 0; n < board[0].length; n++) {
          if (board[i][n] === 0) {
            return true
          }
        }
      }
      return false
    },
    getDiagonalTiles(board) {
      let tiles = []
      tiles.push([board[0][0], board[1][1], board[2][2]]);
      tiles.push([board[2][0], board[1][1], board[0][2]]);
      return tiles
    },
    getVerticalTiles(board) {
      let tiles = []
      for (let i = 0; i < board.length; i++) {
        tiles.push([board[i][0], board[i][1], board[i][2]]);
      }
      return tiles
    },
    getHorizontalTiles(board) {
      let tiles = []
      for (let i = 0; i < board.length; i++) {
        tiles.push([board[0][i], board[1][i], board[2][i]]);
      }
      return tiles
    },
    allTilesSamePlayer(series) {
      let first = series[0]
      if (first === 0 || series[0] === 0) {
        return [false, 0]
      }
      for (let i = 1; i < series.length; i++) {
        if (series[i] !== first) return [false, first]
      }
      console.log(first)
      console.log(first === '0' || first === 0)
      return [true, first]
    },

    getBoardAsArray() {
      let oneDimensionBoard = this.$children.filter(this.filterTiles).map(this.mapChildrenByPlayer)
      const twoDimensionBoard = [];
      while (oneDimensionBoard.length) twoDimensionBoard.push(oneDimensionBoard.splice(0, 3));
      return twoDimensionBoard
    },
    filterTiles(child) {
      return child.$options.name === 'Tile'
    },
    mapChildrenByPlayer(child) {
      return child.player
    }
  },


}
</script>

<style scoped>

</style>