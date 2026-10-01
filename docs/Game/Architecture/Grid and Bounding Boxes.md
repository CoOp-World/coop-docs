---
layout: default
title: Grid and Bounding Boxes
nav_order: 3
parent: Architecture
grand_parent: Game
---

# Grid and Bounding Boxes

Design decisions from September–October 2024 (migrated from Notion; the screenshots that accompanied the original page are not included).

## Grid

Static objects are placed on a grid with a **constant number of rows and columns**. The height and width of each cell adjust to the screen resolution, so the game is the same at any resolution. The previous developers' client and the original game's code also used a fixed number of rows and columns.

## Separate physics shape and collection shape

If the player's physics body is a rectangle, the player can appear to stand on the tip of a foot, or float where the sprite does not fill the rectangle. The decision:

- the **physics body is a circle**, so when half of the player is off a surface the player falls;
- the **collection shape (coin pickup) stays a rectangle**, so collecting works as before.

This also allows the collection shape to be a hand or another body part, and the concept is the same for different player sprites. Known downside: the player can overlap obstacles slightly. The idea follows the original developer's approach (a circle, as in her libGDX project); Phaser could not create an exact shape matching the sprite.
