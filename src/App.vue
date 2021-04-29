<template>
  <v-app data-app style="background-color: #9FA8DA">
    <v-main>
      <h1 style="text-align: center; margin-top: 0.6%">Tic Tac Toe</h1>
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
<style lang="scss">
@mixin setFont($font-name) {
  font-family: $font-name;
  src: local($font-name),
  url(./assets/fonts/#{$font-name}.ttf) format("truetype");
}

@font-face {
  @include setFont("Nunito-Black")
}

*{
  font-family: Nunito-Black;
}

</style>

