enum TodoState { DONE, DELAY, CLOCKING }

TodoState getStateFromString(state) {
  switch (state) {
    case "DONE":
      return TodoState.DONE;
    case "DELAY":
      return TodoState.DELAY;
    case "CLOCKING":
      return TodoState.CLOCKING;
    default:
      return TodoState.DONE;
  }
}