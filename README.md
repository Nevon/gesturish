# Gesturish

[![Build Status](https://travis-ci.org/Nevon/gesturish.svg?branch=master)](https://travis-ci.org/Nevon/gesturish)

This is a demo application for the [Gesturish](http://www.gesturish.com/) input system. The system is designed around swiping to input text.

## How to run
```
npm install
gulp
```

## Tests

```
npm test
```

## Input system explanation

The system works by combining taps and swipes in order to write. For example:

```
↓↓←↑←←→↓←↓↓←→←↑∘←→← = hi there
```

After inputting the sequence for a letter (for example `↓` for `a`), you swipe left (←) to submit that letter and moving on to the next one. To delete the character you just wrote, swipe left two more times `←←`.

### Legend
| Symbol | Meaning     |
|--------|-------------|
| ←      | Swipe left  |
| →      | Swipe right |
| ↑      | Swipe up    |
| ↓      | Swipe down  |
| ∘      | Tap         |

### Alphabet

| Input | Effect                |
|-------|-----------------------|
| ←          | Submit current letter |
| ←←         | Space                 |
| ←←←        | Delete                |
| ↓          | a                     |
| ↑↑∘        | b                     |
| →∘→        | c                     |
| ∘↑         | d                     |
| →          | e                     |
| →→         | f                     |
| ∘↓         | g                     |
| ↓↓         | h                     |
| ↑          | i                     |
| ∘↓↓        | j                     |
| →→→        | k                     |
| ↑→         | l                     |
| ↑↑         | m                     |
| ↑↓         | n                     |
| ∘→         | o                     |
| ↓∘         | p                     |
| ∘↓→        | q                     |
| ↑∘         | r                     |
| ↓→         | s                     |
| →↓         | t                     |
| ↓↑         | u                     |
| ↓→↓        | v                     |
| ↓↓↓        | w                     |
| ↓↑→        | x                     |
| →↑         | y                     |
| →↓→        | z                     |
| →∘         | .                     |
| →∘∘        | ,                     |
| →∘∘∘       | ?                     |
| →∘∘∘∘      | !                     |
| →∘∘∘∘∘     | '                     |
| →∘∘∘∘∘∘    | @                     |
| →∘∘∘∘∘∘∘   | #                     |
| →∘∘∘∘∘∘∘∘  | $                     |
| ∘          | 1                     |
| ∘∘         | 2                     |
| ∘∘∘        | 3                     |
| ∘∘∘∘       | 4                     |
| ∘∘∘∘∘      | 5                     |
| ∘∘∘∘∘∘     | 6                     |
| ∘∘∘∘∘∘∘    | 7                     |
| ∘∘∘∘∘∘∘∘   | 8                     |
| ∘∘∘∘∘∘∘∘∘  | 9                     |
