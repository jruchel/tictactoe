<template>
  <v-app data-app style="background-color: #9FA8DA">
    <v-container>
      <v-row class="justify-center" style="text-align: center">
        <v-col cols="6" class="justify-center">
          <v-btn :dark="players" :color=playersButtonColor @click="pushRoute('players')" style="float: right" rounded
                 depressed
                 v-ripple="false">Two players
          </v-btn>
        </v-col>
        <v-col cols="6">
          <v-btn @click="pushRoute('computer')" :dark="!players" :color="computerButtonColor" style="float: left"
                 rounded
                 depressed v-ripple="false">Computer
          </v-btn>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols="12">
          <v-main class="justify-center">
            <h1 style="text-align: center; margin-top: 0.6%">Tic Tac Toe</h1>
            <router-view></router-view>
          </v-main>
        </v-col>
      </v-row>
    </v-container>

  </v-app>
</template>

<script>

export default {
  name: 'App',
  computed: {
    playersButtonColor() {
      if (this.players === true) {
        return 'black'
      }
      return 'white'
    },
    computerButtonColor() {
      if (this.players === false) {
        return 'black'
      }
      return 'white'
    }
  },
  data() {
    return {
      players: true
    }
  },
  methods: {
    pushRoute(route) {
      this.players = route === 'players';
      this.$router.push(route)
    }
  }
};

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

* {
  font-family: Nunito-Black;
}

</style>

