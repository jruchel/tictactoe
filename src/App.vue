<template>
  <v-app>
    <v-main>
      <h1 style="text-align: center">Tic Tac Toe</h1>
      <BoardView :size="3"></BoardView>
    </v-main>
  </v-app>
</template>

<script>
import BoardView from "@/views/BoardView";

export default {
  name: 'App',
  components: {BoardView},
};
</script>
