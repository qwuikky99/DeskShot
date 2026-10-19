# DeskShot
DeskShot is a top-down shooter indie Godot game where you, Player, defend yourself from different enemies.

## Enemy stat breakdown
Health - the amount of damage an enemy must take before it dies. Can be increased if an enemy accidentally picks up a Heal.

Speed - the speed at which an enemy follows the Player.

Damage - the amount of damage an enemy deals when the Player touches them.

Ability - anything derivative from a Normal.

Special ability - anything derivative from a Normal that *isn't* a plain stat change.
## Enemies
Each enemy is a differently-coloured blob with different properties and/or abilities.


### Normal

|Property         |Value |
|-----------------|------|
| Speed           | 10   |
| Damage          | 3    |
| Health          | 3    |
| Score for kill  | 50   |
| Ability         | None |
| Special ability | None |

A Normal is just an ordinary (though pretty evil) black blob. They have no special abilities, and just plainly follow the player at base speed of 10.

When touched, deals 3 damage.

Has 3 health.

### Slow
|Property         |Value                                      |
|-----------------|-------------------------------------------|
| Speed           | 6                                         |
| Damage          | 5                                         |
| Health          | 5                                         |
| Score for kill  | 75                                        |
| Ability         | Increased Health, Damage; Decreased Speed |
| Special ability | None                                      |

A Slow is a big, red blob. They're just like a normal but about 1.7 times slower. They have no special abilities, and just plainly follow the player - though, are tankier and stronger than a Normal, which makes them harder to kill.

When touched, deals 5 damage.

Has 5 health.

### Speedy
|Property         |Value                                      |
|-----------------|-------------------------------------------|
| Speed           | 15                                        |
| Damage          | 1                                         |
| Health          | 1                                         |
| Score for kill  | 75                                        |
| Ability         | Increased Speed; Decreased Health, Damage |
| Special ability | None                                      |

A Speedy is a small, blue blob. They're the opposite of Slows - being 1.5 times faster than a Normal. They have no special abilities, and just plainly follow the player - though, are way faster than a Normal.

When touched, deals 1 damage.

Has 1 health.

### Sneaky
|Property         |Value                                        |
|-----------------|---------------------------------------------|
| Speed           | 10                                          |
| Damage          | 3                                           |
| Health          | 5                                           |
| Score for kill  | 100                                         |
| Ability         | Increased Health                            |
| Special ability | When far from the Player, becomes invisible |

A Sneaky is an ordinary-sized, green blob. They're just like a Normal, aside from slightly increased health (3 -> 5), but have a special ability: When they're far from the Player, they become completely invisible. They can still be hit while invisible if you keep track of their approximate position, though.

When touched, deals 3 damage.

Has 5 health.

## Socials
[Twitter](https://x.com/qwuikky99)
[Discord server](https://discord.gg/23wHhVg5QW)
