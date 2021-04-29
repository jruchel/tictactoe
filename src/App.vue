<template>
  <v-app data-app>
    <v-main>
      <h1 style="text-align: center">Tic Tac Toe</h1>
      <TicTacToe :size="3"></TicTacToe>
    </v-main>
  </v-app>
</template>

<script>
import TicTacToe from "@/views/TicTacToe";

export default {
  name: 'App',
  components: {TicTacToe},
};

//TODO highlight tiles after game over
</script>

