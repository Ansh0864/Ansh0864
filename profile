name: Generate Profile Assets (Trophies + Snake)

on:
  schedule:
    - cron: "0 0 * * *" # runs once a day
  workflow_dispatch: {}
  push:
    branches:
      - main

permissions:
  contents: write

jobs:
  generate:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Generate snake animation SVG
        uses: Platane/snk@v3
        with:
          github_user_name: Ansh0864
          outputs: |
            dist/github-contribution-grid-snake-dark.svg?palette=github-dark
            dist/github-contribution-grid-snake.svg

      - name: Generate trophy SVG
        uses: Erik-Donath/github-profile-trophy@feature/generate-svg
        with:
          username: Ansh0864
          output_path: dist/trophy.svg
          token: ${{ secrets.GITHUB_TOKEN }}
          theme: tokyonight
          no-frame: true
          row: 1
          column: 7

      - name: Push assets to "output" branch
        uses: crazy-max/ghaction-github-pages@v4
        with:
          target_branch: output
          build_dir: dist
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
